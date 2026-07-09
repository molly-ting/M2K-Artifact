#!/usr/bin/env python3
"""
Hipify Directory Converter
Converts CUDA files to HIP format using parallel processing with thread pool.
Optionally compiles the converted HIP files.
"""

import os
import sys
import argparse
import subprocess
import shutil
from pathlib import Path
from concurrent.futures import ThreadPoolExecutor, as_completed
from typing import List, Tuple, Optional

# Extensions to process
CUDA_EXTENSIONS = {'.cu', '.cuh', '.cuda', '.cpp', '.h', '.hpp', '.c', '.cc'}

class HipifyConverter:
    def __init__(self, source_dir: str, dest_dir: str, num_workers: int = 8, 
                 tool: str = 'hipify-perl', verbose: bool = False,
                 compile: bool = False, offload_arch: str = 'gfx1030'):
        """
        Initialize the hipify converter.
        
        Args:
            source_dir: Source directory containing CUDA files
            dest_dir: Destination directory for HIP files
            num_workers: Number of worker threads
            tool: Hipify tool to use ('hipify-perl' or 'hipify-clang')
            verbose: Enable verbose output
            compile: Whether to compile HIP files after conversion
            offload_arch: GPU architecture for hipcc (e.g., gfx1030)
        """
        self.source_dir = Path(source_dir).resolve()
        self.dest_dir = Path(dest_dir).resolve()
        self.num_workers = num_workers
        self.tool = tool
        self.verbose = verbose
        self.compile = compile
        self.offload_arch = offload_arch
        
        if not self.source_dir.exists():
            raise FileNotFoundError(f"Source directory not found: {self.source_dir}")
        
        # Check if hipify tool is available
        if not self._check_tool():
            raise RuntimeError(f"{self.tool} not found. Please install HIP toolkit.")
        
        # Check if hipcc is available when compile is enabled
        if self.compile and not self._check_hipcc():
            raise RuntimeError("hipcc not found. Please install ROCm/HIP toolkit for compilation.")
    
    def _check_tool(self) -> bool:
        """Check if hipify tool is available."""
        try:
            subprocess.run([self.tool, '--version'], 
                          stdout=subprocess.PIPE, 
                          stderr=subprocess.PIPE,
                          check=False)
            return True
        except FileNotFoundError:
            return False
    
    def _check_hipcc(self) -> bool:
        """Check if hipcc compiler is available."""
        try:
            subprocess.run(['hipcc', '--version'], 
                          stdout=subprocess.PIPE, 
                          stderr=subprocess.PIPE,
                          check=False)
            return True
        except FileNotFoundError:
            return False
    
    def _get_files_to_convert(self) -> List[Path]:
        """Get all files that need to be converted."""
        files = []
        for root, _, filenames in os.walk(self.source_dir):
            for filename in filenames:
                file_path = Path(root) / filename
                if file_path.suffix in CUDA_EXTENSIONS:
                    files.append(file_path)
        return files
    
    def _get_output_path(self, input_path: Path) -> Path:
        """Calculate output path preserving directory structure."""
        rel_path = input_path.relative_to(self.source_dir)
        output_path = self.dest_dir / rel_path
        
        # Change .cu extension to .hip.cpp if using hipify-perl
        if input_path.suffix == '.cu':
            output_path = output_path.with_suffix('.hip.cpp')
        elif input_path.suffix == '.cuh':
            output_path = output_path.with_suffix('.hip.h')
        
        return output_path
    
    def _compile_hip_file(self, hip_file: Path) -> Tuple[bool, Optional[str]]:
        """
        Compile a HIP file using hipcc.
        
        Args:
            hip_file: Path to the HIP file to compile
        
        Returns:
            Tuple of (success, error_message)
        """
        # Only compile .cpp files (not headers)
        if hip_file.suffix not in {'.cpp', '.cc'}:
            return True, None
        
        # Determine output object file path
        out_file = hip_file.with_suffix('.o')
        log_file = Path(str(out_file) + '.log')
        
        try:
            print(f"  -> Compiling to: {out_file}")
            
            # Run hipcc compilation
            result = subprocess.run(
                ['hipcc', f'--offload-arch={self.offload_arch}', '-O2', '-c', '-fgpu-rdc',
                 str(hip_file), '-o', str(out_file)],
                stdout=subprocess.PIPE,
                stderr=subprocess.STDOUT,
                text=True,
                check=False
            )
            
            # Write log file
            with open(log_file, 'w') as log:
                log.write(result.stdout)
            
            if result.returncode == 0:
                print("  ✓ Compilation succeeded")
                return True, None
            else:
                error_msg = f"Compilation failed for {hip_file} (see {log_file})"
                print(f"  ✗ {error_msg}")
                return False, error_msg
                
        except Exception as e:
            error_msg = f"Exception during compilation of {hip_file}: {str(e)}"
            print(f"  ✗ {error_msg}")
            return False, error_msg
    
    def _hipify_file(self, input_path: Path) -> Tuple[bool, str, Optional[str]]:
        """
        Hipify a single file.
        
        Returns:
            Tuple of (success, input_file, error_message)
        """
        try:
            output_path = self._get_output_path(input_path)
            
            # Create output directory if it doesn't exist
            output_path.parent.mkdir(parents=True, exist_ok=True)
            
            if not output_path.exists():
                # Run hipify tool
                if self.tool == 'hipify-perl':
                    # hipify-perl reads from stdin and writes to stdout
                    result = subprocess.run(
                        [self.tool, str(input_path)],
                        stdout=subprocess.PIPE,
                        stderr=subprocess.PIPE,
                        text=True,
                        check=False
                    )
                    
                    if result.returncode == 0:
                        with open(output_path, 'w') as outfile:
                            outfile.write(result.stdout)
                    else:
                        return False, str(input_path), result.stderr
                
                else:  # hipify-clang
                    result = subprocess.run(
                        [self.tool, str(input_path), '-o', str(output_path)],
                        stdout=subprocess.PIPE,
                        stderr=subprocess.PIPE,
                        text=True,
                        check=False
                    )
                    
                    if result.returncode != 0:
                        return False, str(input_path), result.stderr
                
                if self.verbose:
                    print(f"✓ Converted: {input_path.name}")
            
            # Compile the converted file if compilation is enabled
            if self.compile and input_path.suffix == '.cu':
                compile_success, compile_error = self._compile_hip_file(output_path)
                if not compile_success:
                    return False, str(input_path), compile_error
            
            return True, str(input_path), None
            
        except Exception as e:
            return False, str(input_path), str(e)
    
    def _copy_non_cuda_files(self):
        """Copy non-CUDA files to maintain directory structure."""
        for root, dirs, filenames in os.walk(self.source_dir):
            # Calculate relative path
            rel_dir = Path(root).relative_to(self.source_dir)
            dest_root = self.dest_dir / rel_dir
            
            # Create directories
            dest_root.mkdir(parents=True, exist_ok=True)
            
            # Copy non-CUDA files
            for filename in filenames:
                file_path = Path(root) / filename
                if file_path.suffix not in CUDA_EXTENSIONS:
                    dest_file = dest_root / filename
                    try:
                        shutil.copy2(file_path, dest_file)
                        if self.verbose:
                            print(f"→ Copied: {filename}")
                    except Exception as e:
                        print(f"Warning: Failed to copy {filename}: {e}")
    
    def convert(self, copy_other_files: bool = True) -> Tuple[int, int]:
        """
        Convert all CUDA files in the source directory.
        
        Args:
            copy_other_files: Whether to copy non-CUDA files
        
        Returns:
            Tuple of (successful_conversions, failed_conversions)
        """
        files = self._get_files_to_convert()
        
        if not files:
            print("No CUDA files found to convert.")
            return 0, 0
        
        print(f"Found {len(files)} CUDA files to convert")
        print(f"Using {self.num_workers} worker threads")
        print(f"Tool: {self.tool}")
        print(f"Source: {self.source_dir}")
        print(f"Destination: {self.dest_dir}")
        print(f"Compile Flag: {'ON' if self.compile else 'OFF'}")
        print("-" * 60)
        
        successful = 0
        failed = 0
        errors = []
        
        # Process files in parallel
        with ThreadPoolExecutor(max_workers=self.num_workers) as executor:
            # Submit all tasks
            future_to_file = {
                executor.submit(self._hipify_file, file_path): file_path 
                for file_path in files
            }
            
            # Process completed tasks
            for future in as_completed(future_to_file):
                success, input_file, error = future.result()
                
                if success:
                    successful += 1
                else:
                    failed += 1
                    errors.append((input_file, error))
                    print(f"✗ Failed: {input_file}")
        
        # Copy non-CUDA files if requested
        if copy_other_files:
            print("\nCopying non-CUDA files...")
            self._copy_non_cuda_files()
        
        # Print summary
        print("-" * 60)
        print("Conversion complete!")
        print(f"  Successful: {successful}")
        print(f"  Failed: {failed}")
        
        if errors:
            print("\nErrors:")
            for input_file, error in errors:
                print(f"  {input_file}:")
                print(f"    {error}")
        
        return successful, failed


def main():
    parser = argparse.ArgumentParser(
        description="Convert CUDA files to HIP format using parallel processing",
        formatter_class=argparse.RawDescriptionHelpFormatter,
        epilog="""
Examples:
  # Basic usage
  %(prog)s /path/to/cuda/code /path/to/hip/output
  
  # Use 16 threads
  %(prog)s -j 16 cuda_src hip_dest
  
  # Use hipify-clang instead of hipify-perl
  %(prog)s -t hipify-clang cuda_src hip_dest
  
  # Convert and compile with default architecture
  %(prog)s --compile cuda_src hip_dest
  
  # Compile for specific GPU architecture
  %(prog)s --compile --offload-arch gfx908 cuda_src hip_dest
  
  # Don't copy non-CUDA files
  %(prog)s --no-copy-other cuda_src hip_dest
  
  # Verbose output
  %(prog)s -v cuda_src hip_dest
        """
    )
    
    parser.add_argument('source_dir', help='Source directory containing CUDA files')
    parser.add_argument('dest_dir', help='Destination directory for HIP files')
    parser.add_argument('-j', '--jobs', type=int, default=8,
                       help='Number of parallel jobs (default: 8)')
    parser.add_argument('-t', '--tool', choices=['hipify-perl', 'hipify-clang'],
                       default='hipify-perl',
                       help='Hipify tool to use (default: hipify-perl)')
    parser.add_argument('-v', '--verbose', action='store_true',
                       help='Enable verbose output')
    parser.add_argument('--no-copy-other', action='store_true',
                       help='Do not copy non-CUDA files')

    parser.add_argument('--offload-arch', default='gfx1030',
                       help='GPU architecture for hipcc compilation (default: gfx1030)')
    
    args = parser.parse_args()
    
    try:
        converter = HipifyConverter(
            source_dir=args.source_dir,
            dest_dir=args.dest_dir,
            num_workers=args.jobs,
            tool=args.tool,
            verbose=args.verbose,
            compile=True,
            offload_arch=args.offload_arch
        )
        
        successful, failed = converter.convert(
            copy_other_files=not args.no_copy_other
        )
        
        # Exit with error code if any conversions failed
        sys.exit(0 if failed == 0 else 1)
        
    except Exception as e:
        print(f"Error: {e}", file=sys.stderr)
        sys.exit(1)


if __name__ == '__main__':
    main()
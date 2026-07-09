#!/usr/bin/env python3

import os
import sys
import subprocess
import time
from datetime import datetime
from pathlib import Path

# Configuration
SRCBIN_DIR = "./srcbin"
RUN_DIR = "./run"
GKLEE_CMD = "gklee"
TIMEOUT_SECONDS = 3600  # 1 hour
RESULTS_FILE = "gklee_results.txt"

def ensure_dir(directory):
    """Create directory if it doesn't exist."""
    Path(directory).mkdir(parents=True, exist_ok=True)

def format_duration(seconds):
    """Format duration in human-readable format."""
    hours = int(seconds // 3600)
    minutes = int((seconds % 3600) // 60)
    secs = int(seconds % 60)
    return f"{hours:02d}:{minutes:02d}:{secs:02d}"

def run_gklee(binary_path, output_dir, results_file):
    """Run GKLEE on a binary with timeout."""
    binary_name = os.path.basename(binary_path)
    
    print(f"\n{'='*60}")
    print(f"Running GKLEE on: {binary_name}")
    print(f"Output directory: {output_dir}")
    print(f"{'='*60}")
    
    # Record start time
    start_time = time.time()
    start_datetime = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    
    # Prepare command
    cmd = [GKLEE_CMD, binary_path]
    
    # Run GKLEE with timeout
    status = "SUCCESS"
    error_msg = ""
    
    try:
        result = subprocess.run(
            cmd,
            cwd=output_dir,
            stdout=subprocess.PIPE,
            stderr=subprocess.PIPE,
            timeout=TIMEOUT_SECONDS,
            text=True
        )
        
        # Save output
        stdout_file = os.path.join(output_dir, "stdout.txt")
        stderr_file = os.path.join(output_dir, "stderr.txt")
        
        with open(stdout_file, 'w') as f:
            f.write(result.stdout)
        
        with open(stderr_file, 'w') as f:
            f.write(result.stderr)
        
        if result.returncode != 0:
            status = "FAILED"
            error_msg = f"Exit code: {result.returncode}"
            print(f"  ✗ FAILED with exit code {result.returncode}")
        else:
            print("  ✓ SUCCESS")
            
    except subprocess.TimeoutExpired:
        status = "TIMEOUT"
        error_msg = f"Exceeded {TIMEOUT_SECONDS}s timeout"
        print(f"  ⏱ TIMEOUT (exceeded {TIMEOUT_SECONDS}s)")
        
        # Save timeout info
        timeout_file = os.path.join(output_dir, "timeout.txt")
        with open(timeout_file, 'w') as f:
            f.write(f"GKLEE execution timed out after {TIMEOUT_SECONDS} seconds\n")
            f.write(f"Binary: {binary_path}\n")
            f.write(f"Start time: {start_datetime}\n")
            
    except Exception as e:
        status = "ERROR"
        error_msg = str(e)
        print(f"  ✗ ERROR: {e}")
        
        # Save error info
        error_file = os.path.join(output_dir, "error.txt")
        with open(error_file, 'w') as f:
            f.write(f"Error running GKLEE: {e}\n")
            f.write(f"Binary: {binary_path}\n")
    
    # Record end time
    end_time = time.time()
    end_datetime = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    duration = end_time - start_time
    
    print(f"  Duration: {format_duration(duration)}")
    
    # Write results to file
    with open(results_file, 'a') as f:
        f.write(f"\n{'='*80}\n")
        f.write(f"Binary: {binary_name}\n")
        f.write(f"Status: {status}\n")
        f.write(f"Start:  {start_datetime}\n")
        f.write(f"End:    {end_datetime}\n")
        f.write(f"Duration: {format_duration(duration)} ({duration:.2f}s)\n")
        if error_msg:
            f.write(f"Error: {error_msg}\n")
        f.write(f"Output: {output_dir}\n")
    
    return status, duration

def main():
    """Main function to run GKLEE on all binaries."""
    
    # Check if a specific binary is provided as argument
    if len(sys.argv) > 1:
        binary_path = sys.argv[1]
        
        # Check if file exists
        if not os.path.isfile(binary_path):
            print(f"Error: Binary file '{binary_path}' does not exist!")
            return 1
        
        # Convert to absolute path
        binary_path = os.path.abspath(binary_path)
        binary_name = os.path.basename(binary_path)
        
        # Create run directory
        ensure_dir(RUN_DIR)
        
        # Create output directory for this binary
        output_dir = os.path.join(RUN_DIR, binary_name)
        ensure_dir(output_dir)
        
        # Initialize results file
        results_file = os.path.join(RUN_DIR, RESULTS_FILE)
        with open(results_file, 'w') as f:
            f.write("GKLEE Execution Results\n")
            f.write(f"Generated: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}\n")
            f.write(f"Binary: {binary_path}\n")
            f.write(f"Timeout: {TIMEOUT_SECONDS}s ({TIMEOUT_SECONDS//3600}h)\n")
        
        print(f"\nRunning GKLEE on single binary: {binary_name}")
        print(f"Timeout: {TIMEOUT_SECONDS}s ({TIMEOUT_SECONDS//3600}h)")
        print(f"Results will be saved to: {results_file}")
        
        # Run GKLEE on the specified binary
        status, duration = run_gklee(binary_path, output_dir, results_file)
        
        # Print summary
        print(f"\n{'='*60}")
        print("SUMMARY")
        print(f"{'='*60}")
        print(f"Binary: {binary_name}")
        print(f"Status: {status}")
        print(f"Duration: {format_duration(duration)}")
        print(f"{'='*60}")
        
        # Append summary to results file
        with open(results_file, 'a') as f:
            f.write(f"\n{'='*80}\n")
            f.write("SUMMARY\n")
            f.write(f"{'='*80}\n")
            f.write(f"Status: {status}\n")
            f.write(f"Duration: {format_duration(duration)} ({duration:.2f}s)\n")
            f.write(f"Completed: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}\n")
        
        print(f"\nResults saved to: {results_file}")
        
        return 0 if status == "SUCCESS" else 1
    
    # Original behavior: process all binaries in SRCBIN_DIR
    # Check if srcbin directory exists
    if not os.path.isdir(SRCBIN_DIR):
        print(f"Error: Directory {SRCBIN_DIR} does not exist!")
        return 1
    
    # Create run directory
    ensure_dir(RUN_DIR)
    
    # Find all binaries (files without extension)
    binaries = []
    for item in os.listdir(SRCBIN_DIR):
        item_path = os.path.join(SRCBIN_DIR, item)
        # Check if it's a file and executable (or no extension)
        if os.path.isfile(item_path) and '.' not in item:
            binaries.append(os.path.abspath(item_path))
    
    if not binaries:
        print(f"No binaries found in {SRCBIN_DIR}")
        return 0
    
    binaries.sort()
    
    # Initialize results file
    results_file = os.path.join(RUN_DIR, RESULTS_FILE)
    with open(results_file, 'w') as f:
        f.write("GKLEE Execution Results\n")
        f.write(f"Generated: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}\n")
        f.write(f"Total binaries: {len(binaries)}\n")
        f.write(f"Timeout: {TIMEOUT_SECONDS}s ({TIMEOUT_SECONDS//3600}h)\n")
    
    print(f"\nFound {len(binaries)} binaries to process")
    print(f"Timeout: {TIMEOUT_SECONDS}s ({TIMEOUT_SECONDS//3600}h)")
    print(f"Results will be saved to: {results_file}")
    
    # Statistics
    stats = {
        "SUCCESS": 0,
        "FAILED": 0,
        "TIMEOUT": 0,
        "ERROR": 0
    }
    total_time = 0
    
    # Process each binary
    for idx, binary_path in enumerate(binaries, 1):
        binary_name = os.path.basename(binary_path)
        output_dir = os.path.join(RUN_DIR, binary_name)
        if os.path.exists(output_dir):
            print(f"  → Skipping {binary_name}, output directory already exists.")
            continue
        ensure_dir(output_dir)
        
        print(f"\n[{idx}/{len(binaries)}] Processing {binary_name}...")
        
        status, duration = run_gklee(binary_path, output_dir, results_file)
        stats[status] += 1
        total_time += duration
    
    # Write summary
    print(f"\n{'='*60}")
    print("SUMMARY")
    print(f"{'='*60}")
    print(f"Total binaries: {len(binaries)}")
    print(f"Success: {stats['SUCCESS']}")
    print(f"Failed:  {stats['FAILED']}")
    print(f"Timeout: {stats['TIMEOUT']}")
    print(f"Error:   {stats['ERROR']}")
    print(f"Total time: {format_duration(total_time)}")
    print(f"{'='*60}")
    
    # Append summary to results file
    with open(results_file, 'a') as f:
        f.write(f"\n{'='*80}\n")
        f.write("SUMMARY\n")
        f.write(f"{'='*80}\n")
        f.write(f"Total binaries: {len(binaries)}\n")
        f.write(f"Success: {stats['SUCCESS']}\n")
        f.write(f"Failed:  {stats['FAILED']}\n")
        f.write(f"Timeout: {stats['TIMEOUT']}\n")
        f.write(f"Error:   {stats['ERROR']}\n")
        f.write(f"Total time: {format_duration(total_time)} ({total_time:.2f}s)\n")
        f.write(f"Completed: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}\n")
    
    print(f"\nResults saved to: {results_file}")
    
    return 0 if stats['FAILED'] == 0 and stats['ERROR'] == 0 else 1

if __name__ == "__main__":
    exit(main())
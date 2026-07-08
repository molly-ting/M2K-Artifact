import os
import subprocess
import logging
from concurrent.futures import ProcessPoolExecutor, as_completed

TIMEOUT_LIMIT = 6*60*60
MAX_ENTRIES = 4

def run_klee_on_json_file(json_file, logDir, outputdir, useDirName=False):
    one_timeout = 3600
    try:
        # Ensure output directory exists
        os.makedirs(logDir, exist_ok=True)
        
        # Create a log file for this specific KLEE run (output and error)
        if useDirName:
            dir_name = os.path.basename(os.path.dirname(json_file))
            log_file = os.path.join(logDir, dir_name + '_klee_output.log')
            outputdir = os.path.join(outputdir, dir_name)
            os.makedirs(outputdir, exist_ok=True)
        else:
            log_file = os.path.join(logDir, os.path.splitext(os.path.basename(json_file))[0] + '_klee_output.log')
        if os.path.exists(log_file):
            return True         
        
        # Run KLEE and capture its output and error in the log file
        with open(log_file, 'w') as output_file:
            subprocess.run(['cuKLEE', f"--timeout={one_timeout}", f"--output-dir={outputdir}", f"--max-entry={MAX_ENTRIES}", json_file], stdout=output_file, stderr=output_file, timeout=TIMEOUT_LIMIT, check=True)
        
        with open(log_file, 'r') as output_file:
            log_content = output_file.read()
            # if 'Aborted (core dumped)' in log_content:
            #     print(f"cuKLEE aborted on {bc_file}. See log for details.")
            #     logging.error(f"cuKLEE aborted (core dumped) on {bc_file}.")
            #     return False
            if "KLEE: done: completed paths =" not in log_content:
                print(f"cuKLEE not complete on {json_file}. See log for details.")
                logging.error(f"cuKLEE not complete on {json_file}.")
                return False
            else:
                print(f"Successfully ran cuKLEE on {json_file}. Output saved to {log_file}")
                return True
    
    except subprocess.TimeoutExpired:
        # Handle the timeout error
        logging.error(f"cuKLEE run on {json_file} timed out after {TIMEOUT_LIMIT} seconds.")
        print(f"cuKLEE run on {json_file} timed out after {TIMEOUT_LIMIT} seconds. See log for details.")
        return False

    except subprocess.CalledProcessError as e:
        # Log the error if KLEE throws an exception
        logging.error(f"Error running cuKLEE on {json_file}: {str(e)}")
        print(f"Error running cuKLEE on {json_file}. See log for details.")
        return False

def run_klee_on_bc_file(bc_file, logDir, outputdir):
    one_timeout = 3600
    try:
        os.makedirs(logDir, exist_ok=True)

        log_file = os.path.join(logDir, os.path.splitext(os.path.basename(bc_file))[0] + '_klee_output.log')
        if os.path.exists(log_file):
            return True         

        outputdir = os.path.join(outputdir, os.path.splitext(os.path.basename(bc_file))[0])
        os.makedirs(outputdir, exist_ok=True)
        
        # Run KLEE and capture its output and error in the log file
        with open(log_file, 'w') as output_file:
            subprocess.run(['cuKLEE', f"--timeout={one_timeout}", f"--output-dir={outputdir}", bc_file], stdout=output_file, stderr=output_file, check=True) 
        
        with open(log_file, 'r') as output_file:
            log_content = output_file.read()
            # if 'Aborted (core dumped)' in log_content:
            #     print(f"cuKLEE aborted on {bc_file}. See log for details.")
            #     logging.error(f"cuKLEE aborted (core dumped) on {bc_file}.")
            #     return False
            if "KLEE: done: completed paths =" not in log_content:
                print(f"cuKLEE not complete on {bc_file}. See log for details.")
                logging.error(f"cuKLEE not complete on {bc_file}.")
                return False
            else:
                print(f"Successfully ran cuKLEE on {bc_file}. Output saved to {log_file}")
                return True
    
    except subprocess.TimeoutExpired:
        # Handle the timeout error
        logging.error(f"cuKLEE run on {bc_file} timed out after {TIMEOUT_LIMIT} seconds.")
        print(f"cuKLEE run on {bc_file} timed out after {TIMEOUT_LIMIT} seconds. See log for details.")
        return False

    except subprocess.CalledProcessError as e:
        # Log the error if cuKLEE throws an exception
        logging.error(f"Error running cuKLEE on {bc_file}: {str(e)}")
        print(f"Error running cuKLEE on {bc_file}. See log for details.")
        return False

def main(directory, logDir, outputdir, isJson=True, max_processes=5, json_files=None, useDirName=False):
    failed_files = []
    if not json_files:
        if isJson:
            json_files = [os.path.join(directory, filename) for filename in os.listdir(directory) if filename.endswith('.json')]
        else:
            json_files = [os.path.join(directory, filename) for filename in os.listdir(directory) if filename.endswith('_combined.bc')]
    total = len(json_files)
    
    with ProcessPoolExecutor(max_processes) as executor:
        future_to_file = {executor.submit(run_klee_on_json_file, json_file, logDir, outputdir, useDirName): json_file for json_file in json_files} # if json_file not in filter_files
        
        for future in as_completed(future_to_file):
            json_file = future_to_file[future]
            try:
                success = future.result()
                if not success:
                    failed_files.append(os.path.basename(json_file))
            except Exception as e:
                logging.error(f"Exception occurred while processing {json_file}: {str(e)}")
                failed_files.append(os.path.basename(json_file))
    
    print(failed_files)
    print("total:", total, "failed:", len(failed_files))

def main_single(directory, logDir, outputdir, isJson=True, useDirName=False):
    failed_files = []
    if isJson:
        json_files = [os.path.join(directory, filename) for filename in os.listdir(directory) if filename.endswith('.json')]
    else:
        json_files = [os.path.join(directory, filename) for filename in os.listdir(directory) if filename.endswith('_combined.bc')]
    
    total = len(json_files)

    for f in json_files:
        success = run_klee_on_json_file(f, logDir, outputdir, useDirName)
        if not success:
            failed_files.append(f)
    
    print(failed_files)
    print("total:", total, "failed:", len(failed_files))


if __name__ == "__main__":
    directory_path = "/home/mvh6224/CUDA-BOSolver/HFProbe/vllm-exp/input" 
    output_directory = "/home/mvh6224/CUDA-BOSolver/scripts/tmp_output"
    log_directory = "/home/mvh6224/CUDA-BOSolver/scripts/vllm_log"
    os.makedirs(output_directory, exist_ok=True)
    main(directory_path, log_directory, output_directory, True, 5) 
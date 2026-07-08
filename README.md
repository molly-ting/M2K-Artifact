# The code and data for SOSP 2026 Artifact Evaluation

excels/exp1.xlsx results of section 6.1
excels/coverage.xlsx dataset and results of section 6.2
excels/ablation.xlsx results of section 6.3
excels/bug-memory.xlsx data of figure 5

compile one cuda file:
python3 scripts/compile_cuda.py --input-file <input_filepath> --out-dir <output_directory>

compile cuda files in one directory:
python3 scripts/compile_cuda.py --input-dir <input_dirpath> --out-dir <output_directory>
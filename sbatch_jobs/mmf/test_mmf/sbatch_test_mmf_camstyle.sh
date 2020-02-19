#!/bin/env bash
#SBATCH --job-name=CAMStyle-ReidMMFWithCamstyle
#SBATCH --partition=gpu
#SBATCH --ntasks=8
#SBATCH --mem-per-cpu=16G
#SBATCH --gres gpu:1
#SBATCH --time=3:00:00
#SBATCH --output=/users/40057686/sharedscratch/logs/CAMStyle-ReidMMFWithCamstyle-%j.log

python main.py --data-dir ~/sharedscratch/datasets \
    -d mmf6 --logs-dir ~/sharedscratch/logs/cycleganreidmmfwithcamstyle \
    --camstyle_path ~/sharedscratch/camstyle_mmf_cyclegans_gen
    --camstyle 46
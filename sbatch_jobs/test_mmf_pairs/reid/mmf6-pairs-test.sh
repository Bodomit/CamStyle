#!/bin/env bash
#SBATCH --job-name=CAMStyle-MMF6Pairs-Test
#SBATCH --partition=gpu
#SBATCH --ntasks=8
#SBATCH --mem-per-cpu=16G
#SBATCH --gres gpu:1
#SBATCH --time=24:00:00
#SBATCH --output=/users/40057686/sharedscratch/logs/CAMStyle-MMF6Pairs-Test-%j.log

python main.py --data-dir ~/sharedscratch/datasets \
    -d mmf6-pairs \
    --logs-dir ~/sharedscratch/logs/CAMStyle-MMF6Pairs-Test-Reid \
    --camstyle_path ~/sharedscratch/results/camstyle_mmf6_pairs_gen \
#!/bin/env bash
#SBATCH --job-name=CAMStyle-MMF6IndiCam10-Test
#SBATCH --partition=gpu
#SBATCH --ntasks=8
#SBATCH --mem-per-cpu=16G
#SBATCH --gres gpu:1
#SBATCH --time=24:00:00
#SBATCH --output=/users/40057686/sharedscratch/logs/CAMStyle-MMF6IndiCam10-Test-Camstyle-Re05-%j.log

python main.py --data-dir ~/sharedscratch/datasets \
    -d mmf6-indicam-10 \
    --logs-dir ~/sharedscratch/logs/CAMStyle-MMF6IndiCam10-Test-Reid-CamStyle46-Re05 \
    --camstyle_path ~/sharedscratch/results/camstyle_mmf6-indicam-10_gen \
    --camstyle 46 \
    --re 0.5
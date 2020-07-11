#!/bin/env bash
#SBATCH --job-name=CAM-ChokePoint
#SBATCH --partition=gpu
#SBATCH --ntasks=4
#SBATCH --mem-per-cpu=16G
#SBATCH --gres gpu:1
#SBATCH --time=48:00:00
#SBATCH --output=/users/40057686/sharedscratch/logs/CAMStyle-CyclesChokePoint-%j.log

module add nvidia-cuda
conda activate camstyle

nvidia-smi

echo "cam-a=$camA"
echo "cam-b=$camB"

cd CycleGAN-for-CamStyle
pwd

python train.py --dataroot ~/sharedscratch/datasets/chokepoint_png \
                --name "chokepoint-$camA-$camB" --camA $camA --camB $camB \
                --dataset_mode chokepoint \
                --checkpoints_dir ~/sharedscratch/results/camstyle_train_chokepoint/

python test.py --dataroot ~/sharedscratch/datasets/chokepoint_png \
               --name "chokepoint-$camA-$camB" --camA $camA --camB $camB \
               --save_root ~/sharedscratch/results/camstyle_chokepoint/camstyle_gen_chokepoint/ \
               --checkpoints_dir ~/sharedscratch/results/camstyle_chokepoint/camstyle_train_chokepoint/ \
               --dataset_mode chokepoint \
               --maintain-dir-structure



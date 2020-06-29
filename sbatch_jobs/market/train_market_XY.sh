#!/bin/env bash
#SBATCH --job-name=CAM-MARKET
#SBATCH --partition=gpu
#SBATCH --ntasks=4
#SBATCH --mem-per-cpu=16G
#SBATCH --gres gpu:1
#SBATCH --time=48:00:00
#SBATCH --output=/users/40057686/sharedscratch/logs/CAMStyle-CyclesMarket-%j.log

module add nvidia-cuda
conda activate camstyle

nvidia-smi

echo "cam-a=$camA"
echo "cam-b=$camB"

cd CycleGAN-for-CamStyle

python train.py --dataroot ~/sharedscratch/datasets/Market-1501-v15.09.15 \
                --name "market-c$camA-c$camB" --camA $camA --camB $camB \
                --checkpoints_dir ~/sharedscratch/results/camstyle_train_market/

python test.py --dataroot ~/sharedscratch/datasets/Market-1501-v15.09.15 \
               --name "market-c$camA-c$camB" --camA $camA --camB $camB \
               --save_root ~/sharedscratch/results/camstyle_gen_market/ \
               --checkpoints_dir ~/sharedscratch/results/camstyle_train_market/
               --subset bounding_box_train

python test.py --dataroot ~/sharedscratch/datasets/Market-1501-v15.09.15 \
               --name "market-c$camA-c$camB" --camA $camA --camB $camB \
               --save_root ~/sharedscratch/results/camstyle_gen_market/ \
               --checkpoints_dir ~/sharedscratch/results/camstyle_train_market/
               --subset bounding_box_test

python test.py --dataroot ~/sharedscratch/datasets/Market-1501-v15.09.15 \
               --name "market-c$camA-c$camB" --camA $camA --camB $camB \
               --save_root ~/sharedscratch/results/camstyle_gen_market/ \
               --checkpoints_dir ~/sharedscratch/results/camstyle_train_market/
               --subset query

python test.py --dataroot ~/sharedscratch/datasets/Market-1501-v15.09.15 \
               --name "market-c$camA-c$camB" --camA $camA --camB $camB \
               --save_root ~/sharedscratch/results/camstyle_gen_market/ \
               --checkpoints_dir ~/sharedscratch/results/camstyle_train_market/
               --subset gt_bbox



#!/bin/env bash
#SBATCH --job-name=CAM-CoxFaceDb
#SBATCH --partition=gpu
#SBATCH --ntasks=4
#SBATCH --mem-per-cpu=16G
#SBATCH --gres gpu:1
#SBATCH --time=48:00:00
#SBATCH --output=/users/40057686/sharedscratch/logs/CAMStyle-CyclesCoxFaceDb-%j.log

module add nvidia-cuda

nvidia-smi

echo "cam-a=$camA"
echo "cam-b=$camB"

cd CycleGAN-for-CamStyle
pwd

python train.py --dataroot ~/sharedscratch/datasets/coxfacedb/data2/original_still_video/video/ \
                --name "coxfacedb-$camA-$camB" --camA $camA --camB $camB \
                --dataset_mode coxfacedb \
                --checkpoints_dir ~/sharedscratch/results/camstyle_coxfacedb/camstyle_train_coxfacedb/ \
                --coxfacedb-partition-dir ~/sharedscratch/datasets/coxfacedb/test_file/V2S_partitions \
                --coxfacedb-partition 0

python test.py --dataroot ~/sharedscratch/datasets/coxfacedb/data2/original_still_video/video/ \
               --name "coxfacedb-$camA-$camB" --camA $camA --camB $camB \
               --save_root ~/sharedscratch/results/camstyle_coxfacedb/camstyle_gen_coxfacedb/ \
               --checkpoints_dir ~/sharedscratch/results/camstyle_coxfacedb/camstyle_train_coxfacedb/ \
               --dataset_mode coxfacedb \
               --maintain-dir-structure \
               --coxfacedb-partition-dir ~/sharedscratch/datasets/coxfacedb/test_file/V2S_partitions \
               --coxfacedb-partition 0



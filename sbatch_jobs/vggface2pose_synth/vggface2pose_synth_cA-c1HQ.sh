#!/bin/env bash
#SBATCH --job-name=CAMStyle-TrainCyclesVGGFace2PoseSynth-cA-c1HQ
#SBATCH --partition=gpu
#SBATCH --ntasks=4
#SBATCH --mem-per-cpu=16G
#SBATCH --gres gpu:1
#SBATCH --time=240:00:00
#SBATCH --output=/users/40057686/sharedscratch/logs/CAMStyle-TrainVGGFace2PoseSynth-cA-c1HQ-%j.log

module add nvidia-cuda
conda activate camstyle1

nvidia-smi

ROOT_DATASET_DIR=~/datasets
RESULTS_DIR=~/results

echo $ROOT_DATASET_DIR
echo $RESULTS_DIR

cd ./CycleGAN-for-CamStyle && pwd

python train.py --dataroot $ROOT_DATASET_DIR/vggface2pose_synth --name "vggface2pose_synth-A-1" --camA A --camB 1 \
                --dataset_mode unaligned_filtered \
                --filter-dataset "camB" \
                --path-filter ".+_256.png$" \
                --phase "" \
                --checkpoints_dir $RESULTS_DIR/camstyle_vggface2pose_synth_cyclegans_train/


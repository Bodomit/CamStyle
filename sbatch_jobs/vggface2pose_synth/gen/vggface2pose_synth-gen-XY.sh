#!/bin/env bash
#SBATCH --job-name=CAMStyle-TrainCyclesVGGFace2PoseSynth
#SBATCH --partition=gpu
#SBATCH --ntasks=4
#SBATCH --mem-per-cpu=16G
#SBATCH --gres gpu:1
#SBATCH --time=24:00:00
#SBATCH --output=/users/40057686/sharedscratch/logs/CAMStyle-TrainVGGFace2PoseSynthMMF-%j.log

module add nvidia-cuda
conda activate camstyle1

nvidia-smi

ROOT_DATASET_DIR=~/datasets
RESULTS_DIR=~/results

echo $ROOT_DATASET_DIR
echo $RESULTS_DIR

echo "camA=$camA"
echo "camB=$camB"

cd ./CycleGAN-for-CamStyle && pwd

python train.py --dataroot $ROOT_DATASET_DIR/vggface2pose_synth --name "vggface2pose_synth-$camA-$camB" --camA $camA --camB $camB --dataset_mode unaligned --phase "" --checkpoints_dir $RESULTS_DIR/camstyle_vggface2pose_synth_cyclegans_train/


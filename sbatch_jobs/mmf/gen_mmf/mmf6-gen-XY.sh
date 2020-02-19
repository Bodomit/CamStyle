#!/bin/env bash
#SBATCH --job-name=CAMStyle-TrainCyclesMMF
#SBATCH --partition=gpu
#SBATCH --ntasks=4
#SBATCH --mem-per-cpu=16G
#SBATCH --gres gpu:1
#SBATCH --time=3:00:00
#SBATCH --output=/users/40057686/sharedscratch/logs/CAMStyle-TrainCyclesMMF-%j.log

module add nvidia-cuda
conda activate camstyle1

nvidia-smi

if [ -z "${ROOT_DATASET_DIR}" ]; then 
    ROOT_DATASET_DIR=~/sharedscratch/datasets
else 
    ROOT_DATASET_DIR=${ROOT_DATASET_DIR}
fi

if [ -z "${RESULTS_DIR}" ]; then 
    RESULTS_DIR=~/results
else 
    RESULTS_DIR=${RESULTS_DIR}
fi

echo $ROOT_DATASET_DIR
echo $RESULTS_DIR

echo "camA=$camA"
echo "camB=$camB"

cd ./CycleGAN-for-CamStyle && pwd
python test.py --dataroot $ROOT_DATASET_DIR/mmf6 --name "mmf6-$camA-$camB" --camA $camA --camB $camB --save_root ~/sharedscratch/camstyle_mmf_cyclegans_gen --dataset_mode unaligned --phase "" --checkpoints_dir $RESULTS_DIR/camstyle_mmf_cyclegans_train/


#!/bin/env bash
#SBATCH --job-name=CAMStyle-MMF6IndiCam10-Gen-Test
#SBATCH --partition=gpu
#SBATCH --ntasks=4
#SBATCH --mem-per-cpu=16G
#SBATCH --gres gpu:1
#SBATCH --time=2:00:00
#SBATCH --output=/users/40057686/sharedscratch/logs/CAMStyle-GenMMF6IndiCam10-Test-%j.log

module add nvidia-cuda
module add compilers/gcc/7.2.0
conda activate camstyle3

nvidia-smi

if [ -z "${ROOT_DATASET_DIR}" ]; then 
    ROOT_DATASET_DIR=~/sharedscratch/datasets
else 
    ROOT_DATASET_DIR=${ROOT_DATASET_DIR}
fi

if [ -z "${RESULTS_DIR}" ]; then 
    RESULTS_DIR=~/sharedscratch/results/
else 
    RESULTS_DIR=${RESULTS_DIR}
fi

echo $ROOT_DATASET_DIR
echo $RESULTS_DIR

echo "camA=$camA"
echo "camB=$camB"

cd ./CycleGAN-for-CamStyle && pwd
python test.py --dataroot $ROOT_DATASET_DIR/mmf6-test --name "mmf6-indicam-10-$camA-$camB" --camA $camA --camB $camB --save_root ~/sharedscratch/results/camstyle_mmf6-test_indicam-10_gen --dataset_mode unaligned --phase "" --checkpoints_dir $RESULTS_DIR/camstyle_mmf6-indicam_10_cyclegans_train/

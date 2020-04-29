#!/bin/env bash
#SBATCH --job-name=CAMStyle-MMF6Pairs10-Gen-Bidirectional
#SBATCH --partition=gpu
#SBATCH --ntasks=4
#SBATCH --mem-per-cpu=16G
#SBATCH --gres gpu:1
#SBATCH --time=2:00:00
#SBATCH --output=/users/40057686/sharedscratch/logs/CAMStyle-GenMMF6Pairs10-Bidirectional-%j.log

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
python test.py --dataroot $ROOT_DATASET_DIR/mmf6-pairs-10 --name "mmf6-pairs-10-$camA-$camB" --camA $camA --camB $camB --save_root ~/sharedscratch/results/camstyle_mmf6_pairs_10_gen_bidi --dataset_mode unaligned --phase "" --checkpoints_dir $RESULTS_DIR/camstyle_mmf6_pairs_10_cyclegans_train/


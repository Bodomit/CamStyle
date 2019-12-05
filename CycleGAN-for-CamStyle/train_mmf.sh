# train all cameras for mmf

if [ -z "${ROOT_DATASET_DIR}" ]; then 
    ROOT_DATASET_DIR=~/datasets
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

python train.py --dataroot $ROOT_DATASET_DIR/mmf --name mmf-A-B --dataset_mode unaligned --phase "" --checkpoints_dir $RESULTS_DIR/camstyle_mmf_cyclegans_train/

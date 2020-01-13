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

python train.py --dataroot $ROOT_DATASET_DIR/mmf6 --name mmf6-A-B --camA A --camB B --dataset_mode unaligned --phase "" --checkpoints_dir $RESULTS_DIR/camstyle_mmf_cyclegans_train/ --niter 5 --niter_decay 0
python train.py --dataroot $ROOT_DATASET_DIR/mmf6 --name mmf6-A-C --camA A --camB C --dataset_mode unaligned --phase "" --checkpoints_dir $RESULTS_DIR/camstyle_mmf_cyclegans_train/ --niter 5 --niter_decay 0
python train.py --dataroot $ROOT_DATASET_DIR/mmf6 --name mmf6-A-1 --camA A --camB 1 --dataset_mode unaligned --phase "" --checkpoints_dir $RESULTS_DIR/camstyle_mmf_cyclegans_train/ --niter 5 --niter_decay 0
python train.py --dataroot $ROOT_DATASET_DIR/mmf6 --name mmf6-A-2 --camA A --camB 2 --dataset_mode unaligned --phase "" --checkpoints_dir $RESULTS_DIR/camstyle_mmf_cyclegans_train/ --niter 5 --niter_decay 0
python train.py --dataroot $ROOT_DATASET_DIR/mmf6 --name mmf6-A-3 --camA A --camB 3 --dataset_mode unaligned --phase "" --checkpoints_dir $RESULTS_DIR/camstyle_mmf_cyclegans_train/ --niter 5 --niter_decay 0

python train.py --dataroot $ROOT_DATASET_DIR/mmf6 --name mmf6-B-C --camA B --camB C --dataset_mode unaligned --phase "" --checkpoints_dir $RESULTS_DIR/camstyle_mmf_cyclegans_train/ --niter 5 --niter_decay 0
python train.py --dataroot $ROOT_DATASET_DIR/mmf6 --name mmf6-B-1 --camA B --camB 1 --dataset_mode unaligned --phase "" --checkpoints_dir $RESULTS_DIR/camstyle_mmf_cyclegans_train/ --niter 5 --niter_decay 0
python train.py --dataroot $ROOT_DATASET_DIR/mmf6 --name mmf6-B-2 --camA B --camB 2 --dataset_mode unaligned --phase "" --checkpoints_dir $RESULTS_DIR/camstyle_mmf_cyclegans_train/ --niter 5 --niter_decay 0
python train.py --dataroot $ROOT_DATASET_DIR/mmf6 --name mmf6-B-3 --camA B --camB 3 --dataset_mode unaligned --phase "" --checkpoints_dir $RESULTS_DIR/camstyle_mmf_cyclegans_train/ --niter 5 --niter_decay 0

python train.py --dataroot $ROOT_DATASET_DIR/mmf6 --name mmf6-C-1 --camA C --camB 1 --dataset_mode unaligned --phase "" --checkpoints_dir $RESULTS_DIR/camstyle_mmf_cyclegans_train/ --niter 5 --niter_decay 0
python train.py --dataroot $ROOT_DATASET_DIR/mmf6 --name mmf6-C-2 --camA C --camB 2 --dataset_mode unaligned --phase "" --checkpoints_dir $RESULTS_DIR/camstyle_mmf_cyclegans_train/ --niter 5 --niter_decay 0
python train.py --dataroot $ROOT_DATASET_DIR/mmf6 --name mmf6-C-3 --camA C --camB 3 --dataset_mode unaligned --phase "" --checkpoints_dir $RESULTS_DIR/camstyle_mmf_cyclegans_train/ --niter 5 --niter_decay 0

python train.py --dataroot $ROOT_DATASET_DIR/mmf6 --name mmf6-1-2 --camA 1 --camB 2 --dataset_mode unaligned --phase "" --checkpoints_dir $RESULTS_DIR/camstyle_mmf_cyclegans_train/ --niter 5 --niter_decay 0
python train.py --dataroot $ROOT_DATASET_DIR/mmf6 --name mmf6-1-3 --camA 1 --camB 3 --dataset_mode unaligned --phase "" --checkpoints_dir $RESULTS_DIR/camstyle_mmf_cyclegans_train/ --niter 5 --niter_decay 0

python train.py --dataroot $ROOT_DATASET_DIR/mmf6 --name mmf6-2-3 --camA 2 --camB 3 --dataset_mode unaligned --phase "" --checkpoints_dir $RESULTS_DIR/camstyle_mmf_cyclegans_train/ --niter 5 --niter_decay 0

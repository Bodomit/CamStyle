# test all cameras for market

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

python test.py --dataroot $ROOT_DATASET_DIR/market --name market-c1-c2 --camA 1 --camB 2 --save_root $RESULTS_DIR/camstyle_market_cyclegans_test --checkpoints_dir $RESULTS_DIR/camstyle_market_cyclegans_train/
python test.py --dataroot $ROOT_DATASET_DIR/market --name market-c1-c3 --camA 1 --camB 3 --save_root $RESULTS_DIR/camstyle_market_cyclegans_test --checkpoints_dir $RESULTS_DIR/camstyle_market_cyclegans_train/
python test.py --dataroot $ROOT_DATASET_DIR/market --name market-c1-c4 --camA 1 --camB 4 --save_root $RESULTS_DIR/camstyle_market_cyclegans_test --checkpoints_dir $RESULTS_DIR/camstyle_market_cyclegans_train/
python test.py --dataroot $ROOT_DATASET_DIR/market --name market-c1-c5 --camA 1 --camB 5 --save_root $RESULTS_DIR/camstyle_market_cyclegans_test --checkpoints_dir $RESULTS_DIR/camstyle_market_cyclegans_train/
python test.py --dataroot $ROOT_DATASET_DIR/market --name market-c1-c6 --camA 1 --camB 6 --save_root $RESULTS_DIR/camstyle_market_cyclegans_test --checkpoints_dir $RESULTS_DIR/camstyle_market_cyclegans_train/

python test.py --dataroot $ROOT_DATASET_DIR/market --name market-c2-c3 --camA 2 --camB 3 --save_root $RESULTS_DIR/camstyle_market_cyclegans_test --checkpoints_dir $RESULTS_DIR/camstyle_market_cyclegans_train/
python test.py --dataroot $ROOT_DATASET_DIR/market --name market-c2-c4 --camA 2 --camB 4 --save_root $RESULTS_DIR/camstyle_market_cyclegans_test --checkpoints_dir $RESULTS_DIR/camstyle_market_cyclegans_train/
python test.py --dataroot $ROOT_DATASET_DIR/market --name market-c2-c5 --camA 2 --camB 5 --save_root $RESULTS_DIR/camstyle_market_cyclegans_test --checkpoints_dir $RESULTS_DIR/camstyle_market_cyclegans_train/
python test.py --dataroot $ROOT_DATASET_DIR/market --name market-c2-c6 --camA 2 --camB 6 --save_root $RESULTS_DIR/camstyle_market_cyclegans_test --checkpoints_dir $RESULTS_DIR/camstyle_market_cyclegans_train/

python test.py --dataroot $ROOT_DATASET_DIR/market --name market-c3-c4 --camA 3 --camB 4 --save_root $RESULTS_DIR/camstyle_market_cyclegans_test --checkpoints_dir $RESULTS_DIR/camstyle_market_cyclegans_train/
python test.py --dataroot $ROOT_DATASET_DIR/market --name market-c3-c5 --camA 3 --camB 5 --save_root $RESULTS_DIR/camstyle_market_cyclegans_test --checkpoints_dir $RESULTS_DIR/camstyle_market_cyclegans_train/
python test.py --dataroot $ROOT_DATASET_DIR/market --name market-c3-c6 --camA 3 --camB 6 --save_root $RESULTS_DIR/camstyle_market_cyclegans_test --checkpoints_dir $RESULTS_DIR/camstyle_market_cyclegans_train/

python test.py --dataroot $ROOT_DATASET_DIR/market --name market-c4-c5 --camA 4 --camB 5 --save_root $RESULTS_DIR/camstyle_market_cyclegans_test --checkpoints_dir $RESULTS_DIR/camstyle_market_cyclegans_train/
python test.py --dataroot $ROOT_DATASET_DIR/market --name market-c4-c6 --camA 4 --camB 6 --save_root $RESULTS_DIR/camstyle_market_cyclegans_test --checkpoints_dir $RESULTS_DIR/camstyle_market_cyclegans_train/

python test.py --dataroot $ROOT_DATASET_DIR/market --name market-c5-c6 --camA 5 --camB 6 --save_root $RESULTS_DIR/camstyle_market_cyclegans_test --checkpoints_dir $RESULTS_DIR/camstyle_market_cyclegans_train/
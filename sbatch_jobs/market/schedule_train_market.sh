sbatch --export=ALL,camA=1,camB=2 ./sbatch_jobs/market/train_market_XY.sh
sbatch --export=ALL,camA=1,camB=3 ./sbatch_jobs/market/train_market_XY.sh
sbatch --export=ALL,camA=1,camB=4 ./sbatch_jobs/market/train_market_XY.sh
sbatch --export=ALL,camA=1,camB=5 ./sbatch_jobs/market/train_market_XY.sh
sbatch --export=ALL,camA=1,camB=6 ./sbatch_jobs/market/train_market_XY.sh

sbatch --export=ALL,camA=2,camB=3 ./sbatch_jobs/market/train_market_XY.sh
sbatch --export=ALL,camA=2,camB=4 ./sbatch_jobs/market/train_market_XY.sh
sbatch --export=ALL,camA=2,camB=5 ./sbatch_jobs/market/train_market_XY.sh
sbatch --export=ALL,camA=2,camB=6 ./sbatch_jobs/market/train_market_XY.sh

sbatch --export=ALL,camA=3,camB=4 ./sbatch_jobs/market/train_market_XY.sh
sbatch --export=ALL,camA=3,camB=5 ./sbatch_jobs/market/train_market_XY.sh
sbatch --export=ALL,camA=3,camB=6 ./sbatch_jobs/market/train_market_XY.sh

sbatch --export=ALL,camA=4,camB=5 ./sbatch_jobs/market/train_market_XY.sh
sbatch --export=ALL,camA=4,camB=6 ./sbatch_jobs/market/train_market_XY.sh

sbatch --export=ALL,camA=5,camB=6 ./sbatch_jobs/market/train_market_XY.sh

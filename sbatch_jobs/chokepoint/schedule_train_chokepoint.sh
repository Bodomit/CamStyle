sbatch --export=ALL,camA=C1,camB=C2 ./sbatch_jobs/chokepoint/train_chokepoint_XY.sh
sbatch --export=ALL,camA=C1,camB=C3 ./sbatch_jobs/chokepoint/train_chokepoint_XY.sh

sbatch --export=ALL,camA=C2,camB=C3 ./sbatch_jobs/chokepoint/train_chokepoint_XY.sh

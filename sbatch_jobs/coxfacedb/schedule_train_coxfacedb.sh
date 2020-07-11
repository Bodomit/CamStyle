sbatch --export=ALL,camA=cam0,camB=cam1 ./sbatch_jobs/coxfacedb/train_coxfacedb_XY.sh
sbatch --export=ALL,camA=cam0,camB=cam2 ./sbatch_jobs/coxfacedb/train_coxfacedb_XY.sh
sbatch --export=ALL,camA=cam0,camB=cam3 ./sbatch_jobs/coxfacedb/train_coxfacedb_XY.sh

sbatch --export=ALL,camA=cam1,camB=cam2 ./sbatch_jobs/coxfacedb/train_coxfacedb_XY.sh
sbatch --export=ALL,camA=cam1,camB=cam3 ./sbatch_jobs/coxfacedb/train_coxfacedb_XY.sh

sbatch --export=ALL,camA=cam2,camB=cam3 ./sbatch_jobs/coxfacedb/train_coxfacedb_XY.sh

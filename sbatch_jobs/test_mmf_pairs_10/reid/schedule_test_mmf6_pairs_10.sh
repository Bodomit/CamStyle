module add compilers/gcc/7.2.0
module add apps/anaconda3/5.2.0/bin

conda activate camstyle3

sbatch ./sbatch_jobs/test_mmf_pairs_10/reid/mmf6-pairs-10-test.sh
sbatch ./sbatch_jobs/test_mmf_pairs_10/reid/mmf6-pairs-10-test-camstyle46.sh
sbatch ./sbatch_jobs/test_mmf_pairs_10/reid/mmf6-pairs-10-test-camstyle46_re05.sh
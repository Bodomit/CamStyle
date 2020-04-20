module add compilers/gcc/7.2.0
module add apps/anaconda3/5.2.0/bin

conda activate camstyle3

sbatch ./sbatch_jobs/test_mmf_pairs/reid/mmf6-pairs-test.sh
sbatch ./sbatch_jobs/test_mmf_pairs/reid/mmf6-pairs-test-camstyle46.sh
sbatch ./sbatch_jobs/test_mmf_pairs/reid/mmf6-pairs-test-camstyle46_re05.sh
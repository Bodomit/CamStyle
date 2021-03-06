module add compilers/gcc/7.2.0
module add apps/anaconda3/5.2.0/bin

conda activate camstyle3

sbatch --export=ALL,camA=A,camB=B ./sbatch_jobs/test_mmf_pairs_10/gen_test/mmf6-pairs-10-gen-test.sh
sbatch --export=ALL,camA=A,camB=C ./sbatch_jobs/test_mmf_pairs_10/gen_test/mmf6-pairs-10-gen-test.sh
sbatch --export=ALL,camA=A,camB=1 ./sbatch_jobs/test_mmf_pairs_10/gen_test/mmf6-pairs-10-gen-test.sh
sbatch --export=ALL,camA=A,camB=2 ./sbatch_jobs/test_mmf_pairs_10/gen_test/mmf6-pairs-10-gen-test.sh
sbatch --export=ALL,camA=A,camB=3 ./sbatch_jobs/test_mmf_pairs_10/gen_test/mmf6-pairs-10-gen-test.sh

sbatch --export=ALL,camA=B,camB=C ./sbatch_jobs/test_mmf_pairs_10/gen_test/mmf6-pairs-10-gen-test.sh
sbatch --export=ALL,camA=B,camB=1 ./sbatch_jobs/test_mmf_pairs_10/gen_test/mmf6-pairs-10-gen-test.sh
sbatch --export=ALL,camA=B,camB=2 ./sbatch_jobs/test_mmf_pairs_10/gen_test/mmf6-pairs-10-gen-test.sh
sbatch --export=ALL,camA=B,camB=3 ./sbatch_jobs/test_mmf_pairs_10/gen_test/mmf6-pairs-10-gen-test.sh

sbatch --export=ALL,camA=C,camB=1 ./sbatch_jobs/test_mmf_pairs_10/gen_test/mmf6-pairs-10-gen-test.sh
sbatch --export=ALL,camA=C,camB=2 ./sbatch_jobs/test_mmf_pairs_10/gen_test/mmf6-pairs-10-gen-test.sh
sbatch --export=ALL,camA=C,camB=3 ./sbatch_jobs/test_mmf_pairs_10/gen_test/mmf6-pairs-10-gen-test.sh

sbatch --export=ALL,camA=1,camB=2 ./sbatch_jobs/test_mmf_pairs_10/gen_test/mmf6-pairs-10-gen-test.sh
sbatch --export=ALL,camA=1,camB=3 ./sbatch_jobs/test_mmf_pairs_10/gen_test/mmf6-pairs-10-gen-test.sh

sbatch --export=ALL,camA=2,camB=3 ./sbatch_jobs/test_mmf_pairs_10/gen_test/mmf6-pairs-10-gen-test.sh
sbatch --export=ALL,camA=A,camB=1 ./sbatch_jobs/vggface2pose_synth/gen/vggface2pose_synth-gen-XY.sh
sbatch --export=ALL,camA=A,camB=2 ./sbatch_jobs/vggface2pose_synth/gen/vggface2pose_synth-gen-XY.sh
sbatch --export=ALL,camA=A,camB=3 ./sbatch_jobs/vggface2pose_synth/gen/vggface2pose_synth-gen-XY.sh
sbatch --export=ALL,camA=A,camB=B ./sbatch_jobs/vggface2pose_synth/gen/vggface2pose_synth-gen-XY.sh
sbatch --export=ALL,camA=A,camB=C ./sbatch_jobs/vggface2pose_synth/gen/vggface2pose_synth-gen-XY.sh

sbatch --export=ALL,camA=B,camB=C ./sbatch_jobs/vggface2pose_synth/gen/vggface2pose_synth-gen-XY.sh
sbatch --export=ALL,camA=B,camB=1 ./sbatch_jobs/vggface2pose_synth/gen/vggface2pose_synth-gen-XY.sh
sbatch --export=ALL,camA=B,camB=2 ./sbatch_jobs/vggface2pose_synth/gen/vggface2pose_synth-gen-XY.sh
sbatch --export=ALL,camA=B,camB=3 ./sbatch_jobs/vggface2pose_synth/gen/vggface2pose_synth-gen-XY.sh

sbatch --export=ALL,camA=C,camB=1 ./sbatch_jobs/vggface2pose_synth/gen/vggface2pose_synth-gen-XY.sh
sbatch --export=ALL,camA=C,camB=2 ./sbatch_jobs/vggface2pose_synth/gen/vggface2pose_synth-gen-XY.sh
sbatch --export=ALL,camA=C,camB=3 ./sbatch_jobs/vggface2pose_synth/gen/vggface2pose_synth-gen-XY.sh

sbatch --export=ALL,camA=1,camB=2 ./sbatch_jobs/vggface2pose_synth/gen/vggface2pose_synth-gen-XY.sh
sbatch --export=ALL,camA=1,camB=3 ./sbatch_jobs/vggface2pose_synth/gen/vggface2pose_synth-gen-XY.sh

sbatch --export=ALL,camA=2,camB=3 ./sbatch_jobs/vggface2pose_synth/gen/vggface2pose_synth-gen-XY.sh
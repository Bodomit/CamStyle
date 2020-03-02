sbatch --export=ALL,camA=A,camB=E,filterDataset=None ./sbatch_jobs/vggface2pose_synth/gen/vggface2pose_synth-gen-XY.sh
sbatch --export=ALL,camA=A,camB=1,filterDataset=camB ./sbatch_jobs/vggface2pose_synth/gen/vggface2pose_synth-gen-XY.sh
sbatch --export=ALL,camA=A,camB=5,filterDataset=camB ./sbatch_jobs/vggface2pose_synth/gen/vggface2pose_synth-gen-XY.sh

sbatch --export=ALL,camA=E,camB=1,filterDataset=camB ./sbatch_jobs/vggface2pose_synth/gen/vggface2pose_synth-gen-XY.sh
sbatch --export=ALL,camA=E,camB=5,filterDataset=camB ./sbatch_jobs/vggface2pose_synth/gen/vggface2pose_synth-gen-XY.sh

sbatch --export=ALL,camA=1,camB=5,filterDataset=both ./sbatch_jobs/vggface2pose_synth/gen/vggface2pose_synth-gen-XY.sh

#!/bin/bash
#SBATCH --job-name=crafter
#SBATCH --gres=gpu:1             # Number of GPUs (per node)
#SBATCH --mem=100GB               # memory (per node)
#SBATCH --time=72:00:00            # time (DD-HH:MM)
#SBATCH --error=/home/mila/c/chris.emezue/crafter-ood/slurm_no_scoreboard/slurmerror_%j.txt
#SBATCH --output=/home/mila/c/chris.emezue/crafter-ood/slurm_no_scoreboard/slurmoutput_%j.txt

module load python/3
source /home/mila/c/chris.emezue/scratch/crafter-env/bin/activate
module load cudatoolkit/11.3
export IMAGEIO_FFMPEG_EXE=/home/mila/c/chris.emezue/scratch/ffmpeg-git-20220910-amd64-static/ffmpeg

#python3 main.py  --profile=oc_ca --logger.type wandb --fe.patch_size 16 --fe.patch_stride $1 --crf.render_scoreboard 0 --max_train_steps $2
# disabling scoreboard might affect inventory of items
#python3 main.py \
#    --profile=oc_ca \
#    --logger.type wandb \
#    --fe.patch_size 16 \
#    --fe.patch_stride $1 \
#    --max_train_steps $2 \
#    --wandb_entity world-models-rl \
#    --wandb_tag $3

python3 main.py --profile=oc_ca --logger.type wandb --wandb_entity world-models-rl --wandb_tag default_attn
# confirm if no scoreboard gets you what you expect
#   sbatch run.sh 16 10_000_000

# Try stride sizes
#  sbatch run.sh 8 10_000_000
#  sbatch run.sh 8 20_000_000
#  sbatch run.sh 16 10_000_000

# should create a separate project, to add Connor
#   check for attention masks on WANDB

#!/bin/bash -e

#SBATCH --job-name=aya_multi_run
#SBATCH --time=00-02:00:00
#SBATCH --gpus-per-node=H100:1
#SBATCH --cpus-per-task=2
#SBATCH --mem=16GB
#SBATCH --output        log/%x.%j.out 


cd /nesi/project/massey04342/multilingual/

module --force purge
module load NeSI
module load Python/3.11.6-foss-2023a
module load JupyterLab/2025.5.0-foss-2023a-4.4.2

source /nesi/project/massey04342/home/mac/bin/activate

export LD_LIBRARY_PATH=/nesi/project/massey04342/home/mac/lib:$LD_LIBRARY_PATH

#export HF_HOME=/nesi/nobackup/massey04342/models/huggingface
#export HF_HUB_CACHE=/nesi/nobackup/massey04342/models/huggingface/hub
#export TRANSFORMERS_CACHE=/nesi/nobackup/massey04342/models/huggingface

echo "Python"
which python
python --version
echo "GPU"
nvidia-smi

echo "Hugging Face cache"
echo $HF_HOME
echo $HF_HUB_CACHE

echo "WHO AMI I"
hf auth whoami

python -m jupyter nbconvert \
  --to notebook \
  --execute \
  --ExecutePreprocessor.kernel_name=matharc \
  --ExecutePreprocessor.timeout=0 \
  --ExecutePreprocessor.startup_timeout=300 \
  aya_0_shot.ipynb \
  --output aya_0_shot.ipynb
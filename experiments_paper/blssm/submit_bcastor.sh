#!/bin/bash 
#SBATCH --job-name=aspblssm0
#SBATCH --time=24:00:00
#SBATCH --nodes=1
#SBATCH --tasks-per-node=1
#SBATCH --cpus-per-task=40
#SBATCH --output=slurm-%j.out    # Standard output log
#SBATCH --error=slurm-%j.err     # Standard error log

module load gcc/12.1.0 || { echo "Failed to load gcc module"; exit 1; }
module load cmake || { echo "Failed to load cmake module"; exit 1; }
source activate newhep || { echo "Failed to activate conda environment"; exit 1; }

# Check if the required arguments are provided
if [ -z "$1" ] || [ -z "$2" ] || [ -z "$3" ] || [ -z "$4" ]; then
    echo "Usage: $0 <n> <mode> <config> <channels>"
    exit 1
fi

# Assign the provided arguments to variables
n="$1"
mode="$2"
config="$3"
channels="$4"

# Print the values of the variables
echo "n is set to: $n"
echo "mode is set to: $mode"
echo "config is set to: $config"
echo "channels is set to: $channels"

# Run the Python script with the provided arguments
python bcastor_run.py --n "$n" --mode "$mode" --config "$config" --channels "$channels" || { echo "Python script failed"; exit 1; }
#!/bin/bash

PWD=$(pwd)
DSET=cifar10sgn
CP_INTERVAL=100
EPOCHS=600
DATA_DIR=/home/baumana1/work/data/sgn_results/$DSET
OUT_DIR=/home/baumana1/work/data/sgn_results/out/$DSET
CACHE_DIR=/home/baumana1/work/data/sgn_results/.cache/$DSET
SCRIPTS_DIR=$PWD/scripts

# Create necessary directories
mkdir -p $DATA_DIR
mkdir -p $OUT_DIR
mkdir -p $CACHE_DIR
mkdir -p $SCRIPTS_DIR

echo "============== RUNNING $DSET TESTS ================"
echo

submit_job() {
    TEST_NAME=$1
    SCRIPT_NAME=$2
    shift 2
    JOB_SCRIPT="#!/bin/bash
#SBATCH --gres=gpu:1
#SBATCH --cpus-per-task=4
#SBATCH --mem-per-cpu=4G
#SBATCH --time=10:29:00
#SBATCH --account=aalto_users

python src/cifar/sgn.py --data_dir=$DATA_DIR \
                        --output_dir=$OUT_DIR/$TEST_NAME \
                        --dataset cifar10 \
                        --train_epochs=$EPOCHS \
                        --checkpoint_interval=$CP_INTERVAL \
                        --download_data $@"

    # Save script in the scripts folder
    SCRIPT_PATH=$SCRIPTS_DIR/$SCRIPT_NAME
    echo "$JOB_SCRIPT" > $SCRIPT_PATH
    chmod +x $SCRIPT_PATH
    sbatch $SCRIPT_PATH
}

echo "============== NO NOISE ================"
TEST_NAME=no_noise
SCRIPT_NAME="no_noise.sh"
submit_job $TEST_NAME $SCRIPT_NAME --alpha 0.999

echo "============== SYM 20% ================"
TEST_NAME=sym20
SCRIPT_NAME="sym20.sh"
submit_job $TEST_NAME $SCRIPT_NAME --noisy_labels --corruption_type sym --severity 0.2 --alpha 0.997

echo "============== SYM 40% ================"
TEST_NAME=sym40
SCRIPT_NAME="sym40.sh"
submit_job $TEST_NAME $SCRIPT_NAME --noisy_labels --corruption_type sym --severity 0.4 --alpha 0.991

echo "============== SYM 60% ================"
TEST_NAME=sym60
SCRIPT_NAME="sym60.sh"
submit_job $TEST_NAME $SCRIPT_NAME --noisy_labels --corruption_type sym --severity 0.6 --alpha 0.991

echo "============== ASYM 20% ================"
TEST_NAME=asym20
SCRIPT_NAME="asym20.sh"
submit_job $TEST_NAME $SCRIPT_NAME --noisy_labels --corruption_type asym --severity 0.2 --alpha 0.997

echo "============== ASYM 30% ================"
TEST_NAME=asym30
SCRIPT_NAME="asym30.sh"
submit_job $TEST_NAME $SCRIPT_NAME --noisy_labels --corruption_type asym --severity 0.3 --alpha 0.997

echo "============== ASYM 40% ================"
TEST_NAME=asym40
SCRIPT_NAME="asym40.sh"
submit_job $TEST_NAME $SCRIPT_NAME --noisy_labels --corruption_type asym --severity 0.4 --alpha 0.997

echo "All jobs submitted."
#!/bin/bash

### Feature Table ###
# ca_housing 8
# YearPredictionMSD 90
# slice_localization 384
dataset=slice_localization

BASEDIR=$(dirname "$0")
OUTDIR="${BASEDIR}/ckpt/"

if [ ! -d "${OUTDIR}" ]
then
    echo "Output dir ${OUTDIR} does not exist, creating..."
    mkdir -p ${OUTDIR}
fi

CUDA_VISIBLE_DEVICES=0 python -u main_reg_cv.py \
    --feat_d 90 \
    --hidden_d 32 \
    --boost_rate 1 \
    --lr 0.005 \
    --L2 .0e-3 \
    --num_nets 10 \
    --data ${dataset} \
    --tr ${BASEDIR}/../data/${dataset}_tr.npz \
    --te ${BASEDIR}/../data/${dataset}_te.npz \
    --batch_size 2048 \
    --epochs_per_stage 1 \
    --correct_epoch 1 \
    --normalization True \
    --cv True \
    --out_f ${OUTDIR}/${dataset}_cls.pth \
#    --cuda
#python -u main_reg_cv.py --feat_d 384 --hidden_d 32 --boost_rate 1 --lr 0.005 --L2 .0e-3 --num_nets 40 --data slice_localization --tr ../data/slice_localization_tr.npz --te ../data/slice_localization_te.npz --batch_size 2048 --epochs_per_stage 1 --correct_epoch 1 --normalization True --cv True --out_f ckpt/slice_localization_cls.pth --cuda
#python -u main_reg_cv.py --feat_d 4 --hidden_d 10 --boost_rate 1 --lr 0.005 --L2 .0e-3 --num_nets 5 --data sunspot --tr ../data/sunspot_train.txt --te ../data/sunspot_test.txt --batch_size 1 --epochs_per_stage 1 --correct_epoch 1 --normalization True --cv True --out_f ckpt/sunspot_cls.pth --cuda --exps 30

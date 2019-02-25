#!/bin/bash

MODEL_PATH=$(dirname $0)
BPE_CODES="$MODEL_PATH/bpe.codes"
BPE_VOCAB="$MODEL_PATH/bpe.vocab"

python3 $MODEL_PATH/custom_constraints.py \
    --BPE-codes $BPE_CODES \
    --BPE-vocab $BPE_VOCAB \
| \
python3 -m sockeye.translate \
                -m $MODEL_PATH \
                --json-input \
                --beam-size 20 \
                --beam-prune 20 \
                --batch-size 10 \
                --use-cpu \
                --quiet \
| \
. $MODEL_PATH/post.sh

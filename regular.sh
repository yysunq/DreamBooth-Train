#!/bin/bash
# python3 executable

if [[ -z "${cur_path}" ]]
then
    cur_path=$(cd "$(dirname "$0")";pwd)
    echo cur_path = ${cur_path}
fi

if [[ -z "${python_cmd}" ]]
then
    python_cmd="python"
    echo python_cmd = ${python_cmd}
fi

if [[ -z "${regular_files_count}" ]]
then
    regular_files_count="200"
    echo regular_files_count = ${regular_files_count}
fi

if [[ -z "${regular_ckpt}" ]]
then
    regular_ckpt="/root/autodl-tmp/v1-5-pruned-emaonly.ckpt"
    echo regular_ckpt = ${regular_ckpt}
fi

if [[ -z "${regular_prompt}" ]]
then
    regular_prompt="woman"
    echo regular_prompt = ${regular_prompt}
fi

echo ${cur_path}/outputs/txt2img-samples/samples/
echo ${cur_path}/regularization_images/${regular_prompt}/

rm -f -r ${cur_path}/outputs/txt2img-samples/samples

${python_cmd} ./scripts/stable_txt2img.py --skip_grid --seed 10 --ddim_eta 0.0 --n_sample 1 --n_iter ${regular_files_count} --scale 10.0 --ddim_steps 50 --ckpt ${regular_ckpt} --prompt ${regular_prompt}
${python_cmd} ./jpg2png.py ${cur_path}/outputs/txt2img-samples/samples/ ${cur_path}/regularization_images/${regular_prompt}/


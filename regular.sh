#!/bin/bash
# python3 executable
if [[ -z "${python_cmd}" ]]
then
        python_cmd="python"
fi

if [[ -z "${regular_files_count}" ]]
then
        regular_files_count="200"
fi

if [[ -z "${regular_ckpt}" ]]
then
        regular_ckpt="anime700k-64bs-0.1ucg-penultimate-1epoch-clip-ema-continue-76000-ema-pruned.ckpt"
fi

if [[ -z "${regular_prompt}" ]]
then
        regular_prompt="body"
fi

`${python_cmd} ./scripts/stable_txt2img.py --skip_grid --seed 10 --ddim_eta 0.0 --n_sample 1 --n_iter ${regular_files_count} --scale 10.0 --ddim_steps 50 --ckpt ${regular_ckpt} --prompt ${regular_prompt}`

cd ./regularization_images

if [ ! -d "$regular_prompt"  ];
then
    mkdir -p "$regular_prompt"
else
    echo "$regular_prompt dir exist"
fi

cd ..

filelist=`ls outputs/txt2img-samples/*.png`
for file in $filelist
do
    mv $file ./regularization_images/$regular_prompt
done


#!/bin/bash
# python3 executable
if [[ -z "${python_cmd}" ]]
then
        python_cmd="python"
fi

if [[ -z "${base_yaml}" ]]
then
        base_yaml="./configs/stable-diffusion/v1-finetune_unfrozen.yaml"
fi

if [[ -z "${actual_resume}" ]]
then
        actual_resume="anime700k-64bs-0.1ucg-penultimate-1epoch-clip-ema-continue-76000-ema-pruned.ckpt"
fi
if [[ -z "${reg_data_root}" ]]
then
        reg_data_root="/root/autodl-tmp/dreambooth/Dreambooth-Stable-Diffusion/regularization_images/man"
fi

if [[ -z "${proj_name}" ]]
then
        proj_name="tlbbv6"
fi

if [[ -z "${train_data}" ]]
then
        train_data="/root/autodl-tmp/dreambooth/Dreambooth-Stable-Diffusion/training_images"
fi

if [[ -z "${steps}" ]]
then
        steps="2000"
fi

if [[ -z "${class_word}" ]]
then
        class_word="man"
fi

if [[ -z "${token}" ]]
then
        token="tlbb"
fi

#`python ./main.py --base ./configs/stable-diffusion/v1-finetune_unfrozen.yaml -t --actual_resume anime700k-64bs-0.1ucg-penultimate-1epoch-clip-ema-continue-76000-ema-pruned.ckpt --reg_data_root /root/autodl-tmp/dreambooth/Dreambooth-Stable-Diffusion/regularization_images/female -n tlbbv6 --gpu 0, --data_root /root/autodl-tmp/dreambooth/Dreambooth-Stable-Diffusion/training_images --max_training_steps 2000 --class_word female --token tlbb --no-test`
`${python_cmd} ./main.py --base ${base_yaml} -t --actual_resume ${actual_resume} --reg_data_root ${reg_data_root} --name ${proj_name} --gpu 0, --data_root ${train_data} --max_training_steps ${steps} --class_word ${class_word} --token ${token} --no-test`

#!/bin/bash
# python3 executable
if [[ -z "${python_cmd}" ]]
then
        python_cmd="python"
fi

if [[ -z "${desc}" ]]
then
        desc="sd-1.5-churuo-woman"
fi


if [[ -z "${base_yaml}" ]]
then
        base_yaml="./configs/stable-diffusion/v1-finetune_unfrozen.yaml"
fi

if [[ -z "${actual_resume}" ]]
then
        actual_resume="/root/autodl-tmp/auto/stable-diffusion-web-ui/stable-diffusion-webui/models/Stable-diffusion/v1-5-pruned-emaonly.ckpt"
    fi
if [[ -z "${reg_data_root}" ]]
then
        reg_data_root="/root/autodl-tmp/dreambooth/Dreambooth-Stable-Diffusion/regularization_images/woman"
fi

if [[ -z "${proj_name}" ]]
then
        proj_name="v9.sd1.5.churuo.woman"
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
        class_word="woman"
fi

if [[ -z "${token}" ]]
then
        token="churuo"
fi

#`python ./main.py --base ./configs/stable-diffusion/v1-finetune_unfrozen.yaml -t --actual_resume anime700k-64bs-0.1ucg-penultimate-1epoch-clip-ema-continue-76000-ema-pruned.ckpt --reg_data_root /root/autodl-tmp/dreambooth/Dreambooth-Stable-Diffusion/regularization_images/female -n tlbbv6 --gpu 0, --data_root /root/autodl-tmp/dreambooth/Dreambooth-Stable-Diffusion/training_images --max_training_steps 2000 --class_word female --token tlbb --no-test`
${python_cmd} ./main.py --base ${base_yaml} -t --actual_resume ${actual_resume} --reg_data_root ${reg_data_root} --name ${proj_name} --gpu 0, --data_root ${train_data} --max_training_steps ${steps} --class_word ${class_word} --token ${token} --no-test

filelist=(`ls -dtr logs/*`)
lastidx=${#filelist[*]}
echo "lastidx = $lastidx"
lastdir=${filelist[$lastidx-1]}
ckptpath="${lastdir}/checkpoints/last.ckpt"
echo "source ckpt path = ${ckptpath}"
time=$(date "+%Y%m%d-%H%M%S")
echo $time
finalpath="/root/autodl-tmp/auto/stable-diffusion-web-ui/stable-diffusion-webui/models/Stable-diffusion/${time}-${proj_name}-token(${token})-class_word(${class_word})-steps(${steps})-desc(${desc}).ckpt"
echo "dest ckpt path = ${finalpath}"
mv $ckptpath $finalpath
echo "success mv ${finalpath}!!!"

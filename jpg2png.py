
#!/usr/bin/python
# -*- coding: UTF-8 -*-
import sys
import PIL.Image
import os
import shutil

#path = "/root/autodl-tmp/dreambooth/Dreambooth-Stable-Diffusion/outputs/txt2img-samples/samples/"
#savepath = "/root/autodl-tmp/dreambooth/Dreambooth-Stable-Diffusion/regularization_images/test/"

path = sys.argv[1]
savepath = sys.argv[2]
print(f'source path = {path}')
print(f'dest path = {savepath}')

isExists=os.path.exists(savepath)
if isExists:
    shutil.rmtree(savepath)
    print(f'remove {savepath} success!!!')

os.makedirs(savepath) 
print(f'create new {savepath} success!!')

i=0
filelist = os.listdir(path)
for file in filelist:
    im = PIL.Image.open(path+filelist[i])
    filename = os.path.splitext(file)[0]
    print(f"{i}:processing... {savepath}{filename}.png")
    im.save(savepath+filename+'.png') # or 'test.tif'
    i=i+1
print(f'all {i} files processed success in {savepath}')

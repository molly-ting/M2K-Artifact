---
language: en
arxiv: 2403.14852
---

<div align="center">
<h1>
  CVLFace Pretrained Face Alignement Model (DFA MOBILENET)
</h1>
</div>


<p align="center">
 🌎 <a href="https://github.com/mk-minchul/CVLface" target="_blank">GitHub</a> • 🤗 <a href="https://huggingface.co/minchul" target="_blank">Hugging Face</a> 
</p>


-----


##  1. Introduction

Model Name: DFA MOBILENET

Related Paper: KeyPoint Relative Position Encoding for Face Recognition (https://arxiv.org/abs/2403.14852)

Please cite the original paper and follow the license of the training dataset.

##  2. Quick Start

```python
if __name__ == '__main__':
    
from transformers import AutoModel
from huggingface_hub import hf_hub_download
import shutil
import os
import sys


# helpfer function to download huggingface repo and use model
def download(repo_id, path, HF_TOKEN=None):
    os.makedirs(path, exist_ok=True)
    files_path = os.path.join(path, 'files.txt')
    if not os.path.exists(files_path):
        hf_hub_download(repo_id, 'files.txt', token=HF_TOKEN, local_dir=path, local_dir_use_symlinks=False)
    with open(os.path.join(path, 'files.txt'), 'r') as f:
        files = f.read().split('\n')
    for file in [f for f in files if f] + ['config.json', 'wrapper.py', 'model.safetensors']:
        full_path = os.path.join(path, file)
        if not os.path.exists(full_path):
            hf_hub_download(repo_id, file, token=HF_TOKEN, local_dir=path, local_dir_use_symlinks=False)

            
# helpfer function to download huggingface repo and use model
def load_model_from_local_path(path, HF_TOKEN=None):
    cwd = os.getcwd()
    os.chdir(path)
    sys.path.insert(0, path)
    model = AutoModel.from_pretrained(path, trust_remote_code=True, token=HF_TOKEN)
    os.chdir(cwd)
    sys.path.pop(0)
    return model


# helpfer function to download huggingface repo and use model
def load_model_by_repo_id(repo_id, save_path, HF_TOKEN=None, force_download=False):
    if force_download:
        if os.path.exists(save_path):
            shutil.rmtree(save_path)
    download(repo_id, save_path, HF_TOKEN)
    return load_model_from_local_path(save_path, HF_TOKEN)


if __name__ == '__main__':
    
    # load model
    HF_TOKEN = 'YOUR_HUGGINGFACE_TOKEN'
    path = os.path.expanduser('~/.cvlface_cache/minchul/cvlface_DFA_mobilenet')
    repo_id = 'minchul/cvlface_DFA_mobilenet'
    aligner = load_model_by_repo_id(repo_id, path, HF_TOKEN)

    # input is a rgb image normalized.
    from torchvision.transforms import Compose, ToTensor, Normalize
    from PIL import Image
    img = Image.open('/path/to/img.png')
    trans = Compose([ToTensor(), Normalize(mean=[0.5, 0.5, 0.5], std=[0.5, 0.5, 0.5])])
    input = trans(img).unsqueeze(0)  # torch.randn(1, 3, 256, 256) or any size with a single face
    
    # predict landmarks and aligned image
    aligned_x, orig_ldmks, aligned_ldmks, score, thetas, bbox = aligner(input)
    
    # Documentation
    # aligned_x: aligned face image (1, 3, 112, 112)
    # orig_ldmks: predicted landmarks in the original image (1, 5, 2)
    # aligned_ldmks: predicted landmarks in the aligned image (1, 5, 2)
    # score: confidence score (1,)
    # thetas: transformation matrix transforming  (1, 2, 3). See below for how to use it.
    # normalized_bbox: bounding box in the original image (1, 4)
    
    # differentiable alignment
    import torch.nn.functional as F
    grid = F.affine_grid(thetas, (1, 3, 112, 112), align_corners=True)
    manual_aligned_x = F.grid_sample(input, grid, align_corners=True)
    # manual_aligned_x should be same as aligned_x (up to some numerical error due to interpolation error)
    # here input can receive gradient through the grid_sample function.
```

## Example Outputs

<table align="center">
<tr>
<td><img src="orig.png" alt="Image 1"></td>
<td><img src="input.png" alt="Image 2"></td>
<td><img src="aligned.png" alt="Image 3"></td>
</tr>
<tr>
<td align="center">Input Image</td>
<td align="center">Input Image with Landmark</td>
<td align="center">Aligned Image with Landmark</td>
</tr>
</table>
```

Code for visualizaton
```python
def concat_pil(list_of_pil):
    w, h = list_of_pil[0].size
    new_im = Image.new('RGB', (w * len(list_of_pil), h))
    for i, im in enumerate(list_of_pil):
        new_im.paste(im, (i * w, 0))
    return new_im


def draw_ldmk(img, ldmk):
    import cv2
    if ldmk is None:
        return img
    colors = [(0, 255, 0), (255, 0, 0), (0, 0, 255), (255, 255, 0), (0, 255, 255), (255, 0, 255)]
    img = img.copy()
    for i in range(5):
        color = colors[i]
        cv2.circle(img, (int(ldmk[i*2] * img.shape[1]),
                         int(ldmk[i*2+1] * img.shape[0])), 1, color, 4)
    return img

def tensor_to_numpy(tensor):
    # -1 to 1 tensor to 0-255
    arr = tensor.numpy().transpose(1,2,0)
    return (arr * 0.5 + 0.5) * 255


def visualize(tensor, ldmks=None):
    assert tensor.ndim == 4
    images = [tensor_to_numpy(image_tensor) for image_tensor in tensor]
    if ldmks is not None:
        images = [draw_ldmk(images[j], ldmks[j].ravel()) for j in range(len(images))]
    pil_images = [Image.fromarray(im.astype('uint8')) for im in images]
    return concat_pil(pil_images)

visualize(input, None).save('orig.png')
visualize(aligned, aligned_ldmks).save('aligned.png')
visualize(input, orig_ldmks).save('input.png')
```
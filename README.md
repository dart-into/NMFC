# Underwater-image-quality-assessment-method-based-on-color-space-multi-feature-fusion
This is the source code for the paper "Underwater image quality assessment method based on color space multi-feature fusion".

## Dataset
| Dataset   | Links                                                       |
| --------- | ----------------------------------------------------------- |
| SAUD      | https://github.com/yia-yuese/SAUD-Dataset      |
| UIED      | https://github.com/z21110008/UIF                            |

## Dependencies
Matlab

## Usage
First of all, you need to ensure the correct path. 
Then you can extract features, split dataset, training and testing.

### Extract features
run the SAUDFeatureCompute.m

### split dataset
There are two ways to split a dataset: fixed and random.
fixed:run the fixedSplitTrainTest.m
radom:run the SplitTrainTest.m

### Training
run the SVM.m
### Testing
run demo.m

## Citation
If you find this work useful for your research, please cite our paper:
```
﻿@Article{Chen2023,
author={Chen, Tianhai
and Yang, Xichen
and Li, Nengxin
and Wang, Tianshu
and Ji, Genlin},
title={Underwater image quality assessment method based on color space multi-feature fusion},
journal={Scientific Reports},
year={2023},
month={Oct},
day={06},
volume={13},
number={1},
pages={16838},
issn={2045-2322},
doi={10.1038/s41598-023-44179-3},
url={https://doi.org/10.1038/s41598-023-44179-3}
}

```

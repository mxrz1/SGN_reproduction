# Reproducing Shifted Gaussian Noise (SGN)
This is a modifed version of the SGN repository made by @ErikEnglesson and @butterman0423. More specifically, it contains patches to SGN repository and its dependents edward2 and uncertainty-baselines to be able to run a specific working build using Tensorflow 2.8.1 implemented by @butterman0423. Furthermore, we patched the `deterministic.py` model, extended the experiment scripts to run the main finding of the paper, added flags to SGN to disable loss reweighting (LR) (see `sgn_ablation.py`) and added a new version of SGN using Monte Carlo sampling. 

**NOTE**
Clothing1M and Webvision tests are unavailalbe as they run into runtime issues.

# Shifted Gaussian Noise (SGN)
The official implementation of our ICLR 2024 paper: [Robust Classification via Regression for Learning with Noisy Labels](https://openreview.net/forum?id=wfgZc3IMqo).

## Abstract
Deep neural networks and large-scale datasets have revolutionized the field of machine learning. However, these large networks are susceptible to overfitting to label noise, resulting in reduced generalization. To address this challenge, two promising approaches have emerged: i) loss reweighting, which reduces the influence of noisy examples on the training loss, and ii) label correction that replaces noisy labels with estimated true labels. These directions have been pursued separately or combined as independent methods, lacking a unified approach. In this work, we present a unified method that seamlessly combines loss reweighting and label correction to enhance robustness against label noise in classification tasks. Specifically, by leveraging ideas from compositional data analysis in statistics, we frame the problem as a regression task, where loss reweighting and label correction can naturally be achieved with a shifted Gaussian label noise model. Our unified approach achieves strong performance compared to recent baselines on several noisy labeled datasets. We believe this work is a promising step towards robust deep learning in the presence of label noise.

## Keywords
Classification via Regression, Loss Reweighting, Label Correction, Robustness, Label Noise, Noisy Labels, Probabilistic Machine Learning, Compositional Data Analysis, Isometric Log-Ratio Transform, Gaussian Likelihood.

## Environment Setup
The code uses and is based on the [Uncertainty Baselines GitHub repository](https://github.com/google/uncertainty-baselines), please follow the installation instructions there. [Keep in mind that this repository is still very buggy and not so easy to get to run mainly due to outdated dependencies.]

Our experiments were run with TensorFlow 2.6.0, TensorFlow Probability 0.14.1 and Uncertainty Baselines 0.0.7, on A100 GPUs.

## Running Experiments
For example, the SGN method on CIFAR-100 with 40% symmetric noise, can be run with the following command
```bash
python src/cifar/sgn.py --data_dir=/path/to/data/ \
                        --output_dir=/path/to/output_dir/ \
                        --dataset cifar100 \
                        --noisy_labels \
                        --corruption_type sym \
                        --severity 0.4
```


### Experiment Scripts

In the `experiments` folder you can find the scripts used to run the experiments in the paper.

* `cifar10.sh` runs the SGN method on CIFAR-10 with all different synthetic noises.
* `cifar100.sh` runs the SGN method on CIFAR-100 with all different synthetic noises.
* `cifar10_ls.sh` runs the LS method on CIFAR-10 with all different synthetic noises.
* `cifar100_ls.sh` runs the LS method on CIFAR-100 with all different synthetic noises.
* ``cifarN.sh`` runs the SGN method on all CIFAR-N variations.
* ``cifarN_ls.sh`` runs the LS method on all CIFAR-N variations.
* `àblation_study.sh` runs the ablation study in Table 4 of the paper.


`cifar10.sh`, `cifar100.sh`, `cifar10_ls.sh` and `cifar100_ls.sh` reproduce the results of Table 1 in the paper.

`cifarN.sh` and `cifarN_ls.sh` reproduce the results of Table 2 in the paper.


## Reference
If you want to cite our work, you can do so with the following BibTex:
```
@inproceedings{
englesson2024robust,
title={Robust Classification via Regression for Learning with Noisy Labels},
author={Erik Englesson and Hossein Azizpour},
booktitle={The Twelfth International Conference on Learning Representations},
year={2024},
url={https://openreview.net/forum?id=wfgZc3IMqo}
}
```

If you enjoyed this work, you might also find our previous work at TMLR interesting: [Logistic-Normal Likelihoods for Heteroscedastic Label Noise](https://openreview.net/forum?id=7wA65zL3B3).

## Contact
If you have any questions, feel free to reach out to me at [engless@kth.se](mailto:engless@kth.se). 

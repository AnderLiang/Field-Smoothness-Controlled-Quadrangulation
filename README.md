# Field Smoothness-Controlled Partition for Quadrangulation

<strong>Zhongxuan Liang, Wei Du,  Xiao-Ming Fu</strong>

<small>University of Science and Technology of China</small>

We propose a novel partition method for reliable feature-aligned quadrangulation. 

This repository is an implementation of [Field Smoothness-Controlled Partition for Quadrangulation](https://dl.acm.org/doi/10.1145/3730889).

Project homepage：[homepage](http://staff.ustc.edu.cn/~fuxm/projects/FSCQ/FSCQ.html)

8700 Dataset：[Dataset](https://rec.ustc.edu.cn/share/579773f0-7588-11f0-b307-c7c159138de8)，Passcode ：8700

![Our generated high-quality quad meshes](img/fig1.png)

### Overview

We propose a novel partition method for reliable feature-aligned quadrangulation. The core insight of the partition is that smooth streamlines distant from singularities are more suitable as patch boundaries. This allows singularities to be enclosed within patches, resulting in straighter patch boundaries and reducing the distorting influence of singularities. Accordingly, we introduce a new patch quality control mechanism that keeps the patch boundaries inside regions with high field smoothness. Combined with other common metrics (e.g., aligning boundaries with field and feature lines), we develop a practical partition algorithm that first iteratively traces paths in field smoothness-controlled regions to form patches and then removes redundant paths to simplify the patch layout. We demonstrate the effectiveness and practicability of our partitions by using them to generate quality quad meshes on a massive test data set. Compared with state-of-the-art methods, our approach produces quad meshes with significantly enhanced quality while maintaining similar reliability, validating the core insight.

## Installation

To install this project on a Unix-based system, use the following standard CMake build procedure:

```bash
git clone https://github.com/AnderLiang/Field-Smoothness-Controlled-Quadrangulation.git
```

## Usage
```bash
./mkdir.sh
```
The input mesh must be a manifold surface. Add it to the `/data/input` directory, and then execute:
```bash
cd bin
./fscq.sh -a
./analyse_result.sh 0 0 0
```



The final results can be viewed in the `/data/post_process` directory, and static analysis results are located in the `/data/result_analysis` directory.



## Citation

```
@article{liang2025field,
  title={Field Smoothness-Controlled Partition for Quadrangulation},
  author={Liang, Zhongxuan and Du, Wei and Fu, Xiao-Ming},
  journal={ACM Transactions on Graphics (TOG)},
  volume={44},
  number={4},
  pages={1--15},
  year={2025},
  publisher={ACM New York, NY, USA}
}
```

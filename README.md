# Tensor_Sensing_for_RF_Tomography
- [1]  T. Deng, F. Qian,  X.-Y. Liu, M. Zhang, A. Walid. Tensor sensing for RF tomographic imaging. IEEE ICME, 2018.

## Usage
Basicly, we select IKEA 3D dataset as an example. [IKEA 3D](http://ikea.csail.mit.edu/)

Run `./run_TS.m` to recover the unkowm tensor, you can input `dct` for DCT transform or `fft` for FFT transform. You can change the parameters such as the size of the unknown tenor, the sampling rates, the iteration times in `./TS_example.m`. The main steps of the algorithm <b>Alt-Min</b> is in `./TS.m`. And the `./toolbox` contains the dependent functions.

## Experiment
We compare the proposed algorithm Alt-Min with tensor-based compressed sensing [2] on 50 IKEA 3D models. Each 3D model is used to generate one ground truth tensor of size $60\times 60\times 15$, which is placed in the middle of the `tensor` and occupies a part of the space.

For the simulations of the wireless channel, the space of interest is divided into a set of three-dimensional voxels, and a set of RF signal nodes are uniformly deployed around the space, forming a complete tomography network. Any pair of nodes can establish a unique wireless link, and the path loss on a wireless link has three contributions: (1) Large-scale path loss due to distance; (2) Shadowing loss due to obstructions; and (3) Non-shadowing loss due to multipath [2,3]. The relevant code is in `./toolbox/generate_sampling_tensor.m` and `./toolbox/one_link.m`.  

<div align=center><img src="https://github.com/hust512/Tensor_Sensing_for_RF_Tomography/blob/master/Fig/model.png" />
</div>

<div align=center>Fig.1  (a) and (c) are the 3D visualizations of two IKEA models, (b) and (d) are the corresponding recovery results.</div>

<div> </div>


<div align=center><img src="https://github.com/hust512/Tensor_Sensing_for_RF_Tomography/blob/master/Fig/result.png" />
</div>

<div align=center>Fig.2  (a) is RSEs vs sampling rates; (b) is Alt-Min with FFT; (c) is Alt-Min with DCT.</div>


- [2] Matsuda, Takahiro, et al. "Multi-dimensional wireless tomography using tensor-based compressed sensing." Wireless Personal Communications 96.3 (2017): 3361-3384.
- [3] J. Wilson and N. Patwari, "Radio tomographic imaging with wireless networks," IEEE Transactions on Mobile Computing, vol. 9, no. 5, pp.621–632, 2010.


# Tensor_Sensing_for_RF_Tomography
RF Tomography imaging

## Usage
Basicly, we select IKEA 3D dataset as an example. ![IKEA 3D]http://ikea.csail.mit.edu/
Run `./run_TS.m` to recover the unkowm tensor, you can input `dct` for DCT transform or `fft` for FFT transform. You can change the parameters such as the size of the unknown tenor, the sampling rates, the iteration times in `./TS_example.m`. The main steps of the algorithm <b>Alt-Min</b> is in `./TS.m`. And the `./toolbox` contains the dependent functions.

## Experiment Result
We compare the proposed algorithm Alt-Min with tensor-based compressed sensing [1] on 50 IKEA 3D models \cite{lpt2013ikea}. Each 3D model is used to generate one ground truth tensor of size $60\times 60\times 15$, which is placed in the middle of the `tensor` and occupies a part of the space.

<div><img src="" /></div>

-[1] 

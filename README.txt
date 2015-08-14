In order to use SPU-sim, read the README file in the gpgpu-sim_distribution folder and follow the instructions.

To use the SPU use these commands from your terminal:

export PTX_SIM_USE_PTX_FILE=1
export PTX_SIM_KERNELFILE=(Location to your PTX file)/(your PTX file).ptx

Then execute your program, containing a call to a CUDA kernel, and your own PTX file will be executed on SPU-sim.


DEMO:

Compile gpgpu-sim as described in the folder gpgpu-sim_distribution.
Type the following commands:
export PTX_SIM_USE_PTX_FILE=1
export PTX_SIM_KERNELFILE=(Root of SPU-sim folder)/cuda_code/matmult_spu/matmultKernel_iu_viu.ptx

Then, in the (Root of SPU-sim folder)/cuda_code/matmult_spu folder, run the following command :
./matmult03 4 2 4 2

In order to change the size of the thread block grid, goto the (Root of SPU-sim folder)/cuda_code/matmult_native folder. Modify the matmult.h as wanted. Use the following commands:
make matmult03
cp matmult03 ../matmult_spu

You can then run ./matmult03 4 2 4 2 in the matmult_spu folder again.
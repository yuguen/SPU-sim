
#include "matmult.h"

//Device Kernel to compute matrix product
//with pipelined block execution


__global__ void matMultiply (float* A, float* B, float* C, int N, int b, int* blk_start, float* g_CB)
{

    __shared__ float s_A[TILE_SIZE][TILE_SIZE];
    __shared__ float s_B[TILE_SIZE][TILE_SIZE];
    __shared__ float s_C[TILE_SIZE][TILE_SIZE];


    int i,j,t;
    int iters = N/TILE_SIZE;
    int num_timeSteps = gridDim.x+gridDim.y+iters-2;
    int start_timeStep = blockIdx.x+blockIdx.y;
    int blk_start_idx = blockIdx.y * gridDim.x + blockIdx.x;

    int A_start_row, A_start_col, B_start_row, B_start_col;

    //Initialize output array in shared mem

    s_C[threadIdx.y][threadIdx.x] = 0;

    A_start_row = blockIdx.y * TILE_SIZE;
    B_start_col = blockIdx.x * TILE_SIZE;

    i = 0;

    for(t=0; t<num_timeSteps; t++)
    {
	if((start_timeStep <=t) && (i<iters))
	{

	    //Record 't' of first iteration
	    if((threadIdx.y*blockDim.x+threadIdx.x ==0) && (i==0))
		blk_start[blk_start_idx] = t;

	    A_start_col = i*TILE_SIZE;
	    B_start_row = A_start_col;

	    //Copy a tile of A to shared mem
	    s_A[threadIdx.y][threadIdx.x] = A[(A_start_row + threadIdx.y)*N+(A_start_col + threadIdx.x)];


	    //Copy corresponding tile of B to shared mem
	    s_B[threadIdx.y][threadIdx.x] = B[(B_start_row + threadIdx.y)*N+(B_start_col + threadIdx.x)];


	    __syncthreads();

	    //Accumulate matrix product for the current input tile in shared mem

	    for(j=0; j<TILE_SIZE; j++)
	    {
	        s_C[threadIdx.y][threadIdx.x] += s_A[threadIdx.y][j] * s_B[j][threadIdx.x];

	    }

	    __syncthreads();

	    i++;
	}
    }


    //Copy computed product tile to global mem
    C[(A_start_row+threadIdx.y)*N + (B_start_col+threadIdx.x)] = s_C[threadIdx.y][threadIdx.x];
    
}

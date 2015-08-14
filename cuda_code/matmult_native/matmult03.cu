/***********************************************
	Matrix Multiplication ver 1.0

Host code for floating point matrix mult
with array for storing timestep of each block's
starting iteration.

Author: Revathy Rajasree
************************************************/


//Headers

#include <stdio.h>
#include "matmult.h"

//Macro for CUDA error handling
#define CUDA_CHECK_RETURN(value) {   \
    cudaError_t _m_cudaStat = value;  \
    if (_m_cudaStat != cudaSuccess) {  \
      fprintf(stderr, "Error: %s at line %d in file %s\n",cudaGetErrorString(_m_cudaStat), __LINE__, __FILE__); \
      exit(1);     \
    } \
}


//Host arrays
float *h_A, *h_B, *h_C;

int *h_blkStart;

//Device arrays
float *d_A, *d_B, *d_C, *g_CB;

int *d_blkStart;

//function declarations
void fillMatrix(float*, int, int);
void fillIdentity(float*, int);
void printMatrix(float*, int, int);
void matMult(float*, float*, float*, int, int, int);
void matMultVerify(float*, float*, float*, int, int, int);
void Cleanup();

//Host code
int main(int argc, char** argv)
{

    int N;

    //Read the arguments
    if(argc <= 1){
	printf("Error: Expected matrix size input.\n");
	exit(0);
    }
    else{
	sscanf(argv[1], "%d", &N);
    }

    N = INPUT_SIZE;

    printf("MATRIX SIZE = %d\n", N);
    printf("TILE SIZE = %d \n", TILE_SIZE);
    printf("\n");

    //Allocate host memory

    h_A = (float *) malloc(N*N*sizeof(float));

    h_B = (float *) malloc(N*N*sizeof(float));

    h_C = (float *) malloc(N*N*sizeof(float));

    //Initialize the input matrices
    fillMatrix(h_A, N, N);
    fillMatrix(h_B, N, N);
    //fillIdentity(h_B, N);
    
    //Allocate memory on device
    //cudaError_t error;
    CUDA_CHECK_RETURN(cudaMalloc((void**)&d_A, N*N*sizeof(float)));
    
    CUDA_CHECK_RETURN(cudaMalloc((void**)&d_B, N*N*sizeof(float)));

    CUDA_CHECK_RETURN(cudaMalloc((void**)&d_C, N*N*sizeof(float)));

    CUDA_CHECK_RETURN(cudaMalloc((void**)&g_CB, 4096*8*NUMBER_OF_SPILLS));



    //Copy inputs to device
    CUDA_CHECK_RETURN(cudaMemcpy(d_A, h_A, N*N*sizeof(float), cudaMemcpyHostToDevice));
    CUDA_CHECK_RETURN(cudaMemcpy(d_B, h_B, N*N*sizeof(float), cudaMemcpyHostToDevice));

    //Compute kernel launch parameters
    int numBlocks, numThreads;

    numThreads = TILE_SIZE;
    numBlocks  = N/TILE_SIZE;

    //Allocate array on device array to record block's starting timestep
    CUDA_CHECK_RETURN(cudaMalloc((void**)&d_blkStart, numBlocks*numBlocks*sizeof(int)));

/*
    if(N % TILE_SIZE == 0) numBlocks = N/TILE_SIZE;
    else numBlocks = (N+TILE_SIZE)/TILE_SIZE;
*/

    printf("Number of blocks  = %d x %d \n", numBlocks, numBlocks);
    printf("Threads per block = %d x %d \n", numThreads, numThreads);


    dim3 dimGrid(numBlocks, numBlocks);
    dim3 dimBlock(numThreads, numThreads); 

    //Launch matrix multiplication kernel on GPU
    matMultiply <<<dimGrid, dimBlock>>> (d_A, d_B, d_C, N, TILE_SIZE, d_blkStart, g_CB);
 
    CUDA_CHECK_RETURN(cudaGetLastError()); 

    CUDA_CHECK_RETURN(cudaThreadSynchronize());

    //copy result from device
    CUDA_CHECK_RETURN(cudaMemcpy(h_C, d_C, N*N*sizeof(float), cudaMemcpyDeviceToHost));

    //verify result with CPU 
    matMultVerify(h_A, h_B, h_C, N, N, N);

    // float *C;
    // C = (float *) malloc(N*N*sizeof(float));

    // matMult(h_A, h_B, C, N, N, N);

    /*
    //Print the matrix
    printf("Input matrix A: \n");
    printMatrix(h_A, N, N);

    printf("\nInput matrix B: \n");
    printMatrix(h_B, N, N);


    //Matrix multiplication on CPU
    matMult(h_A, h_B, h_C, N, N, N);

    printf("\nProduct matrix CPU: \n");
    printMatrix(C, N, N);

    */
   //  printf("\nProduct matrix GPU:\n");
   //  printMatrix(h_C, N, N);


   // int i,j;

 //    fprintf(stderr, "\nProduct CPU :: GPU  \n");
 //    for(i=0; i<N; i++){
	// for(j=0; j<N; j++){
	    
	//    fprintf(stderr, "%7.3f %7.3f \n",C[i*N + j], h_C[i*N + j]);

	// }
	// fprintf(stderr,"\n");

 //    }



//    free(C);


    //allocate array on host to hold threadblocks' starting timestep
    // h_blkStart = (int *) malloc(numBlocks*numBlocks*sizeof(int));

    // //copy the recorded timesteps to host
    // CUDA_CHECK_RETURN(cudaMemcpy(h_blkStart, d_blkStart, numBlocks*numBlocks*sizeof(int), cudaMemcpyDeviceToHost));

 //    //Display each blocks starting timestep
 //    printf("\n Blocks' start schedule:  \n");

 //    for(i=0; i<numBlocks; i++)
 //    {
	// for(j=0; j<numBlocks; j++)
	// {
	//     printf("%4d  ", h_blkStart[i*numBlocks + j]);

	// }
	// printf("\n");
 //    }


    Cleanup();
    return 0;
}

void Cleanup()
{
    //Free host memory
    if(h_A) free(h_A);
    if(h_B) free(h_B);
    if(h_C) free(h_C);
    if(h_blkStart) free(h_blkStart);

    //free device memory
    if(d_A) cudaFree(d_A);
    if(d_B) cudaFree(d_B);
    if(d_C) cudaFree(d_C);
    if(d_blkStart) cudaFree(d_blkStart);

    return;

}

void matMultVerify(float* A, float* B, float* C, int rA, int n, int cB)
{
    int i,j,k;
    float temp;

    for(i=0; i<rA; i++){
        for(j=0; j<cB; j++){

            temp = 0.0;
            for(k=0; k<n; k++){

                temp += A[i*n+k] * B[k*cB+j];
            }
	
	    if (fabs(temp - C[i*cB+j]) > 1e-3){
		printf("Result error: At (%d, %d), CPU val = %f; GPU val = %f \n", i,j,temp,C[i*cB+j] );
		printf("TEST FAILED. \n");
		return;
	    }
        }

    }

    printf("TEST PASSED. \n");
    return;
}


//Matrix multiplication on CPU

void matMult(float* A, float* B, float* C, int rA, int n, int cB)
{
    int i,j,k;

    for(i=0; i<rA; i++){
	for(j=0; j<cB; j++){

	    C[i*cB+j]=0;
	    for(k=0; k<n; k++){
		
		C[i*cB+j] += A[i*n+k] * B[k*cB+j];
	    }
	}

    }

    return;

}

//Function that fills a matrix with real values

void fillMatrix(float* mat, int row_size, int col_size)
{
    int i,j;

    for(i=0; i<row_size; i++)
    {
	for(j=0; j<col_size; j++)
	{
		//mat[i*col_size + j] = ((float(i+1)) *(float)(j+1))/init ;
		mat[i*col_size + j] = ((float)rand())/RAND_MAX ; 
	}

    }
    return;
}

//Function that fills a square matrix of size NxN with identity mtrix

void fillIdentity(float* mat, int N)
{
    int i,j;

    for(i=0; i<N; i++){
	for(j=0; j<N; j++){
		
		if(i==j) mat[i*N + j] = 1.0;
		else     mat[i*N + j] = 0.0;
    	}

    }
    return;
}

//Function to print a matrix

void printMatrix(float* mat, int row_size, int col_size)
{
    int i, j;

    for(i=0; i<row_size; i++){
    	for(j=0; j<col_size; j++){
            // if(mat[i*col_size + j] != 0){
            //     fprintf(stderr, "1");
            // }
            // else{
            //     fprintf(stderr, "0");
            // }
    		fprintf(stderr,"%1.0f", mat[i*col_size + j]);
    	}
        fprintf(stderr, "\n");
    }
}


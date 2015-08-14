#define TILE_SIZE 26

__global__ void MatMulKernel(float* A, float* B, float* C, int N){
	
	int iudir = 0, iuid = 0, iu =0;
	asm("//lol");
	int i = 0,j = 0;
	int iters = N/TILE_SIZE;
	int num_timeSteps = gridDim.x+gridDim.y+iters-1;
	int start_timeStep = blockIdx.x+blockIdx.y+1;
	int A_start_row, A_start_col, B_start_row, B_start_col;


	 __shared__ float cb_A[TILE_SIZE][TILE_SIZE];
	 __shared__ float cb_B[TILE_SIZE][TILE_SIZE];


	//Initialize output array in shared mem

	float c = 0;

	asm("// iu");
	if(iu){
		asm("// iudir");
	  if(iudir==2){
	  	asm("// iuid");
	  	A_start_row = iuid * TILE_SIZE;
	  }  
	  asm("// iudir");
	  if(iudir==0){
	  	asm("// iuid");
	  	B_start_col = iuid * TILE_SIZE;
	  } 
	}
	else{
	  A_start_row = blockIdx.y * TILE_SIZE;
	  B_start_col = blockIdx.x * TILE_SIZE;
	}
	i = 0;

	for(int time_step=0; time_step<num_timeSteps; time_step++){

	  A_start_col = i*TILE_SIZE;
	  B_start_row = A_start_col;
	  asm("// iu");
	  if(iu){
	  	asm("// iudir");
		if(iudir==2){
			asm("// iuid");
			if((time_step>=iuid)&&(i<iters)){
				cb_A[threadIdx.y][threadIdx.x] = A[(A_start_row + threadIdx.y)*N+(A_start_col + threadIdx.x)];
				i++;
	  		}

		}

	    asm("// iudir");
	    if(iudir==0){
	    	asm("// iuid");
			if((time_step>=iuid)&&(i<iters)){
				cb_B[threadIdx.y][threadIdx.x] = B[(B_start_row + threadIdx.y)*N+(B_start_col + threadIdx.x)];
			   	i++;
			}
		}

	  }

	  else{
		if((start_timeStep <= time_step) && (i<iters)){
			

		    //Accumulate matrix product for the current input tile in shared mem

		    for(j=0; j<TILE_SIZE; j++)
		    {
		        c += cb_A[threadIdx.y][j] * cb_B[j][threadIdx.x];

		    }

		    __syncthreads();

		    //Load the tile of A in shared mem to the south CB
		    cb_A[threadIdx.y][threadIdx.x] = cb_A[threadIdx.y][threadIdx.x];
		    cb_B[threadIdx.y][threadIdx.x] = cb_B[threadIdx.y][threadIdx.x];
			
		    i++;
		}

	  }

	  asm("bar.blocksync	0;");

	 
	}

	asm("// iu");
	if(!iu){
	  //Copy computed product tile to global mem
	  C[(A_start_row+threadIdx.y)*N + (B_start_col+threadIdx.x)] = c;
	}
}
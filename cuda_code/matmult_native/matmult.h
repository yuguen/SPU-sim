
#define TILE_SIZE 16
#define INPUT_SIZE 12*TILE_SIZE
#define NUMBER_OF_SPILLS 100

__global__ void matMultiply (float* A, float* B, float* C, int N, int b);

__global__ void matMultiply (float* A, float* B, float* C, int N, int b, int* blk_start, float* g_CB);

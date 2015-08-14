#include "shader.h"

struct spu_barrier_t {
  
	barrier_set_t* bar;
  	warp_set_t warps_in_cta;
  	unsigned bar_id;

};
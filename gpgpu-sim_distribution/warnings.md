## Compilation warnings we should not worry about 
	As already present in original gpgpu-sim  


Makefile:149: /s/parsons/b/others/yohann/Documents/clean/gpgpu-sim_distribution/build/gcc-4.6.3/cuda-4020/release/cuda-sim/Makefile.makedepend: No such file or directory
ptx.y: warning: 1 reduce/reduce conflict [-Wconflicts-rr]
ptx_parser.cc: In function ‘void add_identifier(const char*, int, unsigned int)’:
ptx_parser.cc:413:41: warning: format ‘%x’ expects argument of type ‘unsigned int’, but argument 2 has type ‘new_addr_type {aka long long unsigned int}’ [-Wformat]
ptx_parser.cc:413:41: warning: format ‘%lx’ expects argument of type ‘long unsigned int’, but argument 3 has type ‘long long unsigned int’ [-Wformat]
ptx_parser.cc:431:30: warning: format ‘%x’ expects argument of type ‘unsigned int’, but argument 2 has type ‘new_addr_type {aka long long unsigned int}’ [-Wformat]
ptx_parser.cc:431:30: warning: format ‘%lx’ expects argument of type ‘long unsigned int’, but argument 3 has type ‘long long unsigned int’ [-Wformat]
ptx_parser.cc:451:41: warning: format ‘%x’ expects argument of type ‘unsigned int’, but argument 2 has type ‘new_addr_type {aka long long unsigned int}’ [-Wformat]
ptx_parser.cc:451:41: warning: format ‘%lx’ expects argument of type ‘long unsigned int’, but argument 3 has type ‘long long unsigned int’ [-Wformat]
ptx_parser.cc:468:44: warning: format ‘%x’ expects argument of type ‘unsigned int’, but argument 2 has type ‘new_addr_type {aka long long unsigned int}’ [-Wformat]
ptx_parser.cc:468:44: warning: format ‘%lx’ expects argument of type ‘long unsigned int’, but argument 3 has type ‘long long unsigned int’ [-Wformat]
ptx_parser.cc:481:43: warning: format ‘%x’ expects argument of type ‘unsigned int’, but argument 2 has type ‘new_addr_type {aka long long unsigned int}’ [-Wformat]
ptx_parser.cc:481:43: warning: format ‘%lx’ expects argument of type ‘long unsigned int’, but argument 3 has type ‘long long unsigned int’ [-Wformat]
ptx.l:149: undeclared start condition IN_INST
Makefile:103: /s/parsons/b/others/yohann/Documents/clean/gpgpu-sim_distribution/build/gcc-4.6.3/cuda-4020/release/gpgpu-sim/Makefile.makedepend: No such file or directory
lex.yy.c:1141:17: warning: ‘yyunput’ defined but not used [-Wunused-function]
lex.yy.c:1182:16: warning: ‘input’ defined but not used [-Wunused-function]
networks/flatfly_onchip.cpp: In function ‘int find_distance(int, int)’:
networks/flatfly_onchip.cpp:1207:7: warning: variable ‘_dim_size’ set but not used [-Wunused-but-set-variable]
networks/qtree.cpp: In member function ‘virtual void QTree::_BuildNet(const Configuration&)’:
networks/qtree.cpp:141:12: warning: ‘r’ may be used uninitialized in this function [-Wuninitialized]
networks/anynet.cpp: In member function ‘void AnyNet::readFile()’:
networks/anynet.cpp:494:25: warning: comparison between signed and unsigned integer expressions [-Wsign-compare]
networks/tree4.cpp: In member function ‘int Tree4::_WireLatency(int, int, int, int)’:
networks/tree4.cpp:288:10: warning: ‘L’ may be used uninitialized in this function [-Wuninitialized]
networks/dragonfly.cpp: In function ‘int dragonfly_port(int, int, int)’:
networks/dragonfly.cpp:114:7: warning: variable ‘group_dest’ set but not used [-Wunused-but-set-variable]
networks/dragonfly.cpp: In member function ‘virtual void DragonFlyNew::_BuildNet(const Configuration&)’:
networks/dragonfly.cpp:359:9: warning: variable ‘_grp_num_routers’ set but not used [-Wunused-but-set-variable]
networks/dragonfly.cpp:361:9: warning: variable ‘grp_ID2’ set but not used [-Wunused-but-set-variable]
networks/dragonfly.cpp:224:7: warning: variable ‘_dim_size’ set but not used [-Wunused-but-set-variable]
networks/dragonfly.cpp: In function ‘void ugal_dragonflynew(const Router*, const Flit*, int, OutputSet*, bool)’:
networks/dragonfly.cpp:498:23: warning: variable ‘min_hopcnt’ set but not used [-Wunused-but-set-variable]
networks/dragonfly.cpp:499:26: warning: variable ‘nonmin_hopcnt’ set but not used [-Wunused-but-set-variable]
networks/kncube.cpp: In member function ‘virtual void KNCube::InsertRandomFaults(const Configuration&)’:
networks/kncube.cpp:309:8: warning: ‘chan’ may be used uninitialized in this function [-Wuninitialized]
networks/kncube.cpp:308:37: warning: ‘node’ may be used uninitialized in this function [-Wuninitialized]
Makefile:83: /s/parsons/b/others/yohann/Documents/clean/gpgpu-sim_distribution/build/gcc-4.6.3/cuda-4020/release/Makefile.makedepend: No such file or directory
mcpat.mk:105: /s/parsons/b/others/yohann/Documents/clean/gpgpu-sim_distribution/build/gcc-4.6.3/cuda-4020/release/gpuwattch/Makefile.makedepend: No such file or directory
cacti.mk:65: /s/parsons/b/others/yohann/Documents/clean/gpgpu-sim_distribution/build/gcc-4.6.3/cuda-4020/release/gpuwattch/cacti/Makefile.makedepend: No such file or directory
Makefile:140: /s/parsons/b/others/yohann/Documents/clean/gpgpu-sim_distribution/build/gcc-4.6.3/cuda-4020/release/libcuda/Makefile.makedepend: No such file or directory
Makefile:122: /s/parsons/b/others/yohann/Documents/clean/gpgpu-sim_distribution/build/gcc-4.6.3/cuda-4020/release/libopencl/Makefile.makedepend: No such file or directory
In file included from opencl_runtime_api.cc:98:0:
/usr/local/cuda4/include/CL/cl.h:524:2: warning: #warning CL_USE_DEPRECATED_OPENCL_1_0_APIS is defined. These APIs are unsupported and untested in OpenCL 1.1! [-Wcpp]
Makefile:81: /s/parsons/b/others/yohann/Documents/clean/gpgpu-sim_distribution/build/gcc-4.6.3/cuda-4020/release/cuobjdump_to_ptxplus/Makefile.makedepend: No such file or directory
../src/cuda-sim/ptx.y: warning: 1 reduce/reduce conflict [-Wconflicts-rr]
../src/cuda-sim/ptx.l:149: undeclared start condition IN_INST
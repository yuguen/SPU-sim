
## Variables
SDK_INSTALL_PATH :=  /home/yohann/Documents/export_yo/cuda4/sdk/C
LIB       :=  -L$(SDK_INSTALL_PATH)/lib  -lcutil_x86_64
INCLUDES  :=  -I$(SDK_INSTALL_PATH)/common/inc
#OPTIONS   :=  -O3 --ptxas-options -v
OPTIONS   :=  -O0 -Xopencc -O0 -Xptxas -O0

######################################################################

matmult00 : matmult.cu matmult.h matmultKernel02.o
	nvcc $< matmultKernel02.o -o $@ $(LIB) $(INCLUDES) $(OPTIONS)

matmultKernel02.o : matmultKernel02.cu
	nvcc $< -c -o $@ $(OPTIONS)


matmult03 : matmult03.cu matmult.h matmultKernel03.o
	nvcc $< matmultKernel03.o -o $@ $(LIB) $(INCLUDES) $(OPTIONS)

matmultKernel03.o : matmultKernel03.cu
	nvcc $< -c -o $@ $(OPTIONS)


clean:
	rm matmult03 *.o

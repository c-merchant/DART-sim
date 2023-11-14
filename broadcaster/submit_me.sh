 #!/bin/bash
 #PBS -A P86850054
 #PBS -N node1
 #PBS -q main
 #PBS -j oe
 #PBS -M cmerchant@princeton.edu
 #PBS -l walltime=00:60:00
 #PBS -l select=1:ncpus=128:mpiprocs=128
 ### Set TMPDIR as recommended
 export TMPDIR=$SCRATCH/temp
 mkdir -p $TMPDIR
 # module load linaro-forge
 # First, create the sampler library
 # make-profiler-libraries --platform=cray --lib-type=shared
 # Now, link sampler library into executable
 # mpicc -L$(PWD) -lmap-sampler-pmpi -lmap-sampler -Wl,--eh-frame-hdr -Wl,-rpath=$(PWD) -o ./broadcast_base main.o driver.o physics.o
 ### Run the executable
 mpiexec  -n 128 ./broadcast_base 8000 400

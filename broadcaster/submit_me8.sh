#!/bin/bash
#PBS -A P86850054
#PBS -N node8
#PBS -q main
#PBS -j oe
#PBS -M cmerchant@princeton.edu
#PBS -l walltime=00:60:00
#PBS -l select=8:ncpus=128:mpiprocs=128
### Set TMPDIR as recommended
export TMPDIR=$SCRATCH/temp
mkdir -p $TMPDIR
# module load linaro-forge
# First, create the sampler library
# make-profiler-libraries --platform=cray --lib-type=shared
# Now, link sampler library into executable
# mpicc -L$(PWD) -lmap-sampler-pmpi -lmap-sampler -Wl,--eh-frame-hdr -Wl,-rpath=$(PWD) -o ./broadcast_base main.o driver.o physics.o
### Run the executable

mpiexec  -n 1024 ./broadcast_base 8000 80
mpiexec  -n 1024 ./broadcast_base 16000 80
mpiexec  -n 1024 ./broadcast_base 32000 80
mpiexec  -n 1024 ./broadcast_base 64000 80
mpiexec  -n 1024 ./broadcast_base 128000 80
mpiexec  -n 1024 ./broadcast_base 256000 80
mpiexec  -n 1024 ./broadcast_base 512000 80
mpiexec  -n 1024 ./broadcast_base 768000 80
mpiexec  -n 1024 ./broadcast_base 1024000 80

mpiexec  -n 1024 ./broadcast_base 8000 160
mpiexec  -n 1024 ./broadcast_base 16000 160
mpiexec  -n 1024 ./broadcast_base 32000 160
mpiexec  -n 1024 ./broadcast_base 64000 160
mpiexec  -n 1024 ./broadcast_base 128000 160
mpiexec  -n 1024 ./broadcast_base 256000 160
mpiexec  -n 1024 ./broadcast_base 512000 160
mpiexec  -n 1024 ./broadcast_base 768000 160
mpiexec  -n 1024 ./broadcast_base 1024000 160

mpiexec  -n 1024 ./broadcast_base 8000 240
mpiexec  -n 1024 ./broadcast_base 16000 240
mpiexec  -n 1024 ./broadcast_base 32000 240
mpiexec  -n 1024 ./broadcast_base 64000 240
mpiexec  -n 1024 ./broadcast_base 128000 240
mpiexec  -n 1024 ./broadcast_base 256000 240
mpiexec  -n 1024 ./broadcast_base 512000 240
mpiexec  -n 1024 ./broadcast_base 768000 240
mpiexec  -n 1024 ./broadcast_base 1024000 240

mpiexec  -n 1024 ./broadcast_base 8000 320
mpiexec  -n 1024 ./broadcast_base 16000 320
mpiexec  -n 1024 ./broadcast_base 32000 320
mpiexec  -n 1024 ./broadcast_base 64000 320
mpiexec  -n 1024 ./broadcast_base 128000 320
mpiexec  -n 1024 ./broadcast_base 256000 320
mpiexec  -n 1024 ./broadcast_base 512000 320
mpiexec  -n 1024 ./broadcast_base 768000 320
mpiexec  -n 1024 ./broadcast_base 1024000 320

mpiexec  -n 1024 ./broadcast_base 8000 400
mpiexec  -n 1024 ./broadcast_base 16000 400
mpiexec  -n 1024 ./broadcast_base 32000 400
mpiexec  -n 1024 ./broadcast_base 64000 400
mpiexec  -n 1024 ./broadcast_base 128000 400
mpiexec  -n 1024 ./broadcast_base 256000 400
mpiexec  -n 1024 ./broadcast_base 512000 400
mpiexec  -n 1024 ./broadcast_base 768000 400
mpiexec  -n 1024 ./broadcast_base 1024000 400


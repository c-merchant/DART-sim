program broadcaster
  use mpi

  implicit none

  integer :: i, N
  integer :: root
  integer :: ierr, ntasks, rank
  integer :: c
  double precision, allocatable :: buffer(:)
  double precision :: start_time, end_time, broadcast_time
  character(len=32) :: arg

  call mpi_init(ierr)
  call mpi_comm_size(mpi_comm_world, ntasks, ierr)
  call mpi_comm_rank(mpi_comm_world, rank, ierr)

  ! Check for command line arguments
  if (iargc() .lt. 2) then
     if (rank == 0) then
        print *, 'Error: Two arguments required - number of steps (N) and buffer size (c).'
     endif
     call mpi_abort(mpi_comm_world, 1, ierr)
  endif

  ! Get the number of steps
  call get_command_argument(1, arg)
  read(arg, *) N
  ! Get the buffer size
  call get_command_argument(2, arg)
  read(arg, *) c

  allocate(buffer(c))
  buffer(:) = rank

  broadcast_time = 0.0

  start_time = mpi_wtime()

  do i = 0, N-1
     root = modulo(i, ntasks)
     call mpi_bcast(buffer, c, mpi_double_precision, root, mpi_comm_world, ierr)
  end do

  end_time = mpi_wtime()
  broadcast_time = end_time - start_time

  ! Print the rank and the total time taken for broadcasting
  print *, 'Rank ', rank, ' total time for broadcasting: ', broadcast_time

  deallocate(buffer)

  call mpi_finalize(ierr)

  print *, 'END OF RUN'
end program broadcaster

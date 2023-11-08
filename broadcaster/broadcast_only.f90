program broadcaster

  use mpi

  implicit none

  integer :: i, N ! loop variables
  integer :: root ! root process for broadcasting
  integer :: ierr, ntasks, rank ! mpi variables
  integer :: c ! count of broadcast elements
  double precision, allocatable :: buffer(:) ! allocate a buffer
  double precision :: start_time, end_time, broadcast_time ! timing variables
  
  ! initialize MPI environment
  call mpi_init(ierr)
  ! get the total number of processes
  call mpi_comm_size(mpi_comm_world, ntasks, ierr)
  ! get the rank of the current process
  call mpi_comm_rank(mpi_comm_world, rank, ierr)

  ! Parameters that can be adjusted based on the simulation requirements
  N = 4000 ! steps in sequential_obs do
  c = 80 ! size of the data buffer

  allocate(buffer(c))
  buffer(:) = rank

  ! Initialize timing
  broadcast_time = 0.0

  ! Perform the broadcast N times and measure the time taken
  do i = 0, N-1
     root = modulo(i, ntasks)
     call mpi_barrier(mpi_comm_world, ierr) ! synchronize before timing
     call mpi_wtime(start_time)
     call mpi_bcast(buffer, c, mpi_double_precision, root, mpi_comm_world, ierr)
     call mpi_wtime(end_time)
     broadcast_time = broadcast_time + (end_time - start_time)
  end do

  ! Print out the total time taken for broadcasting
  if (rank == 0) then
     print *, 'Total time for broadcasting: ', broadcast_time
  endif

  deallocate(buffer)

  call mpi_finalize(ierr)

end program broadcaster


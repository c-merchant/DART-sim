program broadcaster

use mpi

implicit none

integer :: i, N ! loop variables
integer :: root ! round-robin currently in DART
integer :: ierr, ntasks, rank ! mpi
integer :: c ! count of broadcast elemenst
double precision, allocatable  :: buffer(:)

call mpi_init(ierr)
call mpi_comm_size(mpi_comm_world, ntasks, ierr)
call mpi_comm_rank(mpi_comm_world, rank, ierr)

N = 4000 ! steps in sequential_obs do
c = 80

allocate(buffer(c)) 
buffer(:) = rank

do i = 0, N-1 
   root = modulo(i, ntasks)
   call mpi_bcast(buffer, c, mpi_double_precision, root, mpi_comm_world, ierr)
enddo

deallocate(buffer)

call mpi_finalize(ierr)

end program broadcaster

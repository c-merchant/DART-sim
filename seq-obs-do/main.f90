program seqobsdo

use mpi_utilities_mod,    only : initialize_mpi_utilities, &
                                 finalize_mpi_utilities, &
                                 broadcast_send, broadcast_recv, &
                                 my_task_id, task_count
use types_mod,            only : r8, i8
use ensemble_manager_mod, only : ensemble_type, init_ensemble_manager

implicit none

integer :: i, ob, s ! loop variables
integer :: root ! round-robin currently in DART
integer :: rank, ntasks ! do we have to look at my_pe separately to rank?
integer :: num_close_obs, num_close_state

integer :: ens_size
integer :: N ! num_obs_in_set
integer :: num_groups

integer :: TOTAL_OBS_COPIES
real(r8) :: obs_err_var, my_inflate, my_inflate_sd
real(r8) :: obs_qc
real(r8) :: vertvalue_obs_in_localization_coord, whichvert_real

! ens_size arrays
real(r8), allocatable :: obs_prior(:), obs_inc(:)

! num_groups size arrays
real(r8), allocatable :: obs_prior_mean(:)
real(r8), allocatable :: orig_obs_prior_mean(:), orig_obs_prior_var(:)

type(ensemble_type) :: obs_ens_handle

call initialize_mpi_utilities('seqobsdo')

rank = my_task_id()
ntasks = task_count()

ens_size = 80
TOTAL_OBS_COPIES = ens_size + 6
N = 100 
num_groups = 1

num_close_obs = 11
num_close_state = 24

! Fill up the scalars
obs_err_var = 3.99_r8
my_inflate = 0.9_r8
my_inflate_sd = 0.9_r8
obs_qc = 0.0_r8 ! should
vertvalue_obs_in_localization_coord = 54789.39_r8
whichvert_real = 2.0_r8

! fill up the arrays
allocate(obs_prior(ens_size), obs_inc(ens_size))
allocate(obs_prior_mean(num_groups), &
         orig_obs_prior_mean(num_groups),     &
         orig_obs_prior_var(num_groups))

obs_prior(:) = 234.0_r8
obs_inc(:) = 5235.0_r8
obs_prior_mean = 58.0_r8
orig_obs_prior_mean = 59.0_r8
orig_obs_prior_var = 340.3_r8
!--------

! create ensemble
call init_ensemble_manager(obs_ens_handle, TOTAL_OBS_COPIES, &
                           int(N,i8), 1, transpose_type_in = 2)

! Sequential obs do
SEQUENTIAL_OBS: do i = 0, N-1 ! loop around observations
 
   root = modulo(i, ntasks)

   if (rank == root) then ! task owns the observation

      call broadcast_send(root,                              & 
         obs_prior,                                          &
         orig_obs_prior_mean,                                &
         orig_obs_prior_var,                                 &
         scalar1=obs_qc,                                     &
         scalar2=vertvalue_obs_in_localization_coord,        &
         scalar3=whichvert_real,                             &
         scalar4=my_inflate,                                 &
         scalar5=my_inflate_sd)

    else

      call broadcast_recv(root,                              &
         obs_prior,                                          &
         orig_obs_prior_mean,                                &
         orig_obs_prior_var,                                 & 
         scalar1=obs_qc,                                     &
         scalar2=vertvalue_obs_in_localization_coord,        &
         scalar3=whichvert_real,                             &
         scalar4=my_inflate,                                 &
         scalar5=my_inflate_sd)

   endif

   if(nint(obs_qc) /= 0) cycle SEQUENTIAL_OBS

   do ob = 1, num_close_obs
      call sim_obs_updates()
   enddo
   do s = 1, num_close_state
      call sim_state_updates()
   enddo
enddo SEQUENTIAL_OBS

deallocate(obs_prior, obs_inc)
deallocate(obs_prior_mean, orig_obs_prior_mean, orig_obs_prior_var)

call finalize_mpi_utilities()

end program seqobsdo

!--------
subroutine sim_obs_updates()

implicit none


end subroutine sim_obs_updates


!--------
subroutine sim_state_updates()

implicit none


end subroutine sim_state_updates


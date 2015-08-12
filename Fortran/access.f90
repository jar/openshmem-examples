!
!
! Copyright (c) 2011 - 2015
!   University of Houston System and Oak Ridge National Laboratory.
!
! All rights reserved.
!
! Redistribution and use in source and binary forms, with or without
! modification, are permitted provided that the following conditions
! are met:
!
! o Redistributions of source code must retain the above copyright notice,
!   this list of conditions and the following disclaimer.
!
! o Redistributions in binary form must reproduce the above copyright
!   notice, this list of conditions and the following disclaimer in the
!   documentation and/or other materials provided with the distribution.
!
! o Neither the name of the University of Houston System, Oak Ridge
!   National Laboratory nor the names of its contributors may be used to
!   endorse or promote products derived from this software without specific
!   prior written permission.
!
! THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
! "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
! LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
! A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
! HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
! SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
! TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
! PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
! LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
! NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
! SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
!

program a

  include 'shmem.fh'

  integer :: _my_pe

  integer :: me

  integer, save :: x   ! symmetric
  integer :: y         ! not symmetric

  pointer (p, pat)


  x = 99
  y = 42

  call start_pes (0)
  me = _my_pe()

  call shmem_barrier_all()

  if (shmem_pe_accessible(1)) then
    print *, me, ': PE 1 reachable: yes'
  else
    print *, me, ': PE 1 reachable: no'
  end if

  call sleep(1)

  if (shmem_addr_accessible(x, 1)) then
    print *, me, ': Var x reachable: yes'
  else
    print *, me, ': Var x reachable: no'
  end if

  call sleep(1)

  if (shmem_addr_accessible(y, 1)) then
    print *, me, ': Var y reachable: yes'
  else
    print *, me, ': Var y reachable: no'
  end if

  call sleep(1)

  p = shmem_ptr(x, 1)

  print *, me, ': shmem_ptr returned', p

end program

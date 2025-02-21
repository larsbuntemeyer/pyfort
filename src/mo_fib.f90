module mo_fib

    implicit none

    real :: x

    contains
    
        subroutine initialize_x()
            x = 1.0
        end subroutine initialize_x

end module mo_fib

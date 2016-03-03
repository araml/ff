program stack_test
use stack
implicit none
    type(stack_t) :: s 
    integer       :: i
    
    call stack_init(s)
    write (*,*), "the stack size is: ", stack_size(s)
    call stack_push(s, 5)
    call stack_push(s, 20)
    call stack_push(s, 12)
    write(*,*), "the stack top should be 12, stack top : ", stack_top(s)
    call stack_pop(s)
    write(*,*), "the stack top should be 12, stack top : ", stack_top(s)
    call stack_delete(s)
    
    ! Test insertion of many elements
    call stack_init(s)  
    do i = 1, 100
        call stack_push(s, i)
    end do

    do i = 100, 1, -1
        write (*, *), "i =", i, " top = ", stack_top(s)
        call stack_pop(s)
    end do

    call stack_delete(s)

end program stack_test

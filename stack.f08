module stack
    ! Stack of integers to pop and push the positions in code of
    ! [ ] \ffuck.f08
    implicit none
    private

    public :: stack_t
    public :: stack_init
    public :: stack_push
    public :: stack_pop
    public :: stack_top
    public :: stack_size
    public :: stack_delete
    type :: stack_t
        private
        ! used size
        integer :: m_size
        ! allocated size
        integer :: m_asize 
        integer, allocatable :: m_stack(:) 
    end type

contains
    subroutine stack_init(self)
        type(stack_t) :: self
        self%m_size  = 1
        self%m_asize = 1
    end subroutine stack_init

    function stack_size(self) result(ret)
        type(stack_t) :: self
        integer :: ret
        ret = self%m_size
    end function stack_size

    ! Copy value ontop of the stack
    ! If we already had as much elements as we could store
    ! we resize the stack (1.5 * size)
    subroutine stack_push(self, value)
        type(stack_t) :: self
        integer       :: value
        if (self%m_size == self%m_asize) then
            call stack_resize(self)
        end if
        self%m_stack(self%m_size) = value
        self%m_size = self%m_size + 1
    end subroutine stack_push

    subroutine stack_pop(self)
        type(stack_t) :: self
        if (self%m_size > 1) then
            self%m_size = self%m_size - 1
        end if
    end subroutine stack_pop

    ! Must be called with at least one element
    function stack_top(self) result(ret)
        integer       :: ret
        type(stack_t) :: self
        if (self%m_size > 1) then
            ret = self%m_stack(self%m_size - 1)
        end if
    end function stack_top

    subroutine stack_resize(self)
        type(stack_t)        :: self
        integer, allocatable :: temp(:)
        integer              :: temp_asize
        allocate(temp((3*(size(self%m_stack) + 1))/2))
        temp_asize  = (3*(size(self%m_stack)+1))/2
        if (self%m_size > 1) then
            temp(1:size(self%m_stack)) = self%m_stack
            deallocate(self%m_stack)
        end if
        call move_alloc(temp, self%m_stack)
        self%m_asize = temp_asize
    end subroutine stack_resize


    subroutine stack_delete(self)
        type(stack_t) :: self
        deallocate(self%m_stack)
    end subroutine stack_delete
end module stack


module utility
implicit none
    private
    public :: load_program
    public :: jmp_fwd
    !We load the subroutine in a string.
    !Since we have to read line by line and we can't go back
contains
    subroutine load_program (unit, filename, program_buffer)
        integer                     :: unit, i, ios
        character (len=40)          :: filename
        character (:), allocatable  :: program_buffer 
        character (len=999)         :: line_buffer
        open(unit, file=filename)
        do
            read(unit, '(A)', iostat=ios) line_buffer
            if (ios .ne. 0) exit
            !print *, line_buffer
            do i = 1, len(line_buffer)
                if (line_buffer(i:i) .ne. ' ') then
                    program_buffer = program_buffer // line_buffer(i:i)
                end if
            end do
        end do
       close(unit)
    end subroutine load_program

    function jmp_fwd (program_buffer, PC) result(ret)
        character (:), allocatable  :: program_buffer 
        integer                     :: ret, PC
        do 
            if (program_buffer(PC:PC) == "]") then
                ret = PC
                exit
            else 
                PC = PC + 1
            end if
        end do
    end function
end module utility

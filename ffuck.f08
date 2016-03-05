program ffuck
    use stack
    use utility
    ! Fortran brainfuck interpreter
    ! github.com/araml
    ! Variables
    implicit none
    character (len=40)                  :: filename
    character (:), allocatable          :: program_buffer
    character (:), allocatable          :: output   ! output string.
    character (len=999)                 :: line_buffer
    integer                             :: count, i, len_buffer, idx
    integer                             :: unit = 10
    integer(kind=1), dimension(10000)   :: tape
    integer(kind=4)                     :: PC
    character                           :: input
    type(stack_t)                       :: mstack
    PC  = 1
    idx = 1

    ! Parse line arguments
    count = command_argument_count()
    if (count == 1) then
        call get_command_argument(1, filename)
        write (*, *) "File is: ", filename
    else if (count == 0) then
        print *, "ffuck, Fortran Brainfuck Interpreter"
        print *, "Write your bf file name"
        read *, filename
        print *, filename
    else 
        print *, "Error!!! too many arguments!"
    end if

    ! we clear the tape
    call clear_tape(tape)
    ! init the stack for [ ]
    call stack_init(mstack)

    ! we get the program in the program_buffer
    call load_program(unit, filename, program_buffer)
    print *, program_buffer

    ! Program length (spaces are removed in load program
    ! but non bf characters are counted) 
    len_buffer = len(program_buffer)

    ! Main loop of the interpreter 
    do 
        select case (program_buffer(PC:PC))
            case (">")
                idx = idx + 1
                PC = PC + 1    
            case ("<")
                idx = idx - 1
                PC = PC + 1
            case ("+")
                tape(idx) = tape(idx) + 1
                PC = PC + 1
            case ("-")
                tape(idx) = tape(idx) - 1
                PC = PC + 1
            case (".")
                output = output // char(tape(idx))
                PC = PC + 1
            case (",")
                read *, input
                tape(idx) = ichar(input)
                PC = PC + 1
            case ("[")
                call stack_push(mstack, PC)
                if (tape(idx) == 0) then
                    PC = jmp_fwd(program_buffer, PC)
                else 
                    PC = PC + 1
                end if
            case ("]")
                if (tape(idx) .ne. 0) then
                    PC = stack_top(mstack)
                    call stack_pop(mstack)
                else 
                    PC = PC + 1
                    call stack_pop(mstack)
                end if
            case default
                PC = PC + 1
        end select
        ! if we got to the end of the program we exit
        if (PC == len_buffer) exit
    end do

    print *, output

    ! Deallocate the program_buffer
    if (allocated(program_buffer))   deallocate(program_buffer)
    if (allocated(output))           deallocate(output)
end program


subroutine clear_tape (tape)
    integer :: j
    integer (kind=1), dimension(10000) :: tape
    ! Set the tape's cells to zero.
    do j = 1, 10000
        tape(j) = 0
    end do
end subroutine clear_tape


addi x28, x0, 5          # initial value
addi x2,  x0, 511        # stack pointer
addi x5,  x0, 768        # switch address (0x300)
addi x6,  x0, 512        # LED address (0x200)
sw x28, 0(x5)            # store initial value

WAIT:
    sw x0, 0(x6)         # clear LEDs

INPUT_CHECK:
    lw x11, 0(x5)        # read switch value
    beq x11, x0, INPUT_CHECK   # stay if zero
    add x10, x11, x0     # copy switch value
    jal x1, COUNT_PROC   # call countdown function
    beq x0, x0, WAIT     # go back to WAIT

COUNT_PROC:
    addi x2, x2, -8
    sw x1, 4(x2)         # save return address
    sw x12, 0(x2)        # save counter
    add x12, x10, x0     # initialize counter

LOOP_DEC:
    sw x12, 0(x6)        # display on LEDs
    beq x12, x0, END_PROC
    addi x12, x12, -1    # decrement counter
    addi x13, x0, 3

DELAY_WAIT:
    addi x13, x13, -1
    bne x13, x0, DELAY_WAIT
    beq x0, x0, LOOP_DEC

END_PROC:
    sw x0, 0(x6)
    lw x12, 0(x2)
    lw x1, 4(x2)
    addi x2, x2, 8

    ret
 
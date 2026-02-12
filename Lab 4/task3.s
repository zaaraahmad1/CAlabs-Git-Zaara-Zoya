.text
.globl main

main:

    addi x10, x0, 256        # base address = 0x100

    addi x5, x0, 1
    sw x5, 0(x10)
    addi x5, x0, 5
    sw x5, 4(x10)
    addi x5, x0, 4
    sw x5, 8(x10)
    addi x5, x0, 3
    sw x5, 12(x10)
    addi x5, x0, 6
    sw x5, 16(x10)
    addi x5, x0, 2
    sw x5, 20(x10)

    addi x11, x0, 6          # len = 6

    jal x1, bubble

    addi x17, x0, 10         # ecall exit
    ecall

bubble:

    beq  x10, x0, exit
    beq  x11, x0, exit

    addi x5, x0, 0           # i = 0

outer_loop:
    bge  x5, x11, exit

    addi x6, x5, 0           # j = i

inner_loop:
    bge  x6, x11, next_i

    slli x7, x5, 2
    add  x7, x10, x7
    lw   x28, 0(x7)

    slli x8, x6, 2
    add  x8, x10, x8
    lw   x29, 0(x8)

    bge  x28, x29, next_j

    sw   x29, 0(x7)
    sw   x28, 0(x8)

next_j:
    addi x6, x6, 1
    jal  x0, inner_loop

next_i:
    addi x5, x5, 1
    jal  x0, outer_loop

exit:
    jalr x0, 0(x1)

.text
.globl main

main:
    addi x10, x0, 5      # a = 3
    addi x11, x0, 2      # b = 4

    jal  x1, compute     # call compute(a,b)

after_main:
    jal  x0, after_main  #loop

# compute(a, b)
# x10 = a
# x11 = b
# return in x10

compute:
    addi x2, x2, -16     # create stack frame
    sw   x1, 12(x2)      # save ra
    sw   x10, 8(x2)      # save a
    sw   x11, 4(x2)      # save b
    sw   x5, 0(x2)       # save temp

    # square a
    jal  x1, square
    addi x5, x10, 0      # store square(a)

    # square b
    lw   x10, 4(x2)      # load b
    jal  x1, square

    # add results
    addi x11, x10, 0     # second operand
    addi x10, x5, 0      # first operand
    jal  x1, add_proc

    # restore registers
    lw   x5, 0(x2)
    lw   x1, 12(x2)
    addi x2, x2, 16
    jalr x0, 0(x1)

# square(x)
# x10 = input
# return x10 = x * x

square:
    addi x2, x2, -8
    sw   x1, 4(x2)
    sw   x5, 0(x2)

    addi x5, x10, 0
    mul  x10, x10, x5    # x * x

    lw   x5, 0(x2)
    lw   x1, 4(x2)
    addi x2, x2, 8
    jalr x0, 0(x1)

# add_proc(x, y)
# x10 = x
# x11 = y
# return x10 = x + y

add_proc:
    add  x10, x10, x11
    jalr x0, 0(x1)

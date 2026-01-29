.text
.globl main4

main:
    li x5, 4            # a = 4
    li x6, 3            # b = 3
    li x7, 0            # i = 0
    li x10, 0x500       # base address of D

Outer_Loop:
    bge x7, x5, end     # if i >= a, exit outer loop
    li x29, 0           # j = 0

Inner_Loop:
    slli x28, x29, 2    # offset = 4 * j
    add  x30, x7, x29  # temp = i + j
    add  x31, x10, x28 # address of D[4*j]
    sw   x30, 0(x31)   # D[4*j] = i + j

    addi x29, x29, 1   # j++
    blt  x29, x6, Inner_Loop

    addi x7, x7, 1     # i++
    j Outer_Loop

end:
    j end
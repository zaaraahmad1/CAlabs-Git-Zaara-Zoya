.text
.globl main3
main:
    li x10, 10          # upper bound (10)
    li x18, 0           # i
    li x19, 0           # sum
    li x20, 0           # offset
    li x21, 0x200       # base address of array a

    First_loop:
        add  x25, x21, x20         #address of a[i]
        sw   x18, 0(x25)     # a[i] = i
        addi x18, x18, 1
        addi x20, x20, 4
        blt  x18, x10, First_loop

    li x20, 0           # reset offset
    li x18, 0           # reset i

    Sec_loop:
        add  x25, x21, x20     #address of a[i]
        lw   x26, 0(x25)     # load a[i]
        add  x19, x19, x26  # sum = sum + a[i]
        addi x18, x18, 1
        addi x20, x20, 4
        blt  x18, x10, Sec_loop

end:
    j end 
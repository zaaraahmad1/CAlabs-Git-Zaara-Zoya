.text
.globl main

main:
    li x10, 15        # g
    li x11, 7         # h
    li x12, 4         # i
    li x13, 2         # j

    jal x1, leaf

    j end

leaf:
    addi x2, x2, -12      #stack

    sw x18, 0(x2)         
    sw x19, 4(x2)
    sw x20, 8(x2)

    add x18, x10, x11     # g + h
    add x19, x12, x13     # i + j
    sub x20, x18, x19     # f = (g + h) - (i + j)

    addi x10, x20, 0     

    lw x18, 0(x2)         
    lw x19, 4(x2)
    lw x20, 8(x2)

    addi x2, x2, 12       # deallocate stack
    jalr x0, 0(x1)        # return value in x10

end:

.text
.globl main

main:
    addi x10, x0, 12        # a = 12
    addi x11, x0, 12        # b = 12

    jal x1, sum             # calls the function named sum

    addi x11, x10, 0   
    li x10, 1              
    ecall

    j end       

sum:
    add x10, x11, x10       # x10 = a + b
    jalr x0, 0(x1)

end:
    j end

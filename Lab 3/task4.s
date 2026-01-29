.text
.globl main

main:
    li x10, 0x200        # destination x[]
    li x11, 0x300       # source y[]

    li x5, 104           # 'h'
    sb x5, 0(x11)
    li x5, 101           # 'e'
    sb x5, 1(x11)
    li x5, 121           # 'y'
    sb x5, 2(x11)
    li x5, 0             # '\0'
    sb x5, 3(x11)

    jal x1, strcpy

    li x17, 10
    ecall


strcpy:
    addi sp, sp, -4
    sw x19, 0(sp)

    addi x19, x0, 0      # i = 0

loop:
    add x5, x11, x19
    lbu x6, 0(x5)

    add x5, x10, x19
    sb x6, 0(x5)

    beq x6, x0, done

    addi x19, x19, 1
    j loop

done:
    lw x19, 0(sp)
    addi sp, sp, 4
    jalr x0, 0(x1)

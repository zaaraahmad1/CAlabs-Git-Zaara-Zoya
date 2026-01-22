.text
.globl main1

main:
    li x8, 2
    sb x8, 0(x25)
    li x8, 2
    sb x8, 1(x25)
    li x8, 4
    sb x8, 2(x25)
    li x8, 2

    Loop: slli x10, x22, 3
    add x10, x10, x25
    ld x9, 0(x10)
    bne x9, x24, Exit
    addi x22, x22, 1
    beq x0, x0, Loop
    Exit:

end:
    j end
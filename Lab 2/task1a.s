.text
.globl main

main:
    li x20, 4
    li x21, 3
    li x22, 5
    li x23, 5

    bne x22, x23, Else
    add x19, x20, x21
    beq x0, x0, Exit

    Else: sub x19, x20, x21
    Exit:

end:
    j end
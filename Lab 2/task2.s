.text
.globl main2

main:
    li x20, 1 
    li x22, 5
    li x23, 6

    li x5, 1
    beq x5, x20, Case1

    li x6, 2
    beq x6, x20, Case2

    li x7, 3
    beq x7, x20, Case3

    li x8, 4
    beq x8, x20, Case4

    li x21, 0
    j Exit

    Case1:
    add x21, x22, x23
    j Exit

    Case2:
    sub x21, x22, x23
    j Exit

    Case3:
    slli x21, x22, 1
    j Exit

    Case4:
    srai x21, x22, 1
    j Exit

Exit:
    j Exit
.text
.globl main4
main:
    li x10, 0x100
    li x11, 0x200
    li x12, 0x300

    #Array A
    li x8, 1
    sb x8, 0(x10)
    li x8, 2
    sb x8, 1(x10)
    li x8, 3
    sb x8, 2(x10)
    li x8, 4
    sb x8, 3(x10)

    #Array B
    li x9, 5
    sh x9, 0(x11)
    li x9, 6
    sh x9, 2(x11)
    li x9, 7
    sh x9, 4(x11)
    li x9, 8
    sh x9, 6(x11)

    #Addition
    lb x13, 0(x10)
    lh x14, 0(x11)
    add x15, x13, x14
    sw x15, 0(x12) 

    lb x13, 1(x10)
    lh x14, 2(x11)  
    add x15, x13, x14
    sw x15, 4(x12)

    lb x13, 2(x10)
    lh x14, 4(x11)
    add x15, x13, x14
    sw x15, 8(x12)

    lb x13, 3(x10)
    lh x14, 6(x11)
    add x15, x13, x14
    sw x15, 12(x12)

end:
    j end
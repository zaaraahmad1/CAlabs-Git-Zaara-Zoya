.text
.globl main2
main:
    li x10, 5   #a=5
    li x12, 0   #b=0

    addi x12, x12, 0

    addi x10, x12, 32
    
    li x13, 0   #d=0
    add x13, x10, x12
    addi x13, x13, -5

    li x14, 0   #e=0
    sub x14, x10, x13
    sub x15, x12, x10 
    add x14, x14, x15
    add x14, x14, x13

    add x14, x10, x12 
    add x14, x13, x14 


end:
    j end

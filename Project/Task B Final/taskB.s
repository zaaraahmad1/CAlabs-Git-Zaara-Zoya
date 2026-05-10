# x6 = LED output address

addi x6, x0, 512
 
# SLT TEST 1: 5 < 10 → TRUE
# Expect: 0001


addi x7, x0, 5

addi x8, x0, 10

slt x14, x7, x8

sw x14, 0(x6)
 
# delay

addi x15, x0, 5

delay1:

addi x15, x15, -1

bne x15, x0, delay1

# SLT TEST 2: 10 < 5 → FALSE
# Expect: 0000


slt x14, x8, x7

sw x14, 0(x6)
 
# delay

addi x15, x0, 5

delay2:

addi x15, x15, -1

bne x15, x0, delay2
 
# BGE TEST 1: 10 >= 5 → TRUE
# Expect: 00AA


addi x7, x0, 10

addi x8, x0, 5

addi x14, x0, 0xAA
 
bge x7, x8, bge_pass1

addi x14, x0, 0xFF
 
bge_pass1:

sw x14, 0(x6)
 
# delay

addi x15, x0, 5

delay3:

addi x15, x15, -1

bne x15, x0, delay3
 

# BGE TEST 2: 5 >= 10 → FALSE
# Expect: 00FF


addi x14, x0, 0xFF
 
bge x8, x7, bge_pass2

sw x14, 0(x6)

jal x0, after_bge2
 
bge_pass2:

addi x14, x0, 0xAA

sw x14, 0(x6)
 
after_bge2:
 
# delay

addi x15, x0, 5

delay4:

addi x15, x15, -1

bne x15, x0, delay4
 

lui x14, 0xABCDE

sw x14, 0(x6)
 
# delay

addi x15, x0, 5

delay5:

addi x15, x15, -1

bne x15, x0, delay5


jal x0, 0
 
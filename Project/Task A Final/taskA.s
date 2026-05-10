# x20 = initial countdown value
addi x20, x0, 5

# x2 = stack pointer
addi x2, x0, 511

# x5 = switch input address
addi x5, x0, 768

# x6 = LED output address
addi x6, x0, 512

# store initial value to switch-mapped location
sw x20, 0(x5)

# clear LEDs
sw x0, 0(x6)

main_loop:
lw x14, 0(x5)          # load switch input
beq x14, x0, main_loop # wait for input

add x10, x14, x0       # pass value
jal x1, countdown

beq x0, x0, main_loop

countdown:
addi x2, x2, -8
sw x1, 4(x2)
sw x15, 0(x2)

add x15, x10, x0

count_loop:
sw x15, 0(x6)
beq x15, x0, finish

addi x15, x15, -1

addi x16, x0, 3
delay_loop:
addi x16, x16, -1
bne x16, x0, delay_loop

beq x0, x0, count_loop

finish:
sw x0, 0(x6)

lw x15, 0(x2)
lw x1, 4(x2)
addi x2, x2, 8
jalr x0, 0(x1)
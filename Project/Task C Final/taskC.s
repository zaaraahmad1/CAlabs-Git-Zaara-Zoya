# x2  = stack pointer
addi x2, x0, 511

# x6 = LED output address
addi x6, x0, 512

# x7 = prev = 0
addi x7, x0, 0

# x8 = curr = 1
addi x8, x0, 1

# x15 = count = 10
addi x15, x0, 10


# ================================
# Main Fibonacci Loop
# ================================
fib_loop:

# pass current Fibonacci term
add x10, x8, x0

# call display subroutine
jal x1, display_and_delay

# next = prev + curr
add x9, x7, x8

# prev = curr
add x7, x8, x0

# curr = next
add x8, x9, x0

# count--
addi x15, x15, -1

# repeat until count = 0
bne x15, x0, fib_loop


sw x0, 0(x6)      # clear LEDs
jal x0, 0         # infinite loop

nop
nop
nop
nop


# ================================
# Display and Delay Subroutine
# ================================
display_and_delay:

# push stack frame
addi x2, x2, -8

# save return address
sw x1, 4(x2)

# save x10 (current Fibonacci term)
sw x10, 0(x2)

# display current term
sw x10, 0(x6)

# delay counter = 5
addi x16, x0, 5

delay_loop:
addi x16, x16, -1
bne x16, x0, delay_loop

# restore x10
lw x10, 0(x2)

# restore return address
lw x1, 4(x2)

# pop stack frame
addi x2, x2, 8

# return
jalr x0, 0(x1)
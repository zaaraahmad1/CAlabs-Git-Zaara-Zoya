.text
.globl main

main:
    addi x5, x0, 1        # result = 1
    addi x10, x0, 5      # n = 5


outer_loop:
    bge x0, x10, done    # if n <= 0 → done

    addi x6, x10, 0      # x6 = n
    addi x7, x0, 0        # x7 = 0  (temp result for multiplication)

mul_loop:
    bge x0, x6, mul_done  # if x6 <= 0 → multiplication finished
    add x7, x7, x5        # x7 = x7 + result
    addi x6, x6, -1       # x6--
    jal x0, mul_loop

mul_done:
    addi x5, x7, 0        # result = multiplied value
    addi x10, x10, -1     # n--
    jal x0, outer_loop

done:
    addi x11, x5, 0
    addi x10, x0, 1
    ecall

end:
    jal x0, end

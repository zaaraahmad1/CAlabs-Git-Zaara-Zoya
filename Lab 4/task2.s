.text
.globl main



main:
    addi x10, x0, 5      # num = 5
    jal x1, ntri         # call ntri(5)

    addi x11, x10, 0     # move result to print register
    addi x10, x0, 1      # ecall 1 = print integer
    ecall

end:
    jal x0, end          # infinite loop




ntri:
    addi x2, x2, -8      # allocate stack space
    sw x1, 4(x2)         # save return address
    sw x10, 0(x2)        # save num

    addi x5, x0, 1
    bge x5, x10, base_case   # if 1 >= num  (num <= 1)

    addi x10, x10, -1        # num = num - 1
    jal x1, ntri             # recursive call

    lw x6, 0(x2)             # restore original num
    add x10, x10, x6         # result = num + recursive result

    lw x1, 4(x2)             # restore return address
    addi x2, x2, 8           # deallocate stack
    jalr x0, 0(x1)           # return


base_case:
    addi x10, x0, 1          # return 1

    lw x1, 4(x2)             # restore return address
    addi x2, x2, 8           # deallocate stack
    jalr x0, 0(x1)

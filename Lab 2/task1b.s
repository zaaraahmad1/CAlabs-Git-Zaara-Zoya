.text
.globl main1

main:
    li x22, 0
    li x24, 2
    li x25, 0x100  #base address

    li x8, 2
    sw x8, 0(x25)    # save[0]=2
    li x8, 2
    sw x8, 4(x25)    # save[1]=2
    li x8, 4
    sw x8, 8(x25)    # save[2]=4
    li x8, 2
    sw x8, 12(x25)   # save[3]=2

    Loop:
        slli x10, x22, 2    # x10 = i*4
        add x10, x10, x25   # address of save[i]
        lw x9, 0(x10)       # load save[i]

        bne x9, x24, Exit   # exit if save[i] != k
        addi x22, x22, 1    # increment
        beq x0, x0, Loop    # unconditional jump

Exit:
end:
    j end
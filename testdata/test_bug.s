print_hex:
lui sp, %hi(stack_start)
addi sp, sp, %lo(stack_start)

snez a1,a1
slli a5,a1,0x2

lui a1, %hi(hex_chars)
addi a1, a1, %lo(hex_chars)

#addi sp,sp,-32
add  a1,a1,a5


#sw   s3,12(sp)
lw   s3,0(a1)  # s3 = tabela
#sw   s0,24(sp)
#sw   s1,20(sp)
#sw   s2,16(sp)
#sw   ra,28(sp)

mv   s1,a0     # valor
li   s0,28     # bits
li   s2,-4     # shift

loop:
srl  a5,s1,s0
andi a5,a5,15
add  a5,s3,a5
lbu  a0,0(a5)
addi s0,s0,-4
#jal  ra,c60 <fb_console_putc>
bne  s0,s2,loop

#lw   ra,28(sp)
#lw   s0,24(sp)
#lw   s1,20(sp)
#lw   s2,16(sp)
#lw   s3,12(sp)
#addi sp,sp,32
ret

.align 4

hex_chars: 
.word lower
.word upper
lower: .ascii "0123456789abcdef"
upper: .ascii "0123456789ABCDEF"

.section .data
stack_end:
.skip 40
stack_start:
     
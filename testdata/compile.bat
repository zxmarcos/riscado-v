SET PATH=%PATH%;D:\SysGCC\risc-v\bin

riscv64-unknown-elf-gcc -mabi=ilp32e -march=rv32i -c test_branchs.s -o test_branchs.o
riscv64-unknown-elf-ld -T riscv.ld -m elf32lriscv -O binary test_branchs.o -o test_branchs.elf
riscv64-unknown-elf-objcopy -O binary --only-section .text test_branchs.elf test_branchs.bin 
hxdump test_branchs.bin test_branchs.mem

pause
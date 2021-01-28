SET PATH=%PATH%;D:\SysGCC\risc-v\bin


REM Test BUG
riscv64-unknown-elf-gcc -mabi=ilp32 -march=rv32i -c test_bug.s -o test_bug.o
riscv64-unknown-elf-ld -T riscv.ld -m elf32lriscv -O binary test_bug.o -o test_bug.elf
riscv64-unknown-elf-objcopy -O binary --only-section .text test_bug.elf test_bug.bin 
riscv64-unknown-elf-objdump -D test_bug.elf > test_bug.txt
hxdump test_bug.bin test_bug.mem mem4

pause
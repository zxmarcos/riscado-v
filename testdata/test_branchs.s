.global _boot
.text

_boot:
  nop
  beq x0,x0,here
  nop
  jal x1, here
  nop
  nop

here:
  nop
  nop
.global _boot
.text

_boot:
teststorebyte:
  lui x1, %hi(data1)
  addi x1, x1, %lo(data1)
  lw x12, 0(x1)             /* x11      = 0x84838281 */

  lui x1, %hi(data2)
  addi x1, x1, %lo(data2)

  sb x12, 0(x1)             /* data2[0] = 0x00000081 */
  sh x12, 4(x1)             /* data2[1] = 0x00008281 */
  sw x12, 8(x1)             /* data2[2] = 0x84838281 */
  nop


.section .data
data2:
  .word 0x00000000 /* data2[0] => data2 + 0 */
  .word 0x00000000 /* data2[1] => data2 + 4 */
  .word 0x00000000 /* data2[2] => data2 + 8 */
  .word 0x00000000 /* data2[3] => data2 + 12 */

  .word 0x00000000 /* data2[4] => data2 + 16 */
  .word 0x00000000 /* data2[5] => data2 + 20 */
  .word 0x00000000 /* data2[6] => data2 + 24 */
  .word 0x00000000 /* data2[7] => data2 + 28 */


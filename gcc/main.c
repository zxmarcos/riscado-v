#include "main.h"
#include "fb.h"
#include "fb_console.h"
#define VRAM	((volatile uint16_t*)0x200000)


void sleep()
{
	volatile int n = 0;
	while (n < 100000) {
		n++;
	}
}


void setPixel(int x,int y, uint16_t color)
{
	if (y < 16)
		return;
	VRAM[x+(y*320)]=color;
}

void
drawLine(int x0, int y0, int x1, int y1, uint16_t color)
{
  int dx =  abs (x1 - x0),
  	  sx = x0 < x1 ? 1 : -1;
  int dy = -abs (y1 - y0),
      sy = y0 < y1 ? 1 : -1; 
  int err = dx + dy, e2;

  int count = 0;
 
  for (;;){  /* loop */
  	++count;
  	if (count > 1000)
  		break;

    setPixel(x0,y0,color);
    if (x0 == x1 && y0 == y1)
    	break;

    e2 = 2 * err;
    if (e2 >= dy) {
    	err += dy;
    	x0 += sx;
    }
    if (e2 <= dx) {
    	err += dx;
    	y0 += sy;
    }
  }
}


int main() {

	fb_init();
	fb_console_init();

	//for (int i=0;i<10;i++)
	//	fb_console_putc('5');

	printk("riscado-v : RV32I impl.\n");



	
#if 1

	int *leds = (int*)0x80000000;
	*leds = 0;
	int i = 0;
	srand(~0);
	for(;;) {
		fb_gotoxy(0, 7);
		printk("%x",getseed());
		int x1 = rand() % 320;
		int x2 = rand() % 320;
		int y1 = rand() % 240;
		int y2 = rand() % 240;

		drawLine(x1,y1,x2,y2,rand());
		//sleep();
		
		/*
		*leds ^= i;
		sleep();
		*leds ^= i;
		i++;
		*/
	}
#else
	int *leds = (int*)0x80000000;
	*leds = 0;
	int i = 0;

	int offset = 0;
	int rising = 1;
	uint16_t color=0xF0F0F0;

	char r, g, b;
	r=255;
	g=255;
	b=0;
	fb_setfg(r,g,b);

	for (;;) {
		
		fb_clear_line(7);
		fb_gotoxy(offset, 7);

		if (rising) {
			offset++;
			if (offset >= 23) {
				rising = 0;
			}
		} else {
			offset--;
			if (offset <= 0) {
				rising = 1;
			}
		}


		printk("#finalmenteSenior");
		/*
		for (int y=0,x=offset;y<240;y++,x++) {
			VRAM[y*320+x]=color;
		}

		++offset;
		if (offset >= 80) {
			offset = 0;
			color ^= 0xFFFF;
		}
		*/

		sleep();sleep();
		/**leds ^= i;
		sleep();
		*leds ^= i;
		i++;*/
	}
#endif
	return 0;
}
// Doom fire effect

#include "main.h"
#include "fb.h"
#include "fb_console.h"

#define TILE_W  8
#define TILE_H  8
#define WIDTH   (320/TILE_W)
#define HEIGHT  (240/TILE_H)
#define COLORS  37


uint16_t pallete[COLORS];

uint16_t rgb565(uint8_t r8, uint8_t g8, uint8_t b8)
{

    uint16_t b5 = ( b8 >> 3) & 0x1f;
    uint16_t g6 = ((g8 >> 2) & 0x3f) << 5;
    uint16_t r5 = ((r8 >> 3) & 0x1f) << 11;

    return (r5 | g6| b5);
}


unsigned char fire[WIDTH * HEIGHT];

static const unsigned char pallete_rgb[COLORS][3] = {
    {7,7,7},
    {31,7,7},
    {47,15,7},
    {71,15,7},
    {87,23,7},
    {103,31,7},
    {119,31,7},
    {143,39,7},
    {159,47,7},
    {175,63,7},
    {191,71,7},
    {199,71,7},
    {223,79,7},
    {223,87,7},
    {223,87,7},
    {215,95,7},
    {215,95,7},
    {215,103,15},
    {207,111,15},
    {207,119,15},
    {207,127,15},
    {207,135,23},
    {199,135,23},
    {199,143,23},
    {199,151,31},
    {191,159,31},
    {191,159,31},
    {191,167,39},
    {191,167,39},
    {191,175,47},
    {183,175,47},
    {183,183,47},
    {183,183,55},
    {207,207,111},
    {223,223,159},
    {239,239,199},
    {255,255,255}
};


void reset_fire()
{
    for (int y = 0; y < HEIGHT-1; y++) {
        for (int x = 0; x < WIDTH; x++) {
            fire[y * WIDTH + x] = 0;
        }
    }
    for (int x = 0; x < WIDTH; x++) {
        fire[(HEIGHT-1)*WIDTH + x] = COLORS-1;
    }
}

void updateFire(int index)
{
    int below = index + WIDTH;
    if (below >= HEIGHT*WIDTH)
        return;

    int decay = rand() & 3;
    int below_intensity = fire[below] - decay;
    int intensity = below_intensity >= 0 ? below_intensity : 0;

    int nidx = index - decay;
    if (nidx >= 0 && nidx < HEIGHT*WIDTH)
        fire[nidx] = intensity;
}

void render()
{
     for (int y = 0; y < HEIGHT; y++) {
        for (int x = 0; x < WIDTH; x++) {
            int color_index = fire[y * WIDTH + x];
            if (color_index < COLORS) {
                fb_rectfill(x*TILE_W,y*TILE_H,TILE_W,TILE_H, pallete[color_index]);
            } else {
                fb_rectfill(x*TILE_W,y*TILE_H,TILE_W,TILE_H, 0);
            }
            
        }
    }
}

void propagate_fire()
{
    for (int x = 0; x < WIDTH; x++) {
        for (int y = 0; y < HEIGHT; y++) {
            updateFire(y*WIDTH+x);
        }
    }
    render();
}

void setup()
{
    for (int i = 0; i < COLORS; i++) {
        pallete[i] = rgb565(pallete_rgb[i]);
    }

    reset_fire();
}

int main() {
    int *leds = (int*)0x80000000;
   

    fb_init();
    fb_console_init();
    srand(~0);
    printk("Doom Fire");
     *leds = 1;
    setup();
    for (;;) {
        propagate_fire();
       // *leds ^= 3;
        //sleep();
    }

    return 0;
}
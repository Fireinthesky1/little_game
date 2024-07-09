#include "stdio.h"
#include "raylib.h"

#define WIDTH 640
#define HEIGHT 480

int main(void)
{

  InitWindow(WIDTH,HEIGHT,"Fire In The Sky");
  Image robo = LoadImage("art/Robot.png");
  Texture2D robo_texture = LoadTextureFromImage(robo);

  while(!WindowShouldClose())
    {
      BeginDrawing();
      ClearBackground(GREEN);
      DrawTexture(robo_texture,0,0,RED);
      EndDrawing();
    }

  return 0;

}

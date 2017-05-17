OPC opc;
PImage im;

int numStrips = 8;

void setup()
{
  size(200, 800);

  // Load a sample image
  im = loadImage("flames.jpeg");

  // Connect to the local instance of fcserver
  opc = new OPC(this, "127.0.0.1", 7890);

  // Map eight 60-LED strips.
  for (int i = 0; i < numStrips; i++) {
    opc.ledStrip(i * 60, 60, i * width / numStrips + (width / numStrips / 2), height / 2, height / 70.0, HALF_PI, false);
  }
}

void draw()
{
  // Scale the image so that it matches the width of the window
  int imHeight = im.height * width / im.width;

  // Scroll down slowly, and wrap around
  float speed = 0.05;
  float y = (millis() * -speed) % imHeight;
  
  // Use two copies of the image, so it seems to repeat infinitely  
  image(im, 0, y, width, imHeight);
  image(im, 0, y + imHeight, width, imHeight);
}
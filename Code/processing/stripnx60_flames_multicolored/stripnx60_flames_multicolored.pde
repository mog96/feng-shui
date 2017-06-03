OPC opc;
PImage[] images;
int numImages = 4;

int numStrips = 72;

void setup()
{
  size(400, 800);

  // Load a sample image
  // im = loadImage("flames.jpeg");
  images = new PImage[numImages];
  images[0] = loadImage("blue-flames.jpg");
  images[1] = loadImage("light-blue-flames.jpg");
  images[2] = loadImage("flames.jpeg");
  images[3] = loadImage("pink-flames.jpg");

  // Connect to the local instance of fcserver
  opc = new OPC(this, "127.0.0.1", 7890);

  // Map eight 60-LED strips.
  for (int i = 0; i < numStrips; i++) {
    // Vertical layout.
    opc.ledStrip(i * 60, 60, i * width / numStrips + (width / numStrips / 2), height / 2, height / 70, HALF_PI, false);
    
    // Horizontal layout.
    // opc.ledStrip(i * 60, 60, width / 2, i * height / numStrips + (height / numStrips / 2), width / 70.0, 0, false);
  }
}

void draw()
{
  // Scale the image so that it matches the width of the window
  int imHeight = images[0].height * width / images[0].width;

  // Scroll down slowly, and wrap around
  float speed = 0.03;
  float y = (millis() * -speed) % (imHeight * numImages);
  
  // Use two copies of the image, so it seems to repeat infinitely
  for (int i = 0; i < numImages; i++) {
    image(images[i], 0, y, width, imHeight);
    image(images[(i + 1) % numImages], 0, y + i * imHeight, width, imHeight);
  }
  
  //image(images[(int(y / imHeight)) % numImages], 0, y, width, imHeight);
  //image(images[(int(y / imHeight) + 1) % numImages], 0, y + imHeight, width, imHeight);
}
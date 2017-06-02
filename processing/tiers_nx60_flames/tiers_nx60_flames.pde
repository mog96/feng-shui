OPC opc;
PImage im;

int numTiers = 3;
int numStripsPerTier = 24;

void setup()
{
  size(400, 800);

  // Load a sample image
  // im = loadImage("flames.jpeg");
  im = loadImage("blue-flames.jpg");

  // Connect to the local instance of fcserver
  opc = new OPC(this, "127.0.0.1", 7890);
  // opc = new OPC();
  
  

  // Map eight 60-LED strips.
  for (int i = 0; i < numTiers; i++) {
    for (int j = 0; j < numStripsPerTier; j++) {
      // Vertical layout.
      int index = (i * numStripsPerTier + j) * 60;
      
      float tierCenter = i * (height / numTiers) + (height / numTiers) / 2;
      println("INDEX", index);
      println("TIER CENTER Y", tierCenter);
      opc.ledStrip(index, 60, i * width / numStripsPerTier + (width / numStripsPerTier / 2), tierCenter, 5, HALF_PI, false);
      
      // Horizontal layout.
      // opc.ledStrip(i * 60, 60, width / 2, i * height / numStrips + (height / numStrips / 2), width / 70.0, 0, false);
    }
  }
}

void draw()
{
  // Scale the image so that it matches the width of the window
  int imHeight = im.height * width / im.width;

  // Scroll down slowly, and wrap around
  float speed = 0.03;
  float y = (millis() * -speed) % imHeight;
  
  // Use two copies of the image, so it seems to repeat infinitely  
  image(im, 0, y, width, imHeight);
  image(im, 0, y + imHeight, width, imHeight);
}
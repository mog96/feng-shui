/**
 * Get Line In
 * by Damien Di Fede.
 *  
 * This sketch demonstrates how to use the getLineIn (or other) method of 
 * Minim. This method returns an AudioInput object. 
 
 * An <code>AudioInput</code> represents a connection to the computer's current 
 * record source (usually the line-in) and is used to monitor audio coming 
 * from an external source. There are five versions of <code>getLineIn</code>:
 
 * <pre>
 * getLineIn()
 * getLineIn(int type) 
 * getLineIn(int type, int bufferSize) 
 * getLineIn(int type, int bufferSize, float sampleRate) 
 * getLineIn(int type, int bufferSize, float sampleRate, int bitDepth)  
 * </pre>
 * The value you can use for <code>type</code> is either <code>Minim.MONO</code> 
 * or <code>Minim.STEREO</code>. <code>bufferSize</code> specifies how large 
 * you want the sample buffer to be, <code>sampleRate</code> specifies the 
 * sample rate you want to monitor at, and <code>bitDepth</code> specifies what 
 * bit depth you want to monitor at. <code>type</code> defaults to <code>Minim.STEREO</code>,
 * <code>bufferSize</code> defaults to 1024, <code>sampleRate</code> defaults to 
 * 44100, and <code>bitDepth</code> defaults to 16. If an <code>AudioInput</code> 
 * cannot be created with the properties you request, <code>Minim</code> will report 
 * an error and return <code>null</code>.
 * 
 * When you run your sketch as an applet you will need to sign it in order to get an input. 
 * 
 * Before you exit your sketch make sure you call the <code>close</code> method 
 * of any <code>AudioInput</code>'s you have received from <code>getLineIn</code>.
 */
 
import ddf.minim.*;
 
Minim minim;
// AudioInput in;
 
int cellsize = 2; // Dimensions of each cell in the grid
 
AudioPlayer in;
 
int i=0; 
 
// ----------------------------------
 
void setup() {
 
  size(800, 600); 
  println( "Start of setup():" );
 
 
  minim = new Minim(this);
  //  minim.debugOn();
 
  // get a line in from Minim, default bit depth is 16
  // in = minim.getLineIn(Minim.STEREO, 800);
  in = minim.loadFile("test.mp3", 2048);
  in.loop();
  println( "End of setup()." );
}
 
void draw() {
 
  //background(0);
 
  // Begin loop for columns
 
  int x ; // x position
  int y ; // y position
 
  color c = color(random(255)); // the color
 
  // use map()
  float val1 = map (abs(in.left.get(i)), 0, 5, 0, width);      
  float val2 = map (abs(in.right.get(i)), -4, 4, 0, height);
 
  // Calculate a position 
  x = int(val1); // 
  y = int(val2); // 
 
  // Translate to the location, set fill and stroke, and draw the rect
  pushMatrix();
  translate(x+220, y);
  fill(c, 204);
  noStroke();
  rectMode(CENTER);
  rect(0, 0, cellsize*3, cellsize*3);
  popMatrix();
 
  i++;
} // func 
 
void stop()
{
  // always close Minim audio classes when you are done with them
  in.close();
  minim.stop();
 
  super.stop();
}
//
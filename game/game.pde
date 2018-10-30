import processing.serial.*;

// Banana variables 
Serial port;
int players = 2;
Banana[] bananas = new Banana[players];
int[] keys = {32, 10};

// Background and UI variables
Track track;
PFont font;

void setup() {
  size(800, 600);
  int spriteHeight = 197;
  
  // Set track length and load font for UI
  track = new Track(750);
  font = createFont("Pixel Emulator", 50);
  textFont(font);
  
  // Set wich port to listen to
  port = new Serial(this, Serial.list()[0], 9600);
  
  // Create bananas :)
  for(int i = 0; i < players; i++) {
   bananas[i] = new Banana("Banana " + str(i + 1), 0, height - spriteHeight * (bananas.length - i), keys[i]);
  }
}

void draw() {
  background(255);
  track.setTrack();
  
  if (port.available() > 0) {
    while (port.available() > 0) {
      
     String value = port.readStringUntil(10);
     if (value != null) {
       int val =Integer.parseInt(trim(value));
       bananas[val].increaseSpeed();
     }
    }
  }
  
  for(int i = 0; i < players; i++) {
    if (bananas[i].speed != 0) {
      bananas[i].run();
    } else {
      bananas[i].idle();
    }
    
    // Banana sprites middle position
    float middle = bananas[i].position.x + bananas[i].width / 2; 
    
    // If any banana crosses the finish line, break loop
    if ( middle >= track.length) {
      noLoop();
      endGame(bananas[i].name);
    }
    
    bananas[i].decreaseSpeed();
  }
}

void keyPressed() {
  for(int i = 0; i < players; i++) {
    if (keyCode == bananas[i].keyCode) {
      bananas[i].increaseSpeed();
    }
  }
}

void endGame(String winner) {
  delay(500);
  background(0);
  fill(255);
  textAlign(CENTER);
  text(winner + " wins!", width / 2, height / 2);
}

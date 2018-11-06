import processing.serial.*;

// Banana variables 
Serial port;
int players = 2;
Banana[] bananas = new Banana[players];
int[] keys = {32, 10};
Banana winner;

// Background and UI variables
BackgroundImage backgroundImage;
Track track;
PFont font;
int startPosition = 0;
int sceneWidth;

void setup() {
  size(800, 600);
  int spriteHeight = 197;
  
  //set background image
  backgroundImage = new BackgroundImage();
  
  // Set track length and load font for UI
  track = new Track(1000);
  font = createFont("Pixel Emulator", 50);
  textFont(font);
  
  // Set which port to listen to
  port = new Serial(this, Serial.list()[0], 9600);
  
  // Create bananas :)
  for(int i = 0; i < players; i++) {
   bananas[i] = new Banana("Banana " + str(i + 1), 0, height - spriteHeight * (bananas.length - i), keys[i]);
  }
}

void draw() {
  background(255);
  translate(startPosition, 0);
  track.setTrack();
  
  //background image functions
  backgroundImage.display(track);
  
  if (port.available() > 0) {
    while (port.available() > 0) {
      
     String value = port.readStringUntil(10);
     if (value != null) {
       int index = Integer.parseInt(trim(value));
       bananas[index].increaseSpeed();
     }
    }
  }
  
  for(int i = 0; i < bananas.length; i++) {
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
      winner = bananas[i];
      endGame();
      break;
    }

    bananas[i].decreaseSpeed();
  }
  
  if (bananas[0].position.x > bananas[1].position.x) {
    winner = bananas[0];
  }
  if (bananas[0].position.x < bananas[1].position.x) {
    winner = bananas[1];
  }
  
  if (winner != null) {
    if (winner.position.x > width / 2 - winner.width) {
      startPosition -= winner.speed * 10;
      backgroundImage.move(winner.speed);
    }
  }
}

void keyPressed() {
  for(int i = 0; i < bananas.length; i++) {
    if (keyCode == bananas[i].keyCode) {
      bananas[i].increaseSpeed();
    }
  }
}

void endGame() {
  delay(500);
  background(0);
  fill(255);
  textAlign(CENTER);
  text(winner.name + " wins!", width / 2, height / 2);
}

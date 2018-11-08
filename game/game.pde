import ddf.minim.*;

import processing.serial.*;

// Banana variables
Serial port;
int players = 2;
Banana[] bananas = new Banana[players];
int[] keys = {32, 10};
Banana winner;

//sound variables
Minim minim;
AudioPlayer countdown; //mario countdown 
AudioPlayer runmusic; // track meant to play when bananas are running
AudioPlayer menumusic; // track for start and finish screen


// Background variables
BackgroundImage backgroundImage;
Track track;
UI UI;
float startPosition = 0;

// UI variables
int startTimeMs;
final int startDelayMs = 4000;
boolean atStartup = true;
boolean startGame = false;
boolean endGame = false;

int allowInput = 0;
int delayInput = 2000;

void setup() {
  fullScreen();
  frameRate(30);
  int spriteHeight = 197;
  surface.setTitle("Banana Run");

  // Set background image
  backgroundImage = new BackgroundImage();

  //sound
  minim = new Minim(this);
  menumusic = minim.loadFile("winnerMusic.mp3");
  countdown = minim.loadFile("countdown.mp3");
  runmusic = minim.loadFile("runMusic.mp3");

  // Set track length and load UI
  track = new Track(floor(width * 1.5));
  UI = new UI();

  // Set which port to listen to
  port = new Serial(this, Serial.list()[2], 9600);

  // Create bananas :)
  for (int i = 0; i < players; i++) {
    bananas[i] = new Banana("Banana " + str(i + 1), 0, height - spriteHeight * (bananas.length - i), keys[i]);
  }
  
  allowInput = millis() + delayInput;
}

void draw() {
  
  // Listen to ports
  if (port.available() > 0) {
    while (port.available() > 0) {

     String value = port.readStringUntil(10);
     if (value != null) {

       if (!startGame && allowInput <= millis()) {
         startGame = true;
         startTimeMs = millis();
       }

       if (endGame && allowInput <= millis()) {
         endGame = false;
         startTimeMs = millis();
         atStartup = true;
         loop();
       }
       int index = Integer.parseInt(trim(value));
       bananas[index].increaseSpeed();
     }
    }
  }
  
  if (endGame) {
    UI.endScreen();
    return;
  }

  if (!startGame) {
    UI.startScreen();
    return;
  }

  if (atStartup) {
    // The current time, in milliseconds
    int curTimeMs = millis();
    // The remaining time in the startup period
    int startupTimeRemainingMs = startDelayMs - (curTimeMs - startTimeMs);
    UI.countScreen(startupTimeRemainingMs);
    atStartup = startupTimeRemainingMs > 0;
    // Short-circuit if we're still in the startup phase.
    return;
  }
  countdown.pause();
  countdown.rewind();
  if (!runmusic.isPlaying()) {
    runmusic.loop();
  }

  // Move screen and set images
  track.setTrack(startPosition);
  backgroundImage.display(track, startPosition);

  // Game loop for every banana
  for (int i = 0; i < bananas.length; i++) {
    if (bananas[i].speed != 0) {
      bananas[i].run();
    } else {
      bananas[i].idle();
    }

    // Banana sprites middle position
    float middle = bananas[i].position.x + bananas[i].width / 2;

    // Declare winner!!
    if ( middle >= track.length) {
      winner = bananas[i];
      allowInput = millis() + delayInput;
      UI.endScreen();
      break;
    }

    bananas[i].decreaseSpeed();
  }

  // Set leader
  if (bananas[0].position.x > bananas[1].position.x) {
    winner = bananas[0];
  }
  if (bananas[0].position.x < bananas[1].position.x) {
    winner = bananas[1];
  }

  // Increment background movement
  if (winner != null) {
    if (winner.position.x + winner.width / 2 >= width / 2) {
      startPosition += winner.speed * 50;
      backgroundImage.move(winner.speed);
    }
  }
}

//void keyPressed() {
//  if (!startGame && allowInput <= millis()) {
//    startGame = true;
//    startTimeMs = millis();
//  }

//  if (endGame && allowInput <= millis()) {
//    endGame = false;
//    startTimeMs = millis();
//    atStartup = true;
//  }

//  for (int i = 0; i < bananas.length; i++) {
//    if (keyCode == bananas[i].keyCode) {
//      bananas[i].increaseSpeed();
//    }
//  }
//}

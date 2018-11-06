import processing.serial.*;

int startTimeMs;
final int startDelayMs = 3000;
boolean atStartup = true;
boolean startGame = false;

// Banana variables
Serial port;
int players = 2;
Banana[] bananas = new Banana[players];
int[] keys = {32, 10};
Banana winner;

// Background and UI variables
BackgroundImage backgroundImage;
Track track;
UI UI;
float startPosition = 0;

void setup() {
  fullScreen();
  int spriteHeight = 197;
  surface.setTitle("Banana Run");

  // Set background image
  backgroundImage = new BackgroundImage();

  // Set track length and load UI
  track = new Track(1000);
  UI = new UI();

  // Set which port to listen to
  //port = new Serial(this, Serial.list()[0], 9600);

  // Create bananas :)
  for (int i = 0; i < players; i++) {
    bananas[i] = new Banana("Banana " + str(i + 1), 0, height - spriteHeight * (bananas.length - i), keys[i]);
  }
  startTimeMs = millis();
}

void draw() {
  if(!startGame) {
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


  background(255);
  translate(-startPosition, 0);
  track.setTrack();

  // Background image functions
  backgroundImage.display(track);

  //if (port.available() > 0) {
  //  while (port.available() > 0) {

  //   String value = port.readStringUntil(10);
  //   if (value != null) {
  //     int index = Integer.parseInt(trim(value));
  //     bananas[index].increaseSpeed();
  //   }
  //  }
  //}

  for (int i = 0; i < bananas.length; i++) {
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
      UI.endScreen();
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
    if (winner.position.x  >= width / 2) {
      startPosition += winner.speed * 20;
      backgroundImage.move(winner.speed);
    }
  }
}

void keyPressed() {
  if (!startGame) {
    startGame = true;
  }
  
  for (int i = 0; i < bananas.length; i++) {
    if (keyCode == bananas[i].keyCode) {
      bananas[i].increaseSpeed();
    }
  }
}

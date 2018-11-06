import processing.serial.*;

int startTimeMs;
final int startDelayMs = 5000;
boolean atStartup = true;

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
float startPosition = 0;

void setup() {
  size(800, 600);
  int spriteHeight = 197;
  surface.setTitle("Banana Run");

  //set background image
  backgroundImage = new BackgroundImage();

  // Set track length and load font for UI
  track = new Track(1000);
  font = createFont("Pixel Emulator", 50);
  textFont(font);

  // Set which port to listen to
  //port = new Serial(this, Serial.list()[0], 9600);

  // Create bananas :)
  for (int i = 0; i < players; i++) {
    bananas[i] = new Banana("Banana " + str(i + 1), 0, height - spriteHeight * (bananas.length - i), keys[i]);
  }
  startTimeMs = millis();
}

void draw() {

  if (atStartup) {
    // The current time, in milliseconds
    int curTimeMs = millis();
    // The remaining time in the startup period
    int startupTimeRemainingMs = startDelayMs - (curTimeMs - startTimeMs);
    startScreen(startupTimeRemainingMs);
    atStartup = startupTimeRemainingMs > 0;
    // Short-circuit if we're still in the startup phase.
    return;
  }


  background(255);
  translate(-startPosition, 0);
  track.setTrack();

  //background image functions
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
    if (winner.position.x  >= width / 2) {
      startPosition += winner.speed * 20;
      backgroundImage.move(winner.speed);
    }
  }
}

void keyPressed() {
  for (int i = 0; i < bananas.length; i++) {
    if (keyCode == bananas[i].keyCode) {
      bananas[i].increaseSpeed();
    }
  }
}

//start screen
//void startGame() {
//  noLoop();
//  background(0);
//  fill(255);
//  textAlign(CENTER);
//  text("Start Game", width / 2, height / 2);
//  delay(5000);
//  //loop();
//}
void startScreen(int remainingTimeMs){
  background(50);
  textSize(100);
  fill(0);
  textAlign(CENTER,
  CENTER);
  // Show the remaining time, in seconds;
  // show n when there are n or fewer seconds remaining.
  text(ceil(remainingTimeMs/1000.0), CENTER, CENTER);
}

void endGame() {
  translate(startPosition, 0);
  delay(500);
  background(0);
  fill(255);
  textAlign(CENTER);
  text(winner.name + " wins!", width / 2, height / 2);
}

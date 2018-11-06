class UI {
  PFont font;
  
  UI () {
    this.font = createFont("Pixel Emulator", 50);
    textFont(this.font);
  }
  
  void startScreen() {
    background(0);
    textSize(100);
    fill(255);
    textAlign(CENTER, CENTER);
    text("BANANA RUN", width / 2, height / 2 - 100);
    textSize(50);
    text("Slap any banana to start", width / 2, height / 2 + 50);
  }
  
  void countScreen(int remainingTimeMs) {
    background(50);
    textSize(100);
    fill(0);
    textAlign(CENTER, CENTER);
    // Show the remaining time, in seconds;
    // show n when there are n or fewer seconds remaining.
    if (remainingTimeMs < 2999) {
      text(ceil(remainingTimeMs/1000.0), width / 2, height / 2);
    }
    for (int i = 0; i < bananas.length; i++) {
      bananas[i].speed = 0;
    }
  }
  
  void endScreen() {
    noLoop();
    background(0);
    translate(startPosition, 0);
    for (int i = 0; i < bananas.length; i++) {
      bananas[i].position.x = 0;
      bananas[i].speed = 0;
    }
    backgroundImage.x = 0;
    startPosition = 0;
    delay(500);
    fill(255);
    textSize(100);
    textAlign(CENTER);
    text(winner.name + " wins!", width / 2, height / 2);
    textSize(50);
    text("Slap any banana to play again", width / 2, height - 100);
    endGame = true;
  }

}

class UI {
  PFont font;
  
  UI () {
    this.font = createFont("Pixel Emulator", 50);
    textFont(this.font);
  }
  
  void startScreen() {
    noLoop();
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
    text(ceil(remainingTimeMs/1000.0), width / 2, height / 2);
  }
  
  void endScreen() {
    translate(startPosition, 0);
    delay(500);
    background(0);
    fill(255);
    textSize(50);
    textAlign(CENTER);
    text(winner.name + " wins!", width / 2, height / 2);
  }

}

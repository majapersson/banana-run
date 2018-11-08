class UI {
  PFont font;
  PImage logo;
  
  UI () {
    this.font = createFont("Pixel Emulator", 50);
    textFont(this.font);
    colorMode(HSB, 360, 100, 100);
    this.logo = loadImage("bananarunlogo.png");
  }
  
  void startScreen() {
    if (!menumusic.isPlaying()) {
      menumusic.loop();
    }
    background(0);
    textSize(100);
    fill(0, 0, 100);
    image(this.logo, width / 2 - this.logo.width / 2, height / 2 - this.logo.height);
    textAlign(CENTER, CENTER);
    textSize(50);
    if (allowInput <= millis()){
     text("Slap any banana to start", width / 2, height / 2 + 150);
    }
  }
  
  void countScreen(int remainingTimeMs) {
    menumusic.pause();
    menumusic.rewind();
    background(0);
    if (remainingTimeMs < 1000) {
     background(81, 80, 90);
    } else if (remainingTimeMs < 2000) {
      background(54, 80, 90);
    } else {
     background(352, 80, 90);
    }
    textSize(100);
    noStroke();
    fill(0, 0, 100);
    textAlign(CENTER, CENTER);
    // Show the remaining time, in seconds;
    // show n when there are n or fewer seconds remaining.
    if (remainingTimeMs < 3500) {
      countdown.play();
    }
    if (remainingTimeMs < 2999) {
      text(ceil(remainingTimeMs/1000.0), width / 2, height / 2);
    }
    for (int i = 0; i < bananas.length; i++) {
      bananas[i].speed = 0;
    }
  }
  
  void endScreen() {
    for (int i = 0; i < bananas.length; i++) {
      bananas[i].position.x = 0;
      bananas[i].speed = 0;
    }
    backgroundImage.x = 0;
    startPosition = 0;
    delay(200);
  
    runmusic.pause();
    runmusic.rewind();
    
    if (!menumusic.isPlaying()) {
      menumusic.loop();
    }
    background(random(0, 360), 100, 70);
  
    fill(0, 0, 100);
    textSize(100);
    textAlign(CENTER);
    text(winner.name + " wins!", width / 2, height / 2);
    textSize(50);
    if (allowInput <= millis()){
      text("Slap any banana to play again", width / 2, height - 100);
    }
    delay(1000);
      
    endGame = true;
  }

}

int players = 2;

Banana banana;

void setup() {
  size(600, 600);
  
  banana = new Banana(width / 2, height / 2, 32);
}

void draw() {
  background(255);
  
  if (banana.speed != 0) {
    banana.run();
  } else {
    banana.idle();
  }
  
  banana.decreaseSpeed();
}

void keyPressed() {
  if (keyCode == banana.keyCode) {
    banana.increaseSpeed();
  }
}

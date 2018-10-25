int players = 2;
Banana banana;

float speed = 0.2;

void setup() {
  size(600, 600);
  banana = new Banana();
}

void draw() {
  background(255);
  banana.run(speed);
}

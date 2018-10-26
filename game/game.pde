import processing.serial.*;

Serial port;
int players = 2;
Banana banana;


void setup() {
  size(800, 800);
  
  port = new Serial(this, Serial.list()[2], 9600);
  
  banana = new Banana(width / 2, height / 2, 32);
}

void draw() {
  background(255);
  
  if (port.available() > 0) {
    while (port.available() > 0) {
      
     String val = port.readStringUntil(10);
     if (val != null) {
       val = trim(val);
       
       if (val.equals("0")) {
         banana.increaseSpeed();
       }
     }
    }
  }
  
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

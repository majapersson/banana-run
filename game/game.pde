import processing.serial.*;

Serial port;
int players = 2;
Banana[] bananas = new Banana[players];
int[] keys = {32, 10};


void setup() {
  size(800, 800);
  int spriteHeight = 197;
  
  port = new Serial(this, Serial.list()[0], 9600);
  
  for(int i = 0; i < players; i++) {
   bananas[i] = new Banana(0, height / 2 - spriteHeight + spriteHeight * i, keys[i]);
  }
}

void draw() {
  background(255);
  
  if (port.available() > 0) {
    while (port.available() > 0) {
      
     String value = port.readStringUntil(10);
     if (value != null) {
       int val =Integer.parseInt(trim(value));
       bananas[val].increaseSpeed();
     }
    }
  }
  
  for(int i = 0; i < players; i++) {
    if (bananas[i].speed != 0) {
      bananas[i].run();
    } else {
      bananas[i].idle();
    }
    
    bananas[i].decreaseSpeed();
  }
}

void keyPressed() {
  for(int i = 0; i < players; i++) {
    if (keyCode == bananas[i].keyCode) {
      bananas[i].increaseSpeed();
    }
  }
}

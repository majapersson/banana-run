class BackgroundImage {
  PImage bg;
  float x=0;
  float y =0;
  
  BackgroundImage() {
    bg = loadImage("paintBg.png");
  }

  //display the background
  void display(Track track) {

    noStroke();
    //imageMode(CENTER);
    for (float i = x; i < track.length + width / 2 + bg.width / 2; i += bg.width) {
      image(bg, i, y, bg.width, height - track.finishline.height);
    }
  }

  void move(float speed) {
    x = x + speed;
    if (x < -400) {
      x = -400;
    }
  }
}

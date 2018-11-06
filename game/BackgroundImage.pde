class BackgroundImage {
  PImage bg;
  float x=0;
  float y =0;
  
  BackgroundImage() {
    bg = loadImage("paintBg.png");
  }

  // Display the background
  void display(Track track) {
    for (float i = x; i < track.length + width / 2 + bg.width / 2; i += bg.width) {
      image(bg, i, y, bg.width, height - track.finishline.height);
    }
  }

  void move(float speed) {
    x = x + speed;
    if (x < -bg.width) {
      x = -bg.width;
    }
  }
}

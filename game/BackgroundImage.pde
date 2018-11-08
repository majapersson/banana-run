class BackgroundImage {
  PImage bg;
  float x=0;
  float y =0;
  
  BackgroundImage() {
    bg = loadImage("finalbg.png");
  }

  // Display the background
  void display(Track track, float startPosition) {
    bg.resize(0, height - track.finishline.height);
    for (float i = x - startPosition; i < track.length + width / 2 + bg.width / 2; i += bg.width) {
      image(bg, i, y, bg.width, bg.height);
    }
  }

  void move(float speed) {
    x = x + speed;
    if (x < -bg.width) {
      x = -bg.width;
    }
  }
}

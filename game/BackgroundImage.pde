class BackgroundImage {
  float x=0;
  float y =0;
  float speed = 5;
  int state=0;

  //display the background
  void display() {

    noStroke();
    //imageMode(CENTER);
    image(bg, x, y, 600, 200);
  }

  void move() {
    //if the state is 0, move to the right
    if (state == 0) {
      x = x + speed;
      if (x > width-400) {
        x = width-400;
        //state=1;
      }
    }
  }
}

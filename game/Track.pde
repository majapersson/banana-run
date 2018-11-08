class Track {
  PImage startline;
  PImage finishline;
  PImage track;
  int length;
  
  /*
  * Constructor, sets initial values like length and images
  */
  Track(int x) {
    this.length = x;
    this.startline = loadImage("startline.png");
    this.finishline = loadImage("finishline.png");
    this.track = loadImage("track.png");
  }
  
  /*
  * Loop through images and add them to the scene
  */
  void setTrack(float startPosition) {
    image(this.startline, 0 - startPosition, height - this.startline.height);
    for (int i = this.track.width; i < this.length + width / 2; i += this.track.width) {
      image(this.track, i - startPosition, height - this.track.height);
    }
    image(this.finishline, this.length - startPosition, height - this.finishline.height);
  }
}

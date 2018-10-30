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
  * Loop througsh images and add them tso the scene
  */
  void setTrack() {
    image(this.startline, 0, height - this.startline.height);
    for (int i = this.track.width; i < this.length; i += this.track.width) {
      image(this.track, i, height - this.track.height);
    }
    image(this.finishline, this.length, height - this.finishline.height);
  }
}

class Banana {
  PImage[] animation;
  PVector position;
  
  float index = 0;
  
  /*
  * Constructor, here we set initial values, such as starting position
  */
  Banana() {
    PImage runSheet = loadImage("assets/mario_running.png");
    
    this.animation = this.setAnimation(runSheet);
    this.position = new PVector(width / 2, height / 2);
  }
  
  /*
  * Here we send in a spritesheet and split it into an array of sprites
  *
  * @params PImage sheet
  * @return PImage[]
  */
  PImage[] setAnimation(PImage sheet) {
    int spriteWidth = 17;
    PImage[] anim = new PImage[sheet.width / spriteWidth];
    
    for(int i = 0; i < sheet.width / spriteWidth; i++) {
      int x = i * spriteWidth;
      anim[i] = sheet.get(x, 0, spriteWidth, sheet.height);
    }
    return anim;
  }
  
  /*
  * Loop through animation array and display the image at set position
  * The math sets which sprite to show depending on speed
  * 
  * @params float speed
  */
  void run(float speed) {
     image(this.animation[floor(this.index) % this.animation.length], this.position.x, this.position.y);
     index += speed;
  }
}

class Blocker {

  //variables
  float x;
  float y;
  float speed = .5;
  color colour;
  Blocker() 
  {
    x=random(0, width = 1);
    y=random(0, height);
  }

  void update() {

    //move command for blockers
    y = y - speed;

    if (y < 0)
    {
      y = height + 150;
    }
  }

  void show() {
    //hands for blockers
    fill (255);
    noStroke();
    image(hand, x, y, 150, 90);
  }
}

class Star //note that this class does NOT extend Floater
{
  private int myX, myY; 
  private float op;
  private boolean up;
  public Star() {
    myX = (int) (Math.random()*width);
    myY = (int) (Math.random()*height);
    op = (float) (Math.random()*200)+55;
    up = false;
  }
  public void show() {
    noStroke();
    if(op < 55) {
      up = true;
    } else if(op > 255) {
      up = false;
    }
    if(up) {op += 3;} else {op -= 3;}
    fill(255, op);
    ellipse(myX, myY, op/200+3, op/200+3);
  }
}



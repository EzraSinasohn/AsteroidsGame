class Bullet extends Floater {
  int startTime;
  public Bullet(Spaceship theShip) {
    myCenterX = theShip.getX();
    myCenterY = theShip.getY();
    myXspeed = theShip.myXspeed;
    myYspeed = theShip.myYspeed;
    myPointDirection = theShip.getPointDirection();
    accelerate(10);
    startTime = millis();
    op = 255;
  }
  
  public void show() {
    op -= 3;
    stroke(200, 200, 0, op);
    fill(200, 200, 0, op);
    pushMatrix();
    translate((float) myCenterX, (float) myCenterY);
    rotate((float) (myPointDirection*PI/180));
    ellipse(0, 0, 10, 10);
    popMatrix();
  }
}



class Fragment extends Floater {
  double rot, rotSpeed;
  int startTime;
  public Fragment(double x, double y) {
    corners = 6;
    xCorners = new int[]{-5/2, 7/2, 11/2, 6/2, -5/2, -11/2};
    yCorners = new int[]{-8/2, -8/2, 0, 7/2, 8/2, 0};
    myCenterX = x;
    myCenterY = y;
    myXspeed = Math.random()*10-5;
    myYspeed = Math.random()*10-5;
    rot = Math.random()*10-15;
    rotSpeed = 10;
    myColor = 100;
    startTime = millis();
    op = 255;
  }
  void move() {
    turn(rotSpeed);
    super.move();
  }
  
  void show() {
    op -= 3;
    fill(myColor, op);
    super.show();
  }
}

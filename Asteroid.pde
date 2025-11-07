class Asteroid extends Floater {
  double rot, rotSpeed;
  boolean shown;
  public Asteroid() {
    corners = 6;
    xCorners = new int[]{-5, 7, 11, 6, -5, -11};
    yCorners = new int[]{-8, -8, 0, 7, 8, 0};
    myCenterX = Math.random()*width;
    myCenterY = Math.random()*height;
    myXspeed = Math.random()*10-5;
    myYspeed = Math.random()*10-5;
    rot = Math.random()*10-15;
    rotSpeed = 10;
    myColor = 100;
    op = 255;
  }
  void move() {
    turn(rotSpeed);
    super.move();
  }
  
  void show() {
    super.show();
  }
}

public void asteroidCount() {
   int edges = 6;
   int[] xEdges = new int[]{-5*2, 7*2, 11*2, 6*2, -5*2, -11*2};
   int[] yEdges = new int[]{-8*2, -8*2, 0, 7*2, 8*2, 0};
   fill(100);
   stroke(255);
   pushMatrix();
   translate(30, 30);
   beginShape();
    for (int nI = 0; nI < edges; nI++)
    {
      vertex(xEdges[nI], yEdges[nI]);
    }
    endShape(CLOSE);
    popMatrix();
    textAlign(CENTER, CENTER);
    fill(255);
    text(asteroids.size(), 31, 29);
}

public void mousePressed() {
  if(!(asteroids.size() == 0)) {
    keys[4] = true;
  } else {
    for(int i = 0; i < numAsteroids; i++) {asteroids.add(new Asteroid());}
    ship.myCenterX = Math.random()*width;
    ship.myCenterY = Math.random()*height;
    ship.setHealth(100);
    relTime = millis()/1000;
    //camera(width/2.0, height/2.0, (height/2.0) / tan(PI*30.0 / 180.0), width/2.0, height/2.0, 0, 0, 1, 0);
    //perspective(PI/3.0, width/height, ((height/2.0) / tan(PI*60.0/360.0))/10.0, ((height/2.0) / tan(PI*60.0/360.0))*10.0);
  }
}

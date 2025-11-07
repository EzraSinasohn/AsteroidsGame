boolean keys[] = new boolean[5];
double rot;
class Spaceship extends Floater  
{
  private int health;
  public Spaceship() {
    corners = 4;
    xCorners = new int[]{-8, 16, -8, -2};
    yCorners = new int[]{-8, 0, 8, 0};
    myCenterX = Math.random()*width;
    myCenterY = Math.random()*height;
    myColor = color(255, 0, 0);
    rot = 0;
    op = 255;
    health = 100;
  }
  
  void move() {
    if(keys[0]) {accelerate(1);}
    if(keys[1]) {
        if(rot > -5) {rot -= 0.75;}
      }
    if(keys[2]) {
        if(rot < 5) {rot += 0.75;}
      }
    if(keys[3]) {accelerate(-0.5);}
    else {
      if(!(keys[1] || keys[2])) {rot *= 0.95;}
      if(!keys[0]) {
        myXspeed *= 0.98;
        myYspeed *= 0.98;
      }
    }
    turn(rot);
    if(myXspeed > 10) {myXspeed = 10;} else if(myXspeed < -10) {myXspeed = -10;}
    if(myYspeed > 10) {myYspeed = 10;} else if(myYspeed < -10) {myYspeed = -10;}
    super.move();
  }
  
  void healthBar() {
    pushMatrix();
    stroke(0);
    fill(255, 0, 0);
    rect(20, height-20, (health*2), 20);
    fill(255, 255, 255);
    rect(20+(health*2), height-20, 200-(health*2), 20);
    textAlign(LEFT);
    textSize(20);
    fill(0, 255, 100);
    text("HP", 25, height-25);
    popMatrix();
  }
  
  public double getX() {return myCenterX;}
  public double getY() {return myCenterY;}
  public double getPointDirection() {return myPointDirection;}
  public double getHealth() {return health;}
  public void setHealth(int hp) {health = hp;}
  public void gotHit() {health -= 20;}
  
}


public void keyPressed() {
  if(!(asteroids.size() == 0)) {
    if(keyCode == UP) {
      keys[0] = true;
    } else if(keyCode == DOWN) {
      keys[3] = true;
    } if(keyCode == LEFT) {
      keys[1] = true;
    } else if(keyCode == RIGHT) {
      keys[2] = true;
    } if(key == ' ') {
      keys[4] = true;
    }
  }
}

public void keyReleased() {
  if(keyCode == UP) {
    keys[0] = false;
  } else if(keyCode == DOWN) {
    keys[3] = false;
  } if(keyCode == LEFT) {
    keys[1] = false;
  } else if(keyCode == RIGHT) {
    keys[2] = false;
  } if(key == ' ') {
    keys[4] = false;
  }
}

public void thruster() {
    if(keys[0]) {
    pushMatrix();
    stroke(255, 200, 0);
    fill(255, 100, 0);
    translate((float) ship.myCenterX, (float) ship.myCenterY);
    rotate((float) (ship.myPointDirection*PI/180.0));
    triangle(0, 5, 0, -5, -20, 0);
    popMatrix();
  } if(keys[1]) {
    pushMatrix();
    stroke(255, 200, 0);
    fill(255, 100, 0);
    translate((float) ship.myCenterX, (float) ship.myCenterY);
    rotate((float) (ship.myPointDirection*PI/180.0));
    triangle(0, 10, 0, 5, -15, 10);
    stroke(255, 0, 0);
    fill(255, 0, 0);
    triangle(0, 10, 0, 5, 10, 0);
    popMatrix();
  } if(keys[2]) {
    pushMatrix();
    stroke(255, 200, 0);
    fill(255, 100, 0);
    translate((float) ship.myCenterX, (float) ship.myCenterY);
    rotate((float) (ship.myPointDirection*PI/180.0));
    triangle(0, -10, 0, -5, -15, -10);
    stroke(255, 0, 0);
    fill(255, 0, 0);
    triangle(0, -10, 0, -5, 10, 0);
    popMatrix();
  } if(keys[3]) {
    pushMatrix();
    stroke(255, 200, 0);
    fill(255, 100, 0);
    translate((float) ship.myCenterX, (float) ship.myCenterY);
    rotate((float) (ship.myPointDirection*PI/180.0));
    triangle(0, 10, 0, 5, 15, 10);
    stroke(255, 0, 0);
    fill(255, 0, 0);
    triangle(0, 10, 0, 5, -5, 0);
    stroke(255, 200, 0);
    fill(255, 100, 0);
    triangle(0, -10, 0, -5, 15, -10);
    stroke(255, 0, 0);
    fill(255, 0, 0);
    triangle(0, -10, 0, -5, -5, 0);
    popMatrix();
  }
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

public void mouseReleased() {
  keys[4] = false;
}



boolean keys[] = new boolean[6];
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
    if(keys[5]) {boost = true;} else {boost = false;}
    if(keys[0]) {
      if(boost) {accelerate(1);}
      else {accelerate(0.5);}
    }
    if(keys[1]) {
      if(rot > -5) {rot -= 0.75;}
    }
    if(keys[2]) {
      if(rot < 5) {rot += 0.75;}
    }
    if(keys[3]) {
      if(boost) {accelerate(-0.5);}
      else {accelerate(-0.25);}
    }
    if(!(keys[1] || keys[2])) {rot *= 0.95;}
    if(!keys[0]) {
      myXspeed *= 0.98;
      myYspeed *= 0.98;
    }
    turn(rot);
    if(boost) {
        if(Math.abs(myXspeed) > Math.abs(1*Math.cos(myPointDirection*(Math.PI/180)))) {myXspeed = 1*Math.cos(myPointDirection*(Math.PI/180));}
        if(Math.abs(myYspeed) > Math.abs(1*Math.sin(myPointDirection*(Math.PI/180)))) {myYspeed = 1*Math.sin(myPointDirection*(Math.PI/180));}
    } else {
        if(Math.abs(myXspeed) > Math.abs(1*Math.cos(myPointDirection*(Math.PI/180)))) {myXspeed = 1*Math.cos(myPointDirection*(Math.PI/180));}
        if(Math.abs(myYspeed) > Math.abs(1*Math.sin(myPointDirection*(Math.PI/180)))) {myYspeed = 1*Math.sin(myPointDirection*(Math.PI/180));}
    }
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
  public void gotHit(int dmg) {
    health -= dmg;
    dmgless = false;
  }
  
}


public void keyPressed() {
  if(!(asteroids.size() == 0)) {
    if(keyCode == UP || key == 'w') {
      keys[0] = true;
      moveless = false;
    } else if(keyCode == DOWN || key == 's') {
      keys[3] = true;
      moveless = false;
    } if(keyCode == LEFT || key == 'a') {
      keys[1] = true;
      turnless = false;
    } else if(keyCode == RIGHT || key == 'd') {
      keys[2] = true;
      turnless = false;
    } if(key == ' ') {
      keys[4] = true;
    } if(keyCode == SHIFT) {
      keys[5] = true;
    }
  }
}

public void keyReleased() {
  if(keyCode == UP || key == 'w') {
    keys[0] = false;
  } else if(keyCode == DOWN || key == 's') {
    keys[3] = false;
  } if(keyCode == LEFT || key == 'a') {
    keys[1] = false;
  } else if(keyCode == RIGHT || key == 'd') {
    keys[2] = false;
  } if(key == ' ') {
    keys[4] = false;
  } if(key == 'r' || key == 'h') {
    reset();
  } if(keyCode == SHIFT) {
    keys[5] = false;
  }
}

public void thruster() {
    if(keys[0]) {
    pushMatrix();
    stroke(255, 200, 0);
    fill(255, 100, 0);
    translate((float) ship.myCenterX, (float) ship.myCenterY);
    rotate((float) (ship.myPointDirection*PI/180.0));
    if(boost) {triangle(0, 5, 0, -5, -25, 0);}
    else {triangle(0, 5, 0, -5, -20, 0);}
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
    if(boost) {triangle(0, 10, 0, 5, 20, 10);}
    else {triangle(0, 10, 0, 5, 15, 10);}
    stroke(255, 0, 0);
    fill(255, 0, 0);
    triangle(0, 10, 0, 5, -5, 0);
    stroke(255, 200, 0);
    fill(255, 100, 0);
    if(boost) {triangle(0, -10, 0, -5, 20, -10);}
    else {triangle(0, -10, 0, -5, 15, -10);}
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
    reset();
  }
}

public void mouseReleased() {
  keys[4] = false;
}


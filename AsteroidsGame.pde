Star[] stars = new Star[100];
Spaceship ship = new Spaceship();
ArrayList <Asteroid> asteroids = new ArrayList<Asteroid>();
ArrayList <Bullet> shots = new ArrayList<Bullet>();
ArrayList <Fragment> rubble = new ArrayList<Fragment>();
int cooldown, numAsteroids = 30, relTime = 0, seconds;
Badge noDamage = new Badge(50, "INVINCIBLE", 255, 0, 0);
Badge noMove = new Badge(130, "LAZY", 0, 100, 255);
Badge noTurn = new Badge(210, "FOCUSED", 100, 255, 0);
Badge speedrun = new Badge(290, "SPEEDRUNNER", 255, 200, 0);
boolean dmgless = true, moveless = true, turnless = true, fast = true;
public void setup() 
{
  //fullScreen(P3D);
  size(1200, 800);
  background(0);
  noCursor();
  for(int i = 0; i < stars.length; i++) {stars[i] = new Star();}
  for(int i = 0; i < numAsteroids; i++) {asteroids.add(new Asteroid());}
}
public void draw() 
{
    background(0);
    for(int i = 0; i < stars.length; i++) {stars[i].show();}
    ship.move();
    thruster();
    ship.show();
    if(keys[4] && millis() - cooldown > 100) {
      shots.add(new Bullet(ship));
      if(millis() - cooldown > 100) {cooldown = millis();}
    }
    for(int i = 0; i < asteroids.size(); i++) {
      asteroids.get(i).move();
      asteroids.get(i).show();
    }
    for(int i = 0; i < asteroids.size(); i++) {  
      float aDist = dist((float) ship.myCenterX, (float) ship.myCenterY, (float) asteroids.get(i).myCenterX, (float) asteroids.get(i).myCenterY);
      if(aDist < 30 && seconds-relTime > 3) {
        asteroids.remove(i);
        ship.gotHit(20);
        break;
      }
    }
    for(int i = 0; i < asteroids.size(); i++) {
      for(int b = 0; b < shots.size(); b++) {
        float bDist = dist((float) shots.get(b).myCenterX, (float) shots.get(b).myCenterY, (float) asteroids.get(i).myCenterX, (float) asteroids.get(i).myCenterY);
        if(bDist < 20) {
          for(int f = 0; f < 4; f++) {
            rubble.add(new Fragment(asteroids.get(i).myCenterX, asteroids.get(i).myCenterY));
          }
          asteroids.remove(i);
          shots.remove(b);
          break;
        }
      }
    }
    for(int i = 0; i < shots.size(); i++) {
      shots.get(i).move();
      shots.get(i).show();
    }
    for(int i = 0; i < shots.size(); i++) {
      if(millis()-shots.get(i).startTime > 1500 || shots.get(i).myCenterX <= 10 || shots.get(i).myCenterX >= width-10 || shots.get(i).myCenterY <= 10 || shots.get(i).myCenterY >= height-10) {
        shots.remove(i);
        break;
      }
    }
    if(asteroids.size() == 0) {
      for(int i = 0; i < keys.length; i++) {
        keys[i] = false;
      }
      if(ship.getHealth() > 0) {
        textAlign(CENTER, CENTER);
        textSize(100);
        fill(0, 255, 100);
        text("You Win!", width/2, height/2);
        if(dmgless == true) {noDamage.setActive(dmgless);}
        if(moveless == true) {noMove.setActive(moveless);}
        if(turnless == true) {noTurn.setActive(turnless);}
        if(fast == true) {speedrun.setActive(fast);}
      } else {
        textAlign(CENTER, CENTER);
        textSize(100);
        fill(255, 0, 0);
        text("You Lose!", width/2, height/2);
      }
      //camX += (ship.myCenterX-camX)/20;
      //camY += (ship.myCenterY-camY)/20;
      //camera(camX, camY, (height/2.0) / tan(PI*30.0 / 180.0), (float) ship.myCenterX, (float) ship.myCenterY, 0, 0, 1, 0);
      //perspective(PI/30, width/height, ((height/2.0) / tan(PI*60.0/360.0))/10.0, ((height/2.0) / tan(PI*60.0/360.0))*10.0);
    }
    for(int i = 0; i < rubble.size(); i++) {
      rubble.get(i).move();
      rubble.get(i).show();
    }
    
    for(int i = 0; i < rubble.size(); i++) {
      if(millis()-rubble.get(i).startTime > 1500 || rubble.get(i).myCenterX <= 10 || rubble.get(i).myCenterX >= width-10 || rubble.get(i).myCenterY <= 10 || rubble.get(i).myCenterY >= height-10) {
        rubble.remove(i);
        break;
      }
    }
    for(int i = 0; i < rubble.size(); i++) {  
      float fDist = dist((float) ship.myCenterX, (float) ship.myCenterY, (float) rubble.get(i).myCenterX, (float) rubble.get(i).myCenterY);
      if(fDist < 20 && seconds-relTime > 3) {
        rubble.remove(i);
        ship.gotHit(5);
        break;
      }
    }
    ship.healthBar();
    if(ship.getHealth() <= 0) {
      ship.setHealth(0);
      for(int i = 0; i < asteroids.size(); i++) {asteroids.remove(i);}
    }
    bubble();
    asteroidCount();
    timer();
    noDamage.show();
    noMove.show();
    noTurn.show();
    speedrun.show();
}

public void timer() {
  if(asteroids.size() > 0) {seconds = millis()/1000;}
  textAlign(RIGHT, CENTER);
  textSize(40);
  fill(255);
  text(seconds-relTime, width-20, 30);
  if(seconds-relTime > 20) {fast = false;}
}

public void bubble() {
  stroke(0, 0, 255);
  fill(0, 200, 255, 90);
  if(seconds-relTime < 3) {ellipse((float) ship.getX(), (float) ship.getY(), 50, 50);}
}

public void reset() {
  for(int i = asteroids.size()-1; i >= 0; i--) {asteroids.remove(i);}
  for(int i = 0; i < numAsteroids; i++) {asteroids.add(new Asteroid());}
  ship.myCenterX = Math.random()*width;
  ship.myCenterY = Math.random()*height;
  ship.setHealth(100);
  ship.myPointDirection = Math.random()*360;
  relTime = millis()/1000;
  dmgless = true;
  moveless = true;
  turnless = true;
  fast = true;
}

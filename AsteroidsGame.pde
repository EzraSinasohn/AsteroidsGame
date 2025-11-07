Star[] stars = new Star[500];
Spaceship ship = new Spaceship();
ArrayList <Asteroid> asteroids = new ArrayList<Asteroid>();
ArrayList <Bullet> shots = new ArrayList<Bullet>();
ArrayList <Fragment> rubble = new ArrayList<Fragment>();
int cooldown, numAsteroids = 50, relTime = 0, seconds;
float fov, camX = width/2.0, camY = height/2.0;
public void setup() 
{
  //fullScreen(P3D);
  size(1500, 1000, P3D);
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
      if(aDist < 30) {
        asteroids.remove(i);
        ship.gotHit();
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
    ship.healthBar();
    if(ship.getHealth() == 0) {
      for(int i = 0; i < asteroids.size(); i++) {asteroids.remove(i);}
    }
    asteroidCount();
    timer();
}

public void timer() {
  if(asteroids.size() > 0) {seconds = millis()/1000;}
  textAlign(CENTER, CENTER);
  textSize(40);
  fill(255);
  text(seconds-relTime, width-50, 30);
}

/*public float dist(float x1, float y1, float x2, float y2) {
  return((float) (Math.sqrt((x1-x2)(x1-x2)+(y1-y2)(y1-y2))));
}*/

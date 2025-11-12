class Badge {
  private String myID;
  private int red, green, blue;
  private float myX;
  private boolean active;
  public Badge(int x, String id, int r, int g, int b) {
    myX = x;
    myID = id;
    red = r;
    green = g;
    blue = b;
    active = false;
  }
  
  public void show() {
    pushMatrix();
    strokeWeight(2);
    if(active) {
      fill(red, green, blue);
      stroke(red-100, green-100, blue-100);
    } else {
      fill(250, 80);
      stroke(100, 80);
    }
    translate(width-myX, height-50);
    ellipse(0, 0, 75, 75);
    fill(0);
    textSize(10);
    textAlign(CENTER, CENTER);
    text(myID, 0, 0);
    strokeWeight(1);
    popMatrix();
  }
  
  public void setActive(boolean act) {
    active = act;
  }
}

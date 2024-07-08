class Player {
  private final float fov = PI/3;
  private final int numberOfRays = 60;
  
  private PVector pos, vel;
  private float orientation;
  private PVector[] rays;
  
  private float speed = 3, rotSpeed = radians(3);
  private int dx, dy, deltaOrientation;
  
  public Player(float x, float y, float orientation) {
    this.orientation = orientation;
    pos = new PVector(x, y);
    vel = new PVector();
    rays = new PVector[numberOfRays];
  }
  
  public void update() {
    vel.x = dx*cos(orientation)+dy*sin(orientation);
    vel.y = dy*cos(orientation)-dx*sin(orientation);
    
    float castedVel = scene2D.level.castRay(new PVector(vel.x, -vel.y))-2;
    vel.mult(min(castedVel, speed));
    pos.add(vel);
    
    orientation += deltaOrientation*rotSpeed;
    for (int i = 0; i < numberOfRays; i++) {
      float angle = orientation+map(i, 0, numberOfRays, fov/2, -fov/2);
      rays[i] = PVector.fromAngle(angle);
    }
  }
  
  public void move(char input) {
    if (input == 'w') dx = 1;
    else if (input == 'a') dy = -1;
    else if (input == 's') dx = -1;
    else if (input == 'd') dy = 1;
  }
  
  public void stopMoving(char input) {
    if (input == 'w' || input == 's') dx = 0;
    else if (input == 'a' || input == 'd') dy = 0;
  }
  
  public void turn(int input) {
    if (input == LEFT) deltaOrientation = 1;
    else if (input == RIGHT) deltaOrientation = -1;
  }
  
  public void stopTurning(int input) {
    if (input == LEFT || input == RIGHT)
      deltaOrientation = 0;
  }
  
  public void show() {
    stroke(0, 200, 0);
    strokeWeight(1);
    for (PVector ray : rays) {
      PVector rayEnd = PVector.add(new PVector(ray.x, -ray.y), pos);
      line(pos.x, pos.y, rayEnd.x, rayEnd.y);
    }
    
    strokeCap(ROUND);
    stroke(0, 255, 0);
    strokeWeight(10);
    point(pos.x, pos.y);
  }
  
  public void projectRays() {
    float lineWidth = (float) scene3D.getWidth()/numberOfRays;
    strokeWeight(lineWidth+1);
    strokeCap(SQUARE);
    for (int i = 0; i < numberOfRays; i++) {
      float deltaAngle = orientation-rays[i].heading();
      float lineHeight = (scene2D.level.getMapSize()*scene3D.getHeight())/(rays[i].mag()*cos(deltaAngle));
      if (lineHeight > scene3D.getHeight()) lineHeight = scene3D.getHeight();
      
      stroke(0, map(lineHeight, 0, scene3D.getHeight(), 0, 255), 0);
      float x = i*lineWidth+lineWidth/2;
      float y = scene3D.getHeight()/2-lineHeight/2;
      line(x, y, x, y+lineHeight);
    }
  }
  
  public PVector[] getRays() {
    return rays;
  }
}

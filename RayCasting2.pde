Scene2D scene2D;
Scene3D scene3D;

int[] map = {
  1, 1, 1, 1, 1, 1, 1, 1,
  1, 0, 0, 1, 0, 0, 0, 1,
  1, 0, 0, 1, 0, 0, 0, 1,
  1, 0, 0, 0, 0, 0, 0, 1,
  1, 0, 0, 0, 0, 0, 0, 1,
  1, 0, 0, 0, 0, 1, 0, 1,
  1, 0, 0, 0, 0, 0, 0, 1,
  1, 1, 1, 1, 1, 1, 1, 1
};

void setup() {
  size(1000, 500);
  scene2D = new Scene2D(width/2, height);
  scene2D.level = new Level(8, 8, map);
  scene2D.player = new Player(width/4, height/2, 0);
  
  scene3D = new Scene3D(width/2, height);
  scene3D.player = scene2D.player;
}

void draw() {
  scene2D.update();
  
  background(0);
  
  scene2D.show(0, 0);
  scene3D.show(width/2, 0);
}

void keyPressed() {
  scene2D.player.move(key);
  scene2D.player.turn(keyCode);
}

void keyReleased() {
  scene2D.player.stopMoving(key);
  scene2D.player.stopTurning(keyCode);
}

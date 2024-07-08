class Scene2D extends Scene {
  public Level level;
  public Player player;
  
  public Scene2D(int sceneWidth, int sceneHeight) {
    super(sceneWidth, sceneHeight);
  }
  
  public void update() {
    player.update();
    level.castRays();
  }
  
  public void show(int x, int y) {
    pushMatrix();
    translate(x, y);
    level.show();
    player.show();
    popMatrix();
  }
}

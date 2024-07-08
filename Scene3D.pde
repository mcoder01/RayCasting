class Scene3D extends Scene {
  public Player player;
  
  public Scene3D(int sceneWidth, int sceneHeight) {
    super(sceneWidth, sceneHeight);
  }
  
  public void update() {}
  
  public void show(int x, int y) {
    pushMatrix();
    translate(x, y);
    player.projectRays();
    popMatrix();
  }
}

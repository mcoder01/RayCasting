abstract class Scene {
  protected int sceneWidth, sceneHeight;
  
  public Scene(int sceneWidth, int sceneHeight) {
    this.sceneWidth = sceneWidth;
    this.sceneHeight = sceneHeight;
  }
  
  public abstract void update();
  public abstract void show(int x, int y);
  
  public int getWidth() {
    return sceneWidth;
  }
  
  public int getHeight() {
    return sceneHeight;
  }
}

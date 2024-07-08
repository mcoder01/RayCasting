class Level {
  private int[] map;
  private int rows, cols;
  private float wallSize;
  
  public Level(int rows, int cols, int[] map) {
    this.rows = rows;
    this.cols = cols;
    this.map = map;
    wallSize = (float) scene2D.getWidth()/cols;
  }
  
  public void castRays() {
    for (PVector ray : scene2D.player.getRays())
      ray.setMag(castRay(ray));
  }
  
  public float castRay(PVector ray) {
    float dist1 = castHorizontally(ray);
    float dist2 = castVertically(ray);
    return min(dist1, dist2);
  }
  
  private float castHorizontally(PVector ray) {
    if (ray.heading() == 0 || ray.heading() == PI)
      return MAX_FLOAT;
    
    int playerRow = (int) (scene2D.player.pos.y/scene2D.getHeight()*rows);
    int end, step, off;
    if (ray.heading() < PI && ray.heading() > 0) {
      end = -1;
      step = -1;
      off = 1;
    } else {
      end = rows;
      step = 1;
      off = 0;
    }
    
    playerRow += step;
    for (int i = playerRow; i != end; i += step) {
      float cy = (float) (i+off)/rows*scene2D.getHeight();
      float mag = abs((scene2D.player.pos.y-cy)/sin(ray.heading()));
      float cx = mag*cos(ray.heading())+scene2D.player.pos.x;
      int j = (int) (cx/scene2D.getWidth()*cols);
      if (j >= 0 && j < cols && map[i*cols+j] == 1)
        return mag;
    }
    
    return MAX_FLOAT;
  }
  
  private float castVertically(PVector ray) {
    if (ray.heading() == HALF_PI || ray.heading() == -HALF_PI)
      return MAX_FLOAT;
      
    int playerCol = (int) (scene2D.player.pos.x/scene2D.getWidth()*cols);
    int end, step, off;
    if ((ray.heading() >= 0 && ray.heading() < HALF_PI)
        || (ray.heading() > -HALF_PI && ray.heading() <= 0)) {
      end = cols;
      step = 1;
      off = 0;
    } else {
      end = -1;
      step = -1;
      off = 1;
    }
    
    playerCol += step;
    for (int j = playerCol; j != end; j += step) {
      float cx = (float) (j+off)/cols*scene2D.getWidth();
      float mag = abs((cx-scene2D.player.pos.x)/cos(ray.heading()));
      float cy = scene2D.player.pos.y-mag*sin(ray.heading());
      int i = (int) (cy/scene2D.getHeight()*rows);
      if (i >= 0 && i < rows && map[i*cols+j] == 1)
        return mag;
    }
    
    return MAX_FLOAT;
  }
  
  public void show() {
    noStroke();
    for (int i = 0; i < rows; i++)
      for (int j = 0; j < cols; j++) {
        fill(map[i*cols+j]*255);
        rect(j*wallSize, i*wallSize, floor(wallSize-1), floor(wallSize-1));
      }
  }
  
  public int getMapSize() {
    return rows*cols;
  }
}

public class ControlledCell extends Cell
{
  public ControlledCell(float weight)
  {
    super(weight);
  }
  void updaten() {
    float dx = 0, dy = 0;
    if (keyPressed) {
      if (key == CODED) {
        if (keyCode  == LEFT && keyCode == UP) {
          dx=-speed/1.4142135926;
          dy=speed/1.4142135926;
        } else if (keyCode  == LEFT && keyCode == DOWN) {
          dx=-speed/1.4142135926;
          dy=-speed/1.4142135926;
        } else if (keyCode  == RIGHT && keyCode == UP) {
          dx=speed/1.4142135926;
          dy=speed/1.4142135926;
        } else if (keyCode  == RIGHT && keyCode == DOWN) {
          dx=speed/1.4142135926;
          dy=-speed/1.4142135926;
        } else if (keyCode  == UP) {
          dx=0;
          dy=-speed;
        } else if (keyCode  == DOWN) {
          dx=0;
          dy=speed;
        } else if (keyCode  == LEFT) {
          dx=-speed;
          dy=0;
          int n = 200;
          float[] nearCells = findNNearest(n);
          for(int i = 0; i < n; i++)
          {
           println("w: "+ nearCells[3*i] + "  |  d: " + nearCells[3*i+1] + "  |  d: " + nearCells[3*i+2]); 
          }
        } else if (keyCode  == RIGHT) {
          dx=speed;
          dy=0;
        }
      }
    }
    if (x >= 1)
      x = 0.99;
    else if (x <= 0)
      x = 0.01;
    if (y >= 1)
      y = 0.99;
    if (y <= 0)
      y = 0.01;
    x += dx;
    y += dy;
  }
  void draw() {
    fill(255, 255, 255);
    noStroke();
    ellipse(x*width, y*height, w*weightToRadius*scaling, w*weightToRadius*scaling);
  }
}
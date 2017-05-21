public class ControlledCell extends Cell
{
  public float d, s;
  
  public ControlledCell(float weight)
  {
    super(weight);
    s = 1;
    d = 0;
  }
  void updaten() {
    a=0;
     d = atan((((float)(mouseY)/ screen)-y)/(((float)(mouseX) / screen)-x));
      if (((float)(mouseX) / screen) <x)
      {
        d += PI;
      }
      if (d<0)
      {
        d += TAU;
      }
      
      s = (float)(Math.sqrt((Math.pow((x-(float)(mouseX)/screen), 2))+(Math.pow((y-(float)(mouseY)/screen), 2))))*5;
      if(s > 1)
        s = 1;
    x += speed*s*cos(d);
    y += speed*s*sin(d);
    if (x >= 1 || x <= 0)
      if (d <= PI)
        d = PI - d;
      else
        d = (3*PI)-d;

    if (y >= 1 || y <= 0)
      d = TAU-d;
    
    /*
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
    y += dy;*/
  }
  void draw() {
    fill(70, 200, 20);
    stroke(255);
    ellipse(x*screen, y*screen, (float)Math.sqrt(w)*weightToRadius*scaling, (float)Math.sqrt(w)*weightToRadius*scaling);
  }
}
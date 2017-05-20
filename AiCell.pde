public class AiCell extends Cell
{
  public float d, s;

  public AiCell(float weight)
  {
    super(weight);
    d=random(TAU);
    s=random(1);
  }
  void updaten() {
    x += speed*s*cos(d);
    y += speed*s*sin(d);
    if (x >= 1 || x <= 0)
      if (d <= PI)
        d = PI - d;
      else
        d = (3*PI)-d;

    if (y >= 1 || y <= 0)
      d = TAU-d;
  }
  void draw() {
    fill(204, 102, 0);
    noStroke();
    ellipse(x*width, y*height, w*weightToRadius*scaling, w*weightToRadius*scaling);
  }
}

public class Net{
  float[][] net = new float[3][10];
  float[][] 
  public Net(){}
}
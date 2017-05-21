public class DumbCell extends Cell
{
  public float d, s;

  public DumbCell(float weight)
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
    ellipse(x*screen, y*screen, w*weightToRadius*scaling, w*weightToRadius*scaling);
  }
}
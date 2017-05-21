public class AlgCell extends Cell
{
  public float d, s;

  public AlgCell(float weight)
  {
    super(weight);
    d=random(TAU);
    s=random(1);
  }
  void updaten() {
    if(w > 10) split = true;
    else split = false;
    float[] nearCell = findNNearest(1);
    if (nearCell[0] < w)
    {
      d = nearCell[1];
    } else
    {
      d = ((nearCell[1] + PI) % TAU);
    }
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
  Cell split() {
    w = w/2;
    println("A SPLIT!");
    return new AlgCell(w);
  }  
  void draw() {
    fill(204, 200, 0);
    noStroke();
    ellipse(x*screen, y*screen, w*weightToRadius*scaling, w*weightToRadius*scaling);
  }
}
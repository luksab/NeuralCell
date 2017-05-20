abstract class Cell
{
  public float w, x, y, a;
  public boolean del;

  public Cell(float weight)
  {
    w = weight;
    x=random(1);
    y=random(1);
  }
  void update() {
    a ++;
    if (random(1) > 5000/a) {
      lostWeight +=w;
      del = true;
    }
    lostWeight += w*0.002;
    w *= 0.998;
    if (w < 0.5) {
      del = true;
      lostWeight += w;
    }
    updaten();
  }
  void updaten() {
  }
  void draw() {
  }
  boolean isColliding(Cell c) {
    if (c == this) return false;
    return(Math.pow((c.x - x), 2)+Math.pow((c.y - y), 2)<=Math.pow(((c.w + w)*weightToRadius), 2));
  }
}
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
  float[] findNNearest(int n)
  {
    Cell[] nearCells = new Cell[n];
    for (Cell c : Cells)
    {
      for (int i = 0; i<n; i++)
      {
        if (nearCells[i] == null || distance(c) < distance(nearCells[i]))
        {
          Cell p = nearCells[i];
          nearCells[i] = c;
          for (int j = i + 1; j<n; j++)
          {
            if (distance(p) < distance(nearCells[j]))
            {
              Cell f = p;
              p = nearCells[j];
              nearCells[j] = f;
            }
          }
          break;
        }
      }
    }
    float[] result = new float[3*n];
    for (int i = 0; i<n; i++)
    {
      result[3*i] = nearCells[i].w;
      result[3*i+1] = atan((nearCells[i].y-y)/(nearCells[i].x-x));
      if (nearCells[3*i].x<x)
      {
        result[3*i+1] += PI;
      }
      if (result[3*i+1]<0)
      {
        result[3*i+1] += TAU;
      }
      result[3*i+2] = (float)(Math.sqrt(Math.pow((nearCells[i].x - x), 2)+Math.pow((nearCells[i].y - y), 2)));
    }
    return result;
  }

  double distance(Cell c)
  {
    return(Math.sqrt(Math.pow((x-c.x), 2)+Math.pow((y-c.y), 2)));
  }

  boolean isColliding(Cell c) {
    if (c == this) return false;
    return(Math.pow((c.x - x), 2)+Math.pow((c.y - y), 2)<=Math.pow(((c.w + w)*weightToRadius), 2));
  }
}
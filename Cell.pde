abstract class Cell
{
  public float w, x, y, a, l;
  public boolean del, split = false;

  public Cell(float weight)
  {
    w = weight;
    x=random(1);
    y=random(1);
    l = 0.001;
  }
  void update() {
    a ++;
    if (random(1) > 5000/a) {
      lostWeight +=w;
      del = true;
    }
    lostWeight += w*l;
    w *= (1-l);
    if (w < 0.05) {
      del = true;
      lostWeight += w;
    }
    if (x >= 1)
      x = 0.99;
    else if (x <= 0)
      x = 0.01;
    if (y >= 1)
      y = 0.99;
    if (y <= 0)
      y = 0.01;
    updaten();
  }
  Cell split(){
    return new DumbCell(0);
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
      if (c!=this)
      {
        for (int i = 0; i<n; i++)
        {
          if (nearCells[i] == null)
          {
            nearCells[i] = c;
          } else if (distance(c) < distance(nearCells[i]))
          {
            Cell p = nearCells[i];
            nearCells[i] = c;
            for (int j = i + 1; j<n; j++)
            {
              if (nearCells[j] == null)
              {
                break;
              }
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
    }
    float[] result = new float[3*n];
    for (int i = 0; i<n; i++)
    {
      if(nearCells[i] != null)
      {
      result[3*i] = nearCells[i].w;
      result[3*i+1] = atan((nearCells[i].y-y)/(nearCells[i].x-x));
      if (nearCells[i].x<x)
      {
        result[3*i+1] += PI;
      }
      if (result[3*i+1]<0)
      {
        result[3*i+1] += TAU;
      }
      result[3*i+2] = (float)(distance(nearCells[i]));
    }
  }
    return result;
  }

  double distance(Cell c)
  {
    return(Math.sqrt((Math.pow((x-c.x), 2))+(Math.pow((y-c.y), 2))));
  }

  boolean isColliding(Cell c) {
    if (c == this) return false;
    return(Math.pow((c.x - x), 2)+Math.pow((c.y - y), 2)<=Math.pow((((float)Math.sqrt(c.w) + (float)Math.sqrt(w))*weightToRadius), 2));
  }
}
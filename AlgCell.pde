public class AlgCell extends Cell
{
  public float d, s;

  public AlgCell(float weight)
  {
    super(weight);
    d=random(TAU);
    s=1;
  }
  void updaten() {
    if (w > 10) split = true;
    else split = false;
    float[] nearCell = findNNearest(1);
    if (nearCell[0] < w)
    {
      d = nearCell[1];
    } else
    {
      d = ((nearCell[1] + PI) % TAU); 
      if (x >= 0.99 && y >=0.99)
      {
        if (d < PI / 4 || d > 3*PI / 2)
        {
          d = 3*PI / 2;
        } else if (d < PI / 2)
        {
          d = PI;
        }
      } else if (x <= 0.01 && y >=0.99)
      {
        if (d < 3*PI / 4)
        {
          d = 0;
        } else if (d < 3*PI / 2)
        {
          d = 3*PI / 2;
        }
      } else if (x >= 0.99 && y <=0.01)
      {
        if (d < PI / 2 ||  d > 7*PI / 4)
        {
          d = PI / 2;
        } else if (d > PI)
        {
          d = PI;
        }
      }
      if (x <= 0.01 && y <=0.01)
      {
        if (d > 5*PI / 7)
        {
          d = 0;
        } else if (d < PI / 2)
        {
          d = PI / 2;
        }
      } else
      {
        if (x >= 0.99)
        {
          if (d < PI / 2)
          {
            d = PI/2;
          } else if (d > 3*PI / 2 && d != 0)
          {
            d = 3*PI / 2;
          } else if (d == 0)
          {
            if (y > 0.5)
            {
              d = 3*PI/2;
            } else
            {
              d = PI/2;
            }
          }
        } else if (x <= 0.01)
        {
          if (d > PI / 2 && d < PI)
          {
            d = PI/2;
          } else if (d > PI && d < 3*PI / 2)
          {
            d = 3*PI / 2;
          } else if (d == PI)
          {
            if (y > 0.5)
            {
              d = 3*PI/2;
            } else
            {
              d = PI/2;
            }
          }
        }
        if (y >= 0.99)
        {
          if (d > PI / 2 && d < PI)
          {
            d = PI;
          } else if (d < PI / 2)
          {
            d = 0;
          } else if (d == PI / 2)
          {
            if (x > 0.5)
            {
              d = PI;
            } else
            {
              d = 0;
            }
          }
        } else if (y <= 0.01)
        {
          if (d < 3*PI / 2 && d > PI)
          {
            d = PI;
          } else if (d > 3*PI / 2)
          {
            d = 0;
          } else if (d == 3*PI / 2)
          {
            if (x > 0.5)
            {
              d = PI;
            } else
            {
              d = 0;
            }
          }
        }
      }
    }
    x += speed*s*cos(d);
    y += speed*s*sin(d);
  }
  Cell split() {
    w = w/2;
    return new AlgCell(w);
  }  
  void draw() {
    fill(204, 200, 0);
    noStroke();
    ellipse(x*screen, y*screen, w*weightToRadius*scaling, w*weightToRadius*scaling);
  }
}
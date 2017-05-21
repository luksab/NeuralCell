public class AiCell extends Cell
{
  public float d, s;
  public Net net;

  public AiCell(float weight)
  {
    super(weight);
    d=random(TAU);
    s=random(1);
    net = new Net();
  }
  public AiCell(float weight, float[][] l0, float[][] l1)
  {
    super(weight);
    d=random(TAU);
    s=random(1);
    net = new Net();
  }
  void updaten() {
    float[] arr = findNNearest(1);
    float[] array = new float[10];
    for (int i=0; i<3; i++)
      array[i] = arr[i];
    array[9] = w;
    //println(net.update(array));
    arr = net.update(array);
    d = arr[0];
    if (arr[1] < 0)
      arr[1] = -arr[1];
    if (arr[1] > 1)
      s = 1;
    else
      s = arr[1];
    if (arr[2] > 0.5) split = true;
    x += speed*s*cos(d*TAU);
    y += speed*s*sin(d*TAU);
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
    return new AiCell(w, net.l0, net.l1);
  }  
  void draw() {
    fill(30, 50, 240);
    noStroke();
    ellipse(x*width, y*height, w*weightToRadius*scaling, w*weightToRadius*scaling);
  }
}

public class Net {
  float[][] l0 = new float[10][10];
  float[][] l1 = new float[10][3];
  public Net() {
    for (int i=0; i<l0.length; i++) {
      for (int j=0; j<l0[0].length; j++)
        l0[i][j] = random(-1, 1);
    }
    for (int i=0; i<l1.length; i++) {
      for (int j=0; j<l1[0].length; j++)
        l1[i][j] = random(-1, 1);
    }
  }
  public Net(float[][] ol0, float[][] ol1) {
    for (int i=0; i<l0.length; i++) {
      for (int j=0; j<l0[0].length; j++)
        l0[i][j] = ol0[i][j];
    }
    for (int i=0; i<l1.length; i++) {
      for (int j=0; j<l1[0].length; j++)
        l1[i][j] = ol1[i][j];
    }
  }
  public float[] update(float[] input) {
    if (input.length != l0[0].length)
      return new float[0];
    float[] layer = new float[input.length]; 
    for (int i=0; i<input.length; i++) {
      for (int j=0; j<l0[0].length; j++)
        layer[i] += input[i]*l0[i][j];
    }
    float[] out = new float[l1[0].length];
    for (int i=0; i<l1[0].length; i++) {
      for (int j=0; j<l1[0].length; j++)
        out[i] +=
          layer[i]*
          l1[i][j];
    }
    return out;
  }
}
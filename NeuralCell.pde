float speed = 0.003, weightToRadius = 0.01, scaling, lostWeight=0;
int p=1;
ArrayList<Cell> Cells = new ArrayList<Cell>();

void setup() {
  size(750, 750);
  scaling = (width+height);
  background(0);
  Cells.add(new ControlledCell(5));
  Cells.add(new AlgCell(5));

  for (int i = 0; i<10; i++)
    Cells.add(new DumbCell(random(0.01, 7)));
}

void draw() {
  background(0);
  for (int k=0; k<p; k++) {
    if (lostWeight > 5) {
      for (int i=0; i<lostWeight; i++)
        if(random(0, 2)<1)
      {
      Cells.add(new AlgCell(5));
      }
      else
      {
        Cells.add(new AiCell(3));
      }
      lostWeight --;
    }
    if (lostWeight > 2) {
      if(random(0, 2)<1)
      {
      Cells.add(new AlgCell(lostWeight));
      }
      else if(random(0, 2)<1)
      {
      Cells.add(new AiCell(lostWeight));
      }
      else
      {
        Cells.add(new DumbCell(lostWeight));
      }
      lostWeight = 0;
      // println(frameRate);
    }

    for (int i=0; i<Cells.size(); i++) {
      Cell d = Cells.get(i);
      d.update();
      if (d.del)
        Cells.remove(d);
    }

    for (int i=0; i<Cells.size(); i++)
      for (int j=i+1; j<Cells.size(); j++) {
        Cell d0 = Cells.get(i);
        Cell d1 = Cells.get(j);
        if (d0.isColliding(d1)) {
          if (d0.w > d1.w) {  
            d0.w += d1.w;
            Cells.remove(j);
          } else if (d1.w > d0.w) { 
            d1.w += d0.w;
            Cells.remove(i);
          } else { 
            d0.w += d1.w;
            Cells.remove(j);
          }
        }
      }
  }
  for (Cell d : Cells) {
    d.draw();
  }
}

void mouseWheel(MouseEvent event) {
  float e = -event.getCount();
  if (p >= 0) {
    p += e;
    if (p > 5)
      p += 10*e;
    if (p > 100)
      p += 100*e;
    if (p > 1000)
      p += 1000*e;
  } else
    p=0;
}
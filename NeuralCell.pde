float speed = 0.003, weightToRadius = 0.01, scaling, lostWeight=0;
ArrayList<Cell> Cells = new ArrayList<Cell>();

void setup() {
  size(750, 750);
  scaling = (width+height);
  background(0);
  Cells.add(new ControlledCell(10));

  for (int i = 0; i<5; i++)
    Cells.add(new DumbCell(random(0.01, 5)));
}

void draw() {
  background(0);
  for (int k=0; k<1; k++) {
    if (lostWeight > 5) {
      for (int i=0; i<lostWeight; i++)
        Cells.add(new AiCell(1));
      lostWeight --;
    }
    if (lostWeight > 1) {
      Cells.add(new AiCell(lostWeight));
      lostWeight = 0;
      println(frameRate);
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
float speed = 0.003, weightToRadius = 0.007, scaling, lostWeight=0;
int p=1, screen;
ArrayList<Cell> Cells = new ArrayList<Cell>();
boolean wide;

void setup() {
  //size(750, 750);
  fullScreen();
  if (width>height) {
    screen = height;
    wide = true;
  } else { 
    screen = width;
    wide = false;
  }
  scaling = (2*screen);
  background(0);
  Cells.add(new ControlledCell(10));
  Cells.add(new AlgCell(5));
  float gesMass = 95;
  for (int i = 0; i<100; i++) {
    float cell = random(1, 10);
    Cells.add(new AiCell(gesMass/cell));
    gesMass = gesMass/cell;
  }
  Cells.add(new AiCell(gesMass));
}

void draw() {
  background(0);
  stroke(255);
  line(screen, 0, screen, height);
  line(0, screen, width, screen);
  for (int k=0; k<p; k++) {
    if (lostWeight > 5) {
      for (int i=0; i<lostWeight; i++) {
        Cells.add(new AiCell(0.8));
        lostWeight --;
      }
    }
    if (lostWeight > 2) {       
      Cells.add(new AiCell(lostWeight));
      lostWeight = 0;
      // println(frameRate);
    }

    for (int i=0; i<Cells.size(); i++) {
      Cell d = Cells.get(i);
      d.update();
      if (d.del)
        Cells.remove(d);
    }
    for (int i=0; i<Cells.size(); i++) {
      Cell d = Cells.get(i);
      d.update();
      if (d.split)
        Cells.add(d.split());
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

void mouseReleased() {
  if (mouseButton == LEFT)
  {
    if (wide && mouseX > screen)
    {
      Cells.add(new ControlledCell(5));
      lostWeight -=5;
    } else if (!wide && mouseY > screen)
    {
      Cells.add(new ControlledCell(5));
      lostWeight -=5;
    }
  }
  else if(mouseButton == RIGHT)
  {
    if (wide && mouseX > screen)
    {
      Cells.add(new AlgCell(3));
      lostWeight -=3;
    } else if (!wide && mouseY > screen)
    {
      Cells.add(new AlgCell(3));
      lostWeight -=3;
    }
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
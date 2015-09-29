class KochLine{
  PVector start;
  PVector end;
  color colour;
  
  KochLine(PVector start, PVector end){
    this.start = start.get();
    this.end = end.get();
    this.colour = 0;
   // this.colour = colours[(int)random(1,4)];
  }
  
  void display(){
    stroke(colour);
    line(start.x, start.y, end.x, end.y);
  }

  PVector kochB() {
      PVector v = PVector.sub(end, start);
      v.div(3);
      v.add(start);
      return v;
  }
   
  PVector kochD() {
      PVector v = PVector.sub(end, start);
      v.mult(2/3.0);
      v.add(start);
      return v;
  }
  
   PVector kochC() {
     PVector a = start.get();
     PVector v = PVector.sub(end, start);

     v.div(3);
     a.add(v);
     v.rotate(-radians(60));
     a.add(v);
 
     return a;
  }
}

void generate() {
  ArrayList next = new ArrayList<KochLine>();
  for (KochLine l : lines) {
   // l.display();
    PVector a = l.start.get();
    PVector b = l.kochB();
    PVector c = l.kochC();
    PVector d = l.kochD();
    PVector e = l.end.get();
 
    next.add(new KochLine(a, b));
    next.add(new KochLine(b, c));
    next.add(new KochLine(c, d));
    next.add(new KochLine(d, e));
  }
  lines = next;
}

color[] colours = {color(145,203,180), color(254,250,151), color(199,220,221), color(245,245,245), color(255,148,127)};
ArrayList<KochLine> lines;
color colour = colours[(int)random(1,5)];

void setup() {
  size(600, 600);
  background(colours[0]);
  lines = new ArrayList<KochLine>();

  minX = width/4;
  maxX = 3*width/4;
  minY = height/4;
  maxY = 3*height/4;
  
  for(int i = 10; i > 2; i--){
  
    colour = colours[i%4 + 1];
    getKoch(width/i, height/i, (i-1)*width/i, (i-1)*height/i);
  }

}

float minX;
float maxX;
float minY;
float maxY;

void drawKoch(){

  fill(colour);
  noStroke();
  
  beginShape();
    for (KochLine line : lines){
      //line.display();
      vertex(line.start.get().x, line.start.get().y);
      vertex(line.end.get().x, line.end.get().y);
  }
  endShape(CLOSE);

}

void getKoch(float minX, float minY, float maxX, float maxY){
  
   lines = new ArrayList<KochLine>();
  
  PVector start = new PVector(minX, minY);
  PVector end = new PVector(maxX, minY);
  lines.add(new KochLine(start, end));

  start = new PVector(maxX, minY);
  end = new PVector(maxX, maxY);
  lines.add(new KochLine(start, end));

  start = new PVector(maxX, maxY);
  end = new PVector(minX, maxY);
  lines.add(new KochLine(start, end));
  
  start  = new PVector(minX, maxY);
  end = new PVector(minX, minY);
  lines.add(new KochLine(start, end));
  
  for (int i = 0; i < 5; i++) {
    generate();
  }
  drawKoch();  
}

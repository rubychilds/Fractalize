int colour = 0;
int iterations = 7;
color[] colours = {color(145,203,180), color(254,250,151), color(199,220,221), color(245,245,245), color(255,148,127)};


void setup() {
  size(500, 500);
  
  float minX = 0;
  float maxX = width;
  float minY = 0;
  float maxY = height;
  
  background(colours[colour]);
  noStroke();
  
  int noRows = 2;
  int noCols = 4;
  
  for (int x_mult = 0; x_mult <= noCols; x_mult++){
    for(int y_mult = 0; y_mult < noRows; y_mult++){
        sierpinskiTriangle(minX + (x_mult-1)*(maxX-minX)/noCols, minY + y_mult*(maxY-minY)/noRows, minX + (x_mult+1)*(maxX-minX)/noCols, minY + (y_mult + 1)*(maxY-minY)/noRows);    
    }
  }
  
  saveFrame("siepinski_triangle_pattern.png");
}

void sierpinskiTriangle(float minX, float minY, float maxX, float maxY){
  beginShape();
    draw_triangle(minX + (maxX-minX)/4 , minY, minX + 3*(maxX-minX)/4, minY + (maxY -minY)/2, iterations, colour);
    draw_triangle(minX, minY + (maxY -minY)/2, minX + (maxX-minX)/2, maxY, iterations, colour);
    draw_triangle(minX + (maxX-minX)/2, minY + (maxY -minY)/2, maxX, maxY, iterations, colour); 
  endShape();
}

void draw_triangle(float minX, float minY, float maxX, float maxY , int count, int colour){
  colour++;

  if(count < 1){
    return;
  }
  count--;

  fill(colours[colour]);

  triangle(minX + 0*(maxX - minX)/4, maxY, minX + 1*(maxX - minX)/4, minY + (maxY - minY)/2,  minX + 2*(maxX - minX)/4, maxY);  
  triangle(minX + 1*(maxX - minX)/4, minY + (maxY - minY)/2, minX + 2*(maxX - minX)/4, minY, minX + 3*(maxX - minX)/4, minY + (maxY- minY)/2);
  triangle(minX + 2*(maxX - minX)/4, maxY, minX + 3*(maxX - minX)/4, minY + (maxY - minY)/2, minX + 4*(maxX - minX)/4, maxY);
  
  draw_triangle(minX + 0*(maxX - minX)/4, minY + (maxY - minY)/2, minX + 2*(maxX - minX)/4, maxY, count, colour%4);
  draw_triangle(minX + 1*(maxX - minX)/4, minY, minX + 3*(maxX - minX)/4, minY + (maxY- minY)/2, count, colour%4);
  draw_triangle(minX + 2*(maxX - minX)/4, minY + (maxY - minY)/2 , minX + 4*(maxX - minX)/4, maxY, count, colour%4);
}


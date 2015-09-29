float normalised_x;
float normalised_y;

void setup(){
  size(600, 600);
}

  int maxT = 255;
  float xa = -1.8;
  float xb = 1.8;
  float ya = -1.5;
  float yb = 1.5;
  float cReal = 0.3;
  float cImg = 0.25;
  float cDeduction = -0.05;
  
 Complex c = new Complex(cReal * (xb - xa) + xa, cImg * (yb - ya) + ya);

void draw(){

  loadPixels();
  for(int x = 0; x < width; x++ ){
    normalised_x = x * (xb - xa) / (width- 1)  + xa;
    for(int y = 0; y < height; y++){
      normalised_y = y * (yb - ya) / (height - 1)  + ya;
      Complex z = new Complex(normalised_x, normalised_y);
      int final_it = maxT;
      
      for(int it = 0; it < maxT; it++){
        if(z.absolute() > 2.0){
          final_it = it;
          break;
        }
        z = z.multi(z);
        z = z.add(c);
      }
      pixels[x+ width*y] = find_colour(final_it);
    }
  }
  updatePixels();
  
  //cReal += cDeduction;
  //cImg += -cDeduction;
  //if(cReal < -1.7 || cImg > 1.7 || cReal > 1.7 || cImg < -1.7){
  // cDeduction = -cDeduction;
  //}
  //c = new Complex(cReal * (xb - xa) + xa, cImg * (yb - ya) + ya);

}




class Complex {
    float real;   // the real part
    float img;   // the imaginary part

    Complex(float real, float img) {
      this.real = real;
      this.img = img;
    }

    Complex multi(Complex b) {
      float real = this.real * b.real - this.img * b.img;
      float img = this.real * b.img + this.img * b.real;
      return new Complex(real, img);
    }
    
    float absolute(){
      return sqrt(this.real*this.real + this.img*this.img);
    }
    
    Complex add(Complex b){
      return new Complex(this.real + b.real, this.img + b.img);
    }
}

color find_colour(int initial_point){
  color[] colours = {color(145,203,180), color(254,250,151), color(199,220,221), color(245,245,245), color(255,148,127)};
  return colours[initial_point % 5];
}
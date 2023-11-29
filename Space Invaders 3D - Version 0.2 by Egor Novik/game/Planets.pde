float G = 6.674e-11; // Гравитационная постоянная
import peasy.*;
//PeasyCam cam;
class Planet {
  float x, y, z;
  float r;
  float distance;
  float orbitalPeriod;
  float angle = 0; 
  float massOfStar;
  float eccentricity;
  float[] pointsX = new float[3600];
  float[] pointsY = new float[3600];
  float posX;
  float posY;
  PImage img;
  PShape shape1;
  Planet(float distance, float radius, float period, float massofstar,PImage texture, PShape shape) {
    this.distance = distance*1e-9;
    this.r = radius*1e-9;
    this.orbitalPeriod = period;
    this.massOfStar=massofstar;
    calc_ecc();
    orbit_calc();
    shape1=shape;
    img=texture;
    //shape1.scale(this.r*scaler);
    
    //shape1.rotateX(PI/2);
  }             
  void display(boolean isOnPause) {
    if(!isOnPause){
    angle += TWO_PI / (2*(orbitalPeriod/(24*3600)));
  }
    float currentDistance =distance/ (1 - eccentricity) * (1 - eccentricity * eccentricity) / (1 - eccentricity * cos(angle));
    this.posX = currentDistance * cos(angle);
    this.posY = currentDistance * sin(angle);

    pushMatrix();
    
    translate(posX, posY, 0);
    beginShape(); 
    texture(img);
      //sphere(r*scaler);
      shape(shape1);
      shape1.rotateZ(PI / 128); // Для вращения планеты вокруг своей оси 
      endShape();
    //noStroke();
    //fill(255);
    //sphereDetail(int(sqrt(camZ*camZ+posX*posX+posY*posY))/4);
    popMatrix(); 

  }
  void calc_ecc(){
    float a =pow((G * massOfStar * pow(orbitalPeriod, 2)) / (4 * PI * PI), 1.0 / 3);
    float e = 1 - (distance*1e9 / a);
    this.eccentricity = e;
  }
 
  void orbit_calc(){
    float angle1 =0;
    for (int i = 0; i <3600; i++) {
      angle1+= TWO_PI /3600.;
      float currentDistance = distance/ (1 - eccentricity) * (1 - eccentricity * eccentricity) / (1 - eccentricity * cos(angle1));
      pointsX[i] = currentDistance * cos(angle1);
      pointsY[i] = currentDistance * sin(angle1);
    }
  }
  void orbit() {
    noFill();
    stroke(100);
    beginShape();
    for (int i = 0; i < pointsX.length; i++) {
      vertex(pointsX[i], pointsY[i]);
    }
    endShape(CLOSE);
  }
  boolean isClicked(float mouseX, float mouseY,float fov,float camZ,int ind) { 
    float Zsh=resolutionX/2/tan(fov/2);
    float scale=1/((camZ/Zsh)*2.42);
    float distanceToMouse =sqrt(pow(((mouseX-width/2))/scale-posX,2)+pow(((mouseY-height/2))/scale-posY,2));
    return (distanceToMouse < r*scaler*PI);
  }
}

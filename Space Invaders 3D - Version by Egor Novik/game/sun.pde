
class Sun {
  float radius;
  float mass;
  Sun(float radius,float m) {
    this.radius = radius*1e-9*scaler;
    this.mass=m;
  }

  void display() {
    noStroke();
    fill(255, 255, 0);
    sphere(radius);
    noFill();
  }
}

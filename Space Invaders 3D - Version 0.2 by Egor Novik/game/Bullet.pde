class Bullet {
  float x, y, z;
  float speed = 5;
  boolean isEnemyBullet = false; // новая переменная для отличия вражеских пуль
  float damage; 
  Bullet(float x, float y, float z,float dmg) {
    this.x = x;
    this.y = y;
    this.z = z;
    this.damage=dmg;
  }
  
  void display() {
    if (isEnemyBullet) {
      fill(255, 0, 0); // вражеские пули красного цвета
    } else {
      fill(255, 255, 255);
    }
    pushMatrix();
    translate(x, y, z);
    box(5);
    popMatrix();
  }
  
  void update() {
    if (isEnemyBullet) {
      z += speed; // вражеские пули летят вперёд
    } else {
      z -= speed;
    }
  }
  
  boolean isOffscreen() {
    return z < -1500 || z > 600; // проверка выхода за пределы экрана для вражеских пуль
  }
}

class Enemy {
  float x, y, z;
  float speed = 0.4; // Увеличиваем скорость, чтобы враги двигались быстрее
  float size; // Уменьшаем размер врагов
  float bulletSpeed = 5;
  float hp;
  int type;
  PImage img ;
  PShape shape1;
  float shootspeed;
  Enemy(float x, float y, float z,float hp,int type,float size,PImage texture, PShape shape) {
    this.x = x;
    this.y = y;
    this.z = z;
    this.hp=hp;
    this.type=type;
    this.size=size;
    this.shootspeed=int(random(100,200));
    this.img = texture;
    this.shape1=shape;
    
  }
  
  void display() {
    fill(255, 0, 0);
    pushMatrix();
    translate(x, y, z);
    //box(size);
    beginShape();
      texture(img);
      shape(shape1);
      endShape();
    popMatrix();
  }
  
  void update() {
    z += speed/float(type);
  }
  
  void shoot(float targetX, float targetY) {
    if (frameCount % shootspeed == 0) {
      float angle = atan2(targetY - y, targetX - x);
      float bulletX = x + cos(angle) * size / 2;
      float bulletY = y + sin(angle) * size / 2;
      float bulletZ = z;
      Bullet newBullet = new Bullet(bulletX, bulletY, bulletZ,type*10);
      newBullet.isEnemyBullet = true;
      player.bullets.add(newBullet);
    }
  }
  
  boolean isHit(Bullet bullet) {
    float distance = dist(bullet.x, bullet.y, bullet.z, x, y, z);
    return distance < size / 2;
  }
  
  boolean isOffscreen() {
    return z > 500; // враги удаляются при приближении к камере
  }
  boolean IsDead(Bullet bullet){
    if(isHit(bullet)){
    hp-=bullet.damage;
    }
    if(hp<=0){
      return boolean(1);
      }else{
    return boolean(0);
    }
  }
}

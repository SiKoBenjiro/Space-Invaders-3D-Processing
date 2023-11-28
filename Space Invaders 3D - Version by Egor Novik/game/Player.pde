class Player {
  float x, y, z;
  ArrayList<Bullet> bullets;
  float hp;
  float damage;
  float size;
  PImage img;
  PShape shape1;
      
  Player(float hp,float damage,float size,PImage texture, PShape shape) {
    this.hp=hp;
    this.damage=damage;
    bullets = new ArrayList<Bullet>();
    this.size=size;
    this.img = texture;
    this.shape1=shape;
    
  }
  
  void setPosition(float x, float y, float z) {
    this.x = x;
    this.y = y;
    this.z = z;

    
  }
  
  void display() {
    if (player != null) {
      fill(0, 0, 255);
      pushMatrix();
      translate(x, y, z);
      beginShape();
      texture(img);
      shape(shape1); 
      endShape();
      //box(size);
      popMatrix();
      
      for (int i = bullets.size() - 1; i >= 0; i--) {
        Bullet bullet = bullets.get(i);
        bullet.display();
        bullet.update();
        if (bullet.isOffscreen()) {
          bullets.remove(i);
        }
      }
    }
  }
  
  void shoot() {
    if (player != null) {
      bullets.add(new Bullet(x, y, z,damage));
    }
  }
  
  void update() {
    if (player != null) {
      float speed = 5;
      if (!gameOver) {
      if (leftPressed && !rightPressed) {
        x -= speed;
      } else if (rightPressed && !leftPressed) {
        x += speed;
      }
      
      if (upPressed && !downPressed) {
        y -= speed;
      } else if (downPressed && !upPressed) {
        y += speed;
      }
      
      if (key == ' ' && !isShooting) { 
        isShooting = true;
        player.shoot();
      }
    }
    //println(player.x," ",player.y);
    this.x = constrain(x, -width*(1/2.), width*(1/2.));
    this.y = constrain(y, -height*(1/2.), height*(1/2.));
  }
}

  // Проверка столкновения пули врага с игроком
  boolean isHit(Bullet bullet) {
    float distance = dist(bullet.x, bullet.y, bullet.z, x, y, z);
    return distance < size/2; // Предполагаем радиус столкновения с игроком
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

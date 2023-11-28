//the game was fully made by Egor Novik 
void setup() {
  lvlcomplete=loadImage("screens/lvlcompl.png");
  wasted=loadImage("screens/wasted.png");
  textureplayer=loadImage("ships/ship1.jpg");
  shapeplayer=loadShape("ships/ship1.obj");
  textureEnemy=loadImage("ships/ship2.jpg");
  shapeEnemy=loadShape("ships/ship2.obj");
  shapeplayer.scale(4);
  shapeplayer.rotateX(PI);
  shapeEnemy.scale(3);
  planet0=loadImage("planets/planet0.jpg");
  planet1=loadImage("planets/planet1.jpg");
  planet2=loadImage("planets/planet2.jpg");
  planet3=loadImage("planets/planet3.jpg");
  planet4=loadImage("planets/planet4.jpg");
  planet5=loadImage("planets/planet5.png");
  planet00=loadShape("planets/sphere.obj");
  planet01=loadShape("planets/sphere.obj");
  planet02=loadShape("planets/sphere.obj");
  planet03=loadShape("planets/sphere.obj");
  planet04=loadShape("planets/sphere.obj");
  planet05=loadShape("planets/sphere.obj");
  starsphere=loadShape("planets/sphere.obj");
  starsphere1=loadShape("planets/sphere.obj");
  starsphere1.scale(10000);
  starsphere.scale(10000);
  stars=loadImage("stars/star4.jpg");
  stars1=loadImage("stars/star5.jpg");
  starsphere.setTexture(stars);
  starsphere1.setTexture(stars1); 
  size(1800, 800, P3D);
  setupSolarSystem();
  translate(width/2, height/2);
  cam = new PeasyCam(this, camZ);
  perspective(fov, float(width)/float(height), camZ/100.0, camZ*100.0);
  camera(camX, camY, camZ, camX, camY, 0, -1, 5, 0);
}

void draw() {
  
  if (!inArcadeMode) {
    drawSolarSystem(isOnPause, cammode);
    
  } else {
    drawArcadeGame(planetClicked);
    
  }
}

void keyPressed() {
  if (!inArcadeMode) {
    if (key == 'U'|| key == 'u') {
    paused = !paused;
    if (paused) {
      isOnPause=true;
    } else {
      isOnPause=false;
    }
  }
  if (key == '1') {
      cammode=1;
      //println(cammode);
    }
  if (key == '2') {
      cammode=2;
      //println(cammode);
  }
    if (key == 'g') {
      camZ=constrain(camZ,0,2700);
      camZ+=100;
    }
    if (key == 'f') {
       camZ=constrain(camZ,0,2700);
      camZ-=100;  
    }
  
  
  } else {
    
  if (!gameOver) {
    if (keyCode == LEFT) {
    leftPressed = true;
  } else if (keyCode == RIGHT) {
    rightPressed = true;
  } else if (keyCode == UP) {
    upPressed = true;
  } else if (keyCode == DOWN) {
    downPressed = true;
  }
  }

  }
}
void keyReleased() {
  if (inArcadeMode) {
  if (keyCode == LEFT) {
    leftPressed = false;
  } else if (keyCode == RIGHT) {
    rightPressed = false;
  } else if (keyCode == UP) {
    upPressed = false;
  } else if (keyCode == DOWN) {
    downPressed = false;
  }
  if (key == ' ') {
    isShooting = false; // При отпускании клавиши выстрела сбрасываем состояние
  }
}
}

void drawSolarSystem(boolean isOnPause, int mode) {
  if(mode==1){
    cam.setActive(true);
    background(0);
    beginShape();
    shape(starsphere);
    endShape();

    
  ambientLight(100, 100, 100, 0, 0, 0);
  pointLight(253, 253, 0, 0, 0, 0);

  sun.display();
   for (int i = 0; i < planets.length; i++) {
    pushMatrix();
    planets[i].orbit();
    planets[i].display(isOnPause);
    popMatrix();
  }  
  }  
  if(mode==2){
    //camX=0;
    //camY=0;
   cam.setActive(false);
  background(0);
  beginShape();
    shape(starsphere);
  endShape();
  ambientLight(100, 100, 100, 0, 0, 0);
  pointLight(253, 253, 3, 0, 0, 0);

  sun.display();
   for (int i = 0; i < planets.length; i++) {
    pushMatrix();
    planets[i].orbit();
    planets[i].display(isOnPause);
    popMatrix();
    if (mousePressed && planets[i].isClicked(mouseX, mouseY,fov,camZ,i)) {
      planetClicked=i;
      //startArcadeGame(planetClicked);
      //println("Clicked on planet " + planetClicked);
      //flymode=true;
      if(enemiesOnPlanets[planetClicked]==true){
      loading=true;
      }else {
      //println("На этой планете все враги уже уничтожены!");
      }
      break;
    }
  }
  camera(camX,camY,camZ,
          camX,camY,0,
         -1,100,0);
         //if(flymode==true){
         //mode=3;
         //counter++;
         //if(counter==1){
         ////camX=planets[planetSelected].posX;
         ////camY=planets[planetSelected].posY;
         ////camZ=planets[planetSelected].r*scaler;
         ////planetSelected=planetClicked;
         //  }
         //}
         if(loading==true){
         mode=4;
         }
  
  }
  if(mode==4){
  
    //println(mode+"   "+random(1,2));
    cam.setActive(false);
    background(0);
    beginShape();
    shape(starsphere1);
    endShape();
    PImage lvl;
    lvl=loadImage("levelloadingscreen/level"+planetClicked+".jpg");
    pushMatrix();
    camZ=250;
    beginShape();
    noStroke();
    texture(lvl);
    vertex(-200, -100, 0, 0,   0);
    vertex( 200, -100, 0, 820, 0);
    vertex( 200,  100, 0, 820, 400);
    vertex(-200,  100, 0, 0,   400);
    endShape();
    popMatrix();
    counter+=1;
    if(counter==150){
    mode=2;
    loading=false;
    startArcadeGame(planetClicked);
    counter=0;    
  }
  
  }
//  if (mode==3){//красиво не выглядит+считает немного не верно
//    float signX=planets[planetClicked].posX/abs(planets[planetClicked].posX);
//    //println(signX);
//    float signY=planets[planetClicked].posY/abs(planets[planetClicked].posY);
//    //println(signY);
//     camera(camX,camY,planets[planetClicked].r*scaler+10,
//          planets[planetClicked].posX-signX*planets[planetClicked].r*scaler,planets[planetClicked].posY-signY*planets[planetClicked].r*scaler,planets[planetClicked].r*scaler+10,
//         -1,0,0);
//    cam.setActive(false);
//  background(0);
//  ambientLight(100, 100, 100, 0, 0, 0);
//  pointLight(253, 253, 3, 0, 0, 0);

//  sun.display();
//   for (int i = 0; i < planets.length; i++) {
//    pushMatrix();
//    planets[i].orbit();
//    planets[i].display(isOnPause);
//    popMatrix();
//  }
//    if(flymode==true){
  
//  if(planets!=null){
//    float dobX=planets[planetClicked].r*scaler;//*planets[planetClicked].posX/abs(planets[planetClicked].posX)
//    float dobY=planets[planetClicked].r*scaler;//*planets[planetClicked].posY/abs(planets[planetClicked].posY)
//    println("posX "+(planets[planetClicked].posX-signX*dobX));
//    println("posY "+(planets[planetClicked].posY-signY*dobY));
//    println("camX "+camX);
//    println("camY "+camY);
    
//    float vectorX = planets[planetClicked].posX-signX*dobX- camX;
//  float vectorY = planets[planetClicked].posY-signY*dobY - camY;
//    float speed = speedscaler[planetClicked]; 
//    float length = sqrt(vectorX * vectorX + vectorY * vectorY);
//    if(length<=planets[planetClicked].r*scaler){
//      flymode=false;
//      counter=0;
//      mode=2;
//      camX=camXini;
//      camY=camYini;
//      camZ=camZini;
//      startArcadeGame(planetClicked);
//    }
//    vectorX /= length;
//    vectorY /= length;
//  camX += vectorX * speed;
//  camY += vectorY * speed;
//  //println("length: "+length);
//}}}
 
  
  
  }

void setupSolarSystem(){
frameRate(60);
  sun = new Sun(695*1e6 / 40, 1.989e30); 
  planets = new Planet[6]; 
  // Реальные физические параметры планет: расстояние от Солнца в м, радиус, орбитальный период в с, масса звезды
  planets[0] = new Planet(46*1e9, 2439.5*1e3  , 88*24*3600,sun.mass,planet0,planet00); // Меркурий
  planets[0].shape1.scale(planets[0].r*scaler);
  planets[0].shape1.setTexture(planets[0].img);
  planets[0].shape1.rotateX(PI/2);
  planets[1] = new Planet(107.4*1e9, 6051.5*1e3, 225*24*3600, sun.mass,planet1,planet01); // Венера
    planets[1].shape1.scale(planets[1].r*scaler);
    planets[1].shape1.setTexture(planets[1].img);
  planets[1].shape1.rotateX(PI/2);
  planets[2] = new Planet(147*1e9, 6371*1e3 , 365*24*3600,sun.mass,planet2,planet02 ); // Земля
    planets[2].shape1.scale(planets[2].r*scaler);
    planets[2].shape1.setTexture(planets[2].img);
  planets[2].shape1.rotateX(PI/2);
  planets[3] = new Planet(206*1e9, 3390*1e3, 687*24*3600, sun.mass,planet3,planet03); // Марс
    planets[3].shape1.scale(planets[3].r*scaler);
    planets[3].shape1.setTexture(planets[3].img);
  planets[3].shape1.rotateX(PI/2);
  planets[4] = new Planet(740*1e9, 69911*1e3 , 4333*24*3600,sun.mass,planet4,planet04); // Юпитер
    planets[4].shape1.scale(planets[4].r*scaler);
    planets[4].shape1.setTexture(planets[4].img);
  planets[4].shape1.rotateX(PI/2);
  planets[5] = new Planet(1429*1e9, 58232*1e3, 10759*24*3600,sun.mass,planet5,planet05); // Сатурн
    planets[5].shape1.scale(planets[5].r*scaler);
    planets[5].shape1.setTexture(planets[5].img);
  planets[5].shape1.rotateX(PI/2);
}
void startArcadeGame(int planetIndex) {
  if (enemiesOnPlanets[planetIndex]==true) {
    inArcadeMode = true;
    setupArcadeGame(planetIndex); 
  } 
}

void setupArcadeGame(int planetIndex) {
 smooth();
 counter=0;
  player = new Player(10,10,20,textureplayer, shapeplayer);
  player.setPosition(width/4, height/4, 400);
  addenemies("enemies/enemies"+str(planetIndex)+".txt");
  //overlay = createGraphics(width, height);
}

void drawArcadeGame(int planetIndex) {
  background(0);
  float camtemp=camZ;
  camZ=1200;
  camera(0,0,camZ,
          0,0,0,
         -1,100,0);
  camZ=camtemp;
  beginShape();
    shape(starsphere1);
  endShape();
    player.display();
    player.update();
    for (int i = enemies.size() - 1; i >= 0; i--) {
      Enemy enemy = enemies.get(i);
      enemy.display();
      enemy.update();
      enemy.shoot(player.x, player.y);

      for (int j = player.bullets.size() - 1; j >= 0; j--) {
        if (!player.bullets.get(j).isEnemyBullet && enemy.IsDead(player.bullets.get(j))) {
          enemies.remove(i);
          player.bullets.remove(j);
          break;
        }
      }
      if (enemy.isOffscreen()) {
        enemies.remove(i);
        gameOver = true;
        break;
        }
      }     
    for (int i = player.bullets.size() - 1; i >= 0; i--) {
      Bullet bullet = player.bullets.get(i);
      if (bullet.isEnemyBullet && player.IsDead(bullet)) {
        gameOver = true;
        break;
      }
    }
    
    if (key == 'r' &&gameOver) {
      restartGame("enemies/enemies"+str(planetIndex)+".txt");
    }
    if (key == 'R'&&gameOver) {
      restartGame("enemies/enemies"+str(planetIndex)+".txt");
    }
  //overlay.beginDraw();
  //overlay.background(0, 0); // Прозрачный фон текста
  //overlay.fill(255);
  //overlay.textAlign(CENTER);
  //overlay.textSize(32);
  if (!gameOver) {
    
    if (enemies.size() == 0) {
      //overlay.text("Stage Completed", width / 2, height / 2);
      pushMatrix();
    //translate(width / 2, height / 2);
    //rotateZ(PI/16);
    //camZ=250;
    beginShape();
    noStroke();
    texture(lvlcomplete);
    vertex(-300, -200, 0, 0,   0);
    vertex( 500, -200, 0, 1024, 0);
    vertex( 500,  -50, 0, 1024, 147);
    vertex(-300,  -50, 0, 0,   147);
    endShape();
    popMatrix();
    }
  } else {
    pushMatrix();
    translate(width,height);
    //overlay.text("Вы проиграли. Нажмите 'R' для перезапуска", width/2, height/2);
    popMatrix();
    pushMatrix();
    //translate(width / 2, height / 2);
    //rotateZ(PI/16);
    //camZ=250;
  beginShape();
  texture(wasted);
  noStroke();
  vertex(-200, -200, 0, 0,   0);
  vertex( 400, -200, 0, 1024, 0);
  vertex( 400,  200, 0, 1024, 298);
  vertex(-200,  200, 0, 0,   298);
  endShape();
    popMatrix();
  }
  //overlay.endDraw();
  //image(overlay, 0, 0);
  if(enemies.size()==0&&!gameOver){
    counter+=1;
     }
  if(counter==300){
  inArcadeMode=false;
   enemiesOnPlanets[planetIndex]=false;
   counter=0;
   leftPressed = false;
   rightPressed = false;  
   upPressed = false;
   downPressed = false;
  }
}

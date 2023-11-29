boolean[] enemiesOnPlanets = {true, true, true, true, true, true}; // Состояние врагов на каждой планете
import peasy.*;
PeasyCam cam;
int resolutionX = 1800;
int resolutionY = 800;
float fov = PI / 3.0;
float camX = 0, camY = 0, camZ = 250; 
float camXini=0,camYini=0,camZini=250;
PGraphics overlay;
float scaler = 1000; // cкалируем, чтобы видеть, солнце дополнительно уменьшено в 40 раз, а то норм не рисует, убрать скейл- ничего не будет видно
Sun sun;
Planet[] planets;
int planetClicked=2;
boolean paused = false;
boolean isClicked = false;
boolean isOnPause = true;
boolean inArcadeMode = false;
boolean isShooting = false;
int counter=0;
int cammode=2;
float[] speedscaler={4,3.2,3,2.3,2,2};//было нужно для полёта
boolean flymode=false;
boolean loading=false;
PImage lvlcomplete;
PImage wasted;
PImage textureplayer;
PShape shapeplayer;
PImage textureEnemy;
PShape shapeEnemy;
PShape planet00,planet01,planet02,planet03,planet04,planet05;
PImage planet0,planet1,planet2,planet3,planet4,planet5;
PShape starsphere,starsphere1;
PImage stars,stars1;

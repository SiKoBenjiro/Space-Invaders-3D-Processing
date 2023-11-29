Player player;
boolean leftPressed, rightPressed, upPressed, downPressed;
boolean gameOver = false;
String[] lines; // Массив строк для хранения данных из файла
ArrayList<Enemy> enemies = new ArrayList<Enemy>(); // Список для хранения объектов врагов

void addenemies(String filename){
lines = loadStrings(filename); // Загрузка данных из файла

  for (int i = 0; i < lines.length; i++) {
    String[] values =split(lines[i], ' '); // Разделение строки на значения

    for (int j = 0; j < values.length; j++) {
        float x = j * width/values.length -width/2.; // Вычисление x координаты   
        float y = i * height/values.length -height/2.; // Вычисление y координаты
      if (values[j].equals("1")) { // Создание врага, если в матрице есть "1" 
        enemies.add(new Enemy(x,y,-1500,10,1,50,textureEnemy,shapeEnemy)); // Создание врага на основе координат и добавление в список
      }
    }
  }
} 




void restartGame(String filename) {
  player = new Player(10,10,20,textureplayer,shapeplayer);
  player.setPosition(width/4, height/4, 400);
  leftPressed = rightPressed = upPressed = downPressed = false; // Сброс направлений движения
  enemies.clear();
  addenemies(filename);
  gameOver = false;
}

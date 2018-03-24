class cFood {
  PVector position = new PVector();
  PVector tmpPosition = new PVector();
  boolean tmpPositionError = true;

  void create(PVector[] tmpSnakeBody){ //creates new food outside Snakebody
    while (tmpPositionError == true) {
      tmpPositionError = false; //reset to standard value
      tmpPosition = Game.randomPosition(); //recieve new random position  
      for (int i = 0; i < tmpSnakeBody.length; i++) { //compare tmpSnakeBody to tmpPosition
        if (tmpSnakeBody[i].x == tmpPosition.x && tmpSnakeBody[i].y == tmpPosition.y) {
          tmpPositionError = true; //position schon vergeben, neues Random beziehen und vergleich von vorn starten
        }
      }
    }
    position = tmpPosition;
    tmpPositionError = true; //forces while-loop execution (ugly...)  
  }
  
  void show(){
    fill(85, 255, 255);
    ellipseMode(CORNER);
    ellipse(position.x, position.y, rasterSize, rasterSize);
  }
  
}
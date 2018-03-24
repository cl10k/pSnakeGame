class cSnake {
  
  PVector speed = new PVector(0, 0);
  PVector[] body = new PVector[1];
  int total = 0;
  boolean alive = true;
  void create() {
    body[0] = Game.randomPosition();
  }
  
  void readInput(int tmpKeyCode) {

    switch (tmpKeyCode)
      {
      case UP: //NORTH
        if (body.length == 1 || speed.y != 1) { //don't allow reversing unless Snake.length = 1 
          speed.y = -1;
          speed.x = 0;  
        }
        break;
      case RIGHT: //EAST
        if (body.length == 1 || speed.x != -1) { //don't allow reversing unless Snake.length = 1 
          speed.x = +1;
          speed.y = 0;
        }
        break;
      case DOWN: //SOUTH
        if (body.length == 1 || speed.y != -1) { //don't allow reversing unless Snake.length = 1 
          speed.y = +1;
          speed.x = 0;  
        }
        break;
      case LEFT: //WEST
        if (body.length == 1 || speed.x != 1) { //don't allow reversing unless Snake.length = 1 
          speed.x = -1;
          speed.y = 0;
        }
        break;
      default:
        break;
      }
  }
  
  void update() {
    for (int i = body.length-1; i > 0; i--) {
       body[i].x = body[i-1].x;
       body[i].y = body[i-1].y;
       }

    body[0].x = body[0].x + speed.x * rasterSize;
    body[0].y = body[0].y + speed.y * rasterSize;
  }
  
  void show() {
    int tmpColor;
    if (alive) {
        tmpColor = 42; //yellow
    } else{
      tmpColor = 0; //red
    }

    int drawStep = 255/body.length;
    for (int i = 0; i < body.length; i++) {
        fill(tmpColor, (body.length-i)*drawStep, 255);
        rect(body[i].x, body[i].y, rasterSize, rasterSize);
      }
  }
  
  void eat() {
    PVector tmpNewPosition = new PVector(body[0].x, body[0].y);
    body = (PVector[]) append(body, tmpNewPosition);
  }

  boolean checkSelfCollision() {
    boolean tmpBoolean = false;
    if (body.length > 4) { //snakes smaller than 5 segments can't selfcollide
      for (int i = 4; i < body.length; i++) {
        if (body[0].x == body[i].x && body[0].y == body[i].y) {
          tmpBoolean = true;
        }
      }
    }
  
    return tmpBoolean;
  }

  void death(){
    alive = false;
    show();
  }
}
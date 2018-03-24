//general refactoring esp. all for-loops to a common style
//set private/public modifiers in all classes
//documentation of all elements

//Title- & EndScreen
  //add selector for difficulty in Titlescreen (easy, medium, hard, time)
  //press space to start in titlescreen

//Score
  //Length of Snake & Time & steps taken
  //count the steps taken, less steps = better score
  //difficulty influences gameSpeed and Score via a multiplicator 

//timechallenge (difficulty=3)
  //your timer is a mess! refactor it

cGame Game;
cSound Sound;
cSnake Snake;
cFood Food;


int rasterSize = 20;
int gameSpeed = 7; //=frameRate, works ok between 5-15
int score;
int difficulty = 3; //0=easy, 1=medium, 2=hard,3=timechallenge
boolean debugMode = true;
PFont customFontScreen;
PFont customFontTimer;


void setup() {
  size(800, 600);
  colorMode(HSB);
  frameRate(gameSpeed);
  
  customFontTimer = createFont("/Resources/Graph-35-pix.ttf", 256);
  customFontScreen = createFont("/Resources/Graph-35-pix.ttf", 32);

  Game = new cGame();
  Sound = new cSound();
  Snake = new cSnake();
  Food = new cFood();
  Game.loadImages();  
  Snake.create();
  Food.create(Snake.body);
  Game.resetTimer(); //maybe move to a gamestart function later, right now it start at first draw, but it should start at first movement
}


void draw() {
  if(Snake.alive == false){ // I hate that if statement. See if you can solve the problem more elegandly
    Game.endScreen();
    Sound.endScreen();
  } else {
    Game.drawCanvas();
    Food.show();
  
    Snake.update();
    Snake.show();
    Sound.step();
  
    checkCollision(Snake.body[0]);
    checkFood(Snake.body[0],Food.position);
    checkTimer();
  }
}


void keyPressed() {  
   Snake.readInput(keyCode);
}

void mousePressed(){ //just for debugging purpose
  if (mouseButton==RIGHT) {
    Snake.eat();
  }
}

void checkFood(PVector tmpSnakePosition, PVector tmpFoodPosition) {
  if (tmpSnakePosition.x == tmpFoodPosition.x && tmpSnakePosition.y == tmpFoodPosition.y) {
	  Snake.eat();
    Sound.eat();
    if (difficulty == 3) {
      Game.resetTimer();
    }
    Food.create(Snake.body);
    Sound.createFood();
	}
}

void checkCollision(PVector tmpSnakePosition) {
  //Check collision with canvas boundary
  if (tmpSnakePosition.x < Game.arenaMinX || tmpSnakePosition.x > Game.arenaMaxX || tmpSnakePosition.y < Game.arenaMinY || tmpSnakePosition.y > Game.arenaMaxY) {
    Snake.death();
    Sound.boundaryCollision();
  }

  //Check collision of Snake with own body
  if (Snake.checkSelfCollision() == true) { 
    Snake.death();
    Sound.selfCollision();
  }
}

void checkTimer() {
  if (difficulty == 3) {
    if (Game.timerCountdown <= 0) {
      Snake.death();
      Sound.timeOut();
    }
  }
}

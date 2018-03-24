class cGame {
  PImage title;
  PImage end;
  int columns = int(width/rasterSize)-2;
  int rows = int(height/rasterSize)-2;
  int arenaMinX = rasterSize;
  int arenaMaxX = width -2*rasterSize;
  int arenaMinY = rasterSize;
  int arenaMaxY = height -2*rasterSize;
  int timerReference; //reference to when timer started its countdown
  int timerStep = 5; //initial value of timer, at gamestart initialised with 20sec, later by a calculation
  int timerCountdown; //progression of timer, at gamestart timer initialised with 20sec
  int timerDifficulty = 0; //used for progressing the timer to avoid a constant interval later on

  void drawCanvas() { //draws a colored border
    //außerdem noch einen farbigen Rand um das Spielfeld zeichnen. Das hat dann aber auswirkungen auf die restliche Spielfläche (create Food und SnakePos und Boundary Pos)
    fill(180, 255,255); 
    rect(0,0,width,height); //draw border
    fill(0);
    rect(arenaMinX,arenaMinY,arenaMaxX,arenaMaxY); //draw background

    if (difficulty == 3) {
      calcTimer();
      drawTimer();
    }
  }
  
  PVector arenaMin() { //hier ist eine funktion um die große des Spielfeldes zu erfragen als Pvector
    return new PVector(rasterSize, rasterSize);
  }

  PVector arenaMax() { //hier ist eine funktion um die große des Spielfeldes zu erfragen als Pvector
    return new PVector(width-2*rasterSize,height-2*rasterSize);
  }

  PVector randomPosition() {
    // oldVersion without Border: PVector tmpPosition = new PVector(int(random(1, (width / rasterSize))) * rasterSize, int(random(1, (height / rasterSize))) * rasterSize);
    PVector tmpPosition = new PVector(int(random(2, (width / rasterSize)-2)) * rasterSize, int(random(2, (height / rasterSize)-2)) * rasterSize);
    return tmpPosition;
  }

  void loadImages(){
    title = loadImage("Resources/TitleScreen.bmp");
    end = loadImage("Resources/EndScreen.bmp");
  }

  void titleScreen() {
    background(0);
    image(title, 0, 0, width, height);
  }
  
  void endScreen() {
    float timerStart = millis();
    float timerIntervall = 2000;
    
    while (millis() < timerStart+timerIntervall) {
      //waiting for the timer to run out
    }

    background(0);
    image(end, 0, 0, width, height);
    
    switch (difficulty)
      {
      case 0: //easy
        // calculate
        break;
      case 1: //medium
        // calculate
        break;
      case 2: //hard
        // calculate
        break;
      case 3: //timechallenge
        // calculate
        break;
      default:
        // zur Sicherheit falls etwas schief läuft
        break;
      }

      //calculate score -> score = length & number of steps (smaller is better) & difficulty as modifier
      //show score 
    textFont(customFontScreen);
    textAlign(CENTER, CENTER);
    fill(0, 0, 0); 
    text("YOUR SCORE : ", width*0.66, height/2);
      println("- GAME END -");
      noLoop();
  }

  void calcTimer(){
    int passedTime = millis()-timerReference;
    timerCountdown =  timerStep -passedTime/1000;
  }

  void resetTimer(){
    timerReference = millis();
    if (timerDifficulty > 0) {
      timerStep++; //replace with a more sophisticated version that takes game progression into account by evaluating timerDifficulty
    }
    timerDifficulty++;
  }

  void drawTimer(){
    textFont(customFontTimer);
    textAlign(CENTER, CENTER);
    fill(0, 32, 32);
    String tmpText = str(timerCountdown);
    if (timerCountdown <10) {
      tmpText = "0"+tmpText;
    }
    text(tmpText, width/2, height/2);
  }
}
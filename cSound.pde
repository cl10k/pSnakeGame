class cSound {
    int soundTestDelay = 10; //simulates the delay caused by sound (on Arduino there is no multithreading!)

  void step() {
    //abwechseln 2 verschiedene Stepsounds abspielen (dafür eine Variable bei jedem Schritt wechseln)
    delay(soundTestDelay); 
  }

  void eat() {
    background(85, 255, 64); //tmp, will be replace be a sound
    delay(soundTestDelay);
  }

  void createFood() {
    //sound für essen spawn abspielen
    delay(soundTestDelay);
  }

  void boundaryCollision() {
   //background(0, 255, 64); //replace by sound
   delay(soundTestDelay);
  }

  void selfCollision() {
    //background(0, 255, 64); //replace by sound
    delay(soundTestDelay);
  }
  void timeOut() {
    //background(0, 255, 64); //replace by sound
    delay(soundTestDelay);
  }
  
  
  void titleScreen() {
    //melodie für Startbildschirm abspielen
    delay(soundTestDelay);
  }

  void endScreen() {
    //melodie für Endbildschirm abspielen
    delay(soundTestDelay);
  }

}
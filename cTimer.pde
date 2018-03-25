//an event based timer
// relies on an ArrayList in mainsketch and the checkTimers() called from draw to update each timer in ArrayList
class cTimer extends Observable {
    int countdown; // total time to run
    int tickInterval; //time between ticks
    int tickStep; //keeps track of how many ticks have passed
    int timeReference; //time when timer started
    int passedTime;
    boolean timerRunning;
    String identifier; //maybe needed to identify object later on


    void initialise(String tmpIdentifier){
        identifier = tmpIdentifier;
        timerList.add(this);
    }

    void start(int tmpCountdown, int tmpNoTicks){
        //also resets a running timer
        println(identifier +" Start");
        timeReference = millis();
        countdown = tmpCountdown;
        tickInterval = tmpCountdown / tmpNoTicks;
        tickStep = 0;
        timerRunning = true;
    }

    boolean getStatus(){ //shows status of timer
        return timerRunning;
    }

    int getTime(){ //shows progession of timer
        if (timerRunning) {
            return countdown - passedTime;
        } else {
            return -1;
        }
        
    }

    void eTick(){ //raises Event
        println(identifier +" tick... " +tickStep);
        setChanged();
        notifyObservers();
        
    }

    void eFinished(){ //raises Event
        println(identifier +" finished");
        setChanged();
        notifyObservers();
        timerRunning = false;
    }

    void update(){
        if (timerRunning) { //only calculate while timer is still running
            passedTime = millis() - timeReference;
            
            if(passedTime >= countdown) {
                eTick();
                eFinished();
            }

            if(passedTime >= tickStep*tickInterval && timerRunning) {
                // nicht ticken bei 0!
                eTick();
                tickStep++;    
            }
        }
    }

    void remove(){
        timerList.remove(this);
    }
}
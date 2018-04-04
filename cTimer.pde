//A simple event based timer, utilising the Observer Pattern functionality provided by java.util
//Relies on a global timerList collecting all timer instances in a central place!

public class cTimer extends Observable {
    private int countdown; // total time to run
    private int passedTime; // time passed since timer started
    private int timeReference; //reference to when timer started
    private int tickStep; //countdown is divided into discrete steps  
    private int tickInterval; //time between ticks
    private boolean timerRunning; //timer status


    public cTimer() {
        timerList.add(this); //add timer to global timerList
    }


    public void start(int tmpCountdown, int tmpNoTicks) { //total time to run timer (in ms) and number of tick events to raise over total time
        timeReference = millis();
        countdown = tmpCountdown;
        tickInterval = tmpCountdown / tmpNoTicks;
        tickStep = 0;
        timerRunning = true;
        eStart();
    }


    public void reStart() { //restarts the timer with the parameters given in start
        timeReference = millis();
        tickStep = 0;
        timerRunning = true;
        eStart();
        eRestart();
    }


    public void cancel() { //aborts timer and raises eCancel event
        timerRunning = false;
        eCancel();
    }


    public void update() { //automatically called from draw via timerList to keep timer updated
    
        //(re)calculate timer
        if (timerRunning) { //only calculate while timer is (still) running
            passedTime = millis() - timeReference;
    
            //stop timer if time is over
            if (passedTime >= countdown) {
                eTick();
                eStop();
                timerRunning = false;
            }
    
            // raise eTick event
            if (timerRunning && passedTime >= tickStep*tickInterval) {
                if (tickStep > 0) { //don't tick at t=0
                eTick();
                }
                tickStep++;
            }
        }
    }

  
    public  int getTime() { //shows progession of timer in ms
        if (timerRunning) {
            return countdown - passedTime;
        } else {
            return -1;
        }
    }
  

    public  int getTick() { //shows progession of timer in Ticks
        if (timerRunning) {
            return tickStep;
        } else {
            return -1;
        }
    }


    public  Boolean getStatus() { //returns timerRunning
        return timerRunning;
    }


    private void eStart() { // raises Start Event
        setChanged();
        notifyObservers("start");
    }
  

    private void eRestart() { // raises Restart Event
        setChanged();
        notifyObservers("restart");
    }


    private void eStop() { // raises Stop Event
        setChanged();
        notifyObservers("stop");
    }


    private void eCancel() { // raises Cancel Event
        setChanged();
        notifyObservers("cancel");
    }

    private void eTick() { // raises Tick Event
        setChanged();
        notifyObservers("tick");
    }
}
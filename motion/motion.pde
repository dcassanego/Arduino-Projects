#define DEBUG false
#define TOLERANCE_TIME 100

#define NUMBUTTONS 0
#define NUMLEDS 1

#define STATECACHELENGTH 8

#define MAINBUTTON 22

#define MOTION 24

#define RED 26

double loopcount=0;
double lastEvalSecond=0;

//INPUTS and OUTPUTS
short LEDs[NUMLEDS] = {RED};
//short buttons[NUMBUTTONS] = {};

//RAW MODEL
//double buttonStateCache[NUMBUTTONS][STATECACHELENGTH] = {{0}};
//short buttonStateCacheIndex[NUMBUTTONS] = {0};
boolean motiondetected = false;


/////////////////////////////////
// Utilities
//
/*
int idtoindex(int id, short* array, int arrLen)
{
  for (int i=0; i<arrLen; i++)
  {
    if (id == array[i])
    {
      return i;
    }
  }
  
  return -1;
}

boolean buttonActive(int buttonId)
{
  int index = idtoindex(buttonId, buttons, NUMBUTTONS);
  return (buttonStateCacheIndex[index] % 2);
}

boolean buttonClickedOn(int buttonId)
{
  int index = idtoindex(buttonId, buttons, NUMBUTTONS);
  return ((buttonStateCacheIndex[index] % 4) == 2);
}
*/
//////////////////////////////////////
// Major Read Methods
//
void readInputs()
{
  if (digitalRead(MOTION) == HIGH)
  {
    motiondetected = true;
  }
  else
  {
    motiondetected = false;
  }
}

/////////////////////////////////////
// Major Eval Methods
//
void evalAll()
{
  if (motiondetected)
  {
    digitalWrite(RED, HIGH);
  }
  else
  {
    digitalWrite(RED, LOW);
  }
}

void evalSecond()
{
  
  
}

/////////////////////////////////////////
// Main Program
//
void setup()
{
  for (int i=0; i<NUMLEDS; i++)
  {
    pinMode(LEDs[i], OUTPUT);
  }

  //for (int i=0; i<NUMBUTTONS; i++)
  //{
  //  pinMode(buttons[i], INPUT);
  //}
  
  pinMode(MOTION, INPUT);
  
  if (DEBUG)
  {
    Serial.begin(9600);
  }
}

void loop()
{
  readInputs();
  
  evalAll();
  if (millis() > (lastEvalSecond + 1000))
  {
    evalSecond();
    lastEvalSecond = millis();
  }
    
  loopcount++;
}





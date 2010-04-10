#define DEBUG false
#define TOLERANCE_TIME 100

#define NUMBUTTONS 1
#define NUMLEDS 3

#define STATECACHELENGTH 8

#define MAINBUTTON 22

#define RED 26
#define GREEN 28
#define BLUE 30

double loopcount=0;
double lastEvalSecond=0;

//INPUTS and OUTPUTS
short LEDs[NUMLEDS] = {RED, GREEN, BLUE};
short buttons[NUMBUTTONS] = {MAINBUTTON};

//RAW MODEL
double buttonStateCache[NUMBUTTONS][STATECACHELENGTH] = {{0}};
short buttonStateCacheIndex[NUMBUTTONS] = {0};

//EVAL STATE
short lastIndex=0;
short lastOutput=0;

/////////////////////////////////
// Utilities
//
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

//////////////////////////////////////
// Major Read Methods
//
void readInputs()
{
  for (int i=0; i<NUMBUTTONS; i++)
  {
    boolean active = (digitalRead(buttons[i]) == HIGH);
    
    //determine if we have a state transition
    if ((buttonStateCacheIndex[i] % 2) != active)
    {
      //determine if we are beyond our tolerance
      if ((millis() - buttonStateCache[i][buttonStateCacheIndex[i]]) > TOLERANCE_TIME)
      {
        //save this value to the cache
        buttonStateCacheIndex[i]++;
        if (buttonStateCacheIndex[i] == STATECACHELENGTH)
        {
          buttonStateCacheIndex[i] = 0;
        }
        
        buttonStateCache[i][buttonStateCacheIndex[i]] = millis();
      }
    }
  }
}

/////////////////////////////////////
// Major Eval Methods
//
void evalAll()
{
  int buttonIndex = idtoindex(MAINBUTTON, buttons, NUMBUTTONS);
  
  if (!buttonActive(MAINBUTTON) && (lastIndex != buttonStateCacheIndex[buttonIndex]))
  { 
    if (lastOutput == 0)
    {
      digitalWrite(RED, HIGH);
      lastOutput = RED;
    }
    else if (lastOutput == RED)
    {
      digitalWrite(RED, LOW);
      digitalWrite(GREEN, HIGH);
      lastOutput = GREEN;
    }
    else if (lastOutput == GREEN)
    {
      digitalWrite(GREEN, LOW);
      digitalWrite(BLUE, HIGH);
      lastOutput = BLUE;
    }
    else if (lastOutput == BLUE)
    {
      digitalWrite(RED, HIGH);
      digitalWrite(GREEN, HIGH);
      digitalWrite(BLUE, HIGH);
      lastOutput = -1;
    }
    else
    {
      digitalWrite(RED, LOW);
      digitalWrite(GREEN, LOW);
      digitalWrite(BLUE, LOW);
      lastOutput = 0;
    }
    
    lastIndex = buttonStateCacheIndex[buttonIndex];
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

  for (int i=0; i<NUMBUTTONS; i++)
  {
    pinMode(buttons[i], INPUT);
  }
  
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





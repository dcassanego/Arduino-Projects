#define FORCE_PIN 0

#define RED 22
#define ORANGE 24
#define GREEN 26
#define YELLOW 28
#define BLUE 30

void setup()
{
  pinMode(RED, OUTPUT);
  pinMode(ORANGE, OUTPUT);
  pinMode(GREEN, OUTPUT);
  pinMode(YELLOW, OUTPUT);
  pinMode(BLUE, OUTPUT);
  Serial.begin(9600);
}

void loop()
{
  int seconds=0;
  
  seconds = millis()/1000;
  if (seconds > 0)
  {
    digitalWrite(BLUE, (seconds % 16) == 0);
    digitalWrite(YELLOW, ((seconds % 8) == 0) && !((seconds % 16) == 0));
    digitalWrite(GREEN, ((seconds % 4) == 0) && !((seconds % 8) == 0) && !((seconds % 16) == 0));
    digitalWrite(ORANGE, ((seconds % 2) == 0) && !((seconds % 4) == 0) && !((seconds % 8) == 0) && !((seconds % 16) == 0));    
    digitalWrite(RED, (seconds % 2) == 1);

  }
}

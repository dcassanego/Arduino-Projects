#include <math.h>

#define FORCE_PIN 0

#define RED 22
#define ORANGE 24
#define GREEN 26
#define YELLOW 28
#define BLUE 30

int minutes;
int hours;

int divideAndSetLED(int dividend, int LED)
{
  digitalWrite(LED, ((dividend%2)==1));
  return dividend / 2;
}

void showseconds(int second)
{
  int remainder=second;
  
  remainder = divideAndSetLED(remainder, BLUE);
  remainder = divideAndSetLED(remainder, YELLOW);
  remainder = divideAndSetLED(remainder, GREEN);
  remainder = divideAndSetLED(remainder, ORANGE);
  divideAndSetLED(remainder, RED);
}

void setup()
{
  minutes=0;
  hours=0;
  
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
  seconds = (millis()/1000) % 60;
  if ((millis() > 1000) && (seconds==0))
  {
    minutes++;
    if (minutes == 60)
    {
      minutes=0;
      hours++;
      if (hours==13)
      {
        hours=0;
      }
    }
  }
  
  showseconds(seconds);
}

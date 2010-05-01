#include <Servo.h>

Servo myservo;

//simple test of a basic servo
void setup()
{
  myservo.attach(26);
}

void loop()
{
  myservo.write(0);
  delay(1000);
  myservo.write(180);
  delay(1000);
}



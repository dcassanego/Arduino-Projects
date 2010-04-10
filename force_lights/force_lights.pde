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
  boolean vred=0, vorange=0, vgreen=0, vyellow=0, vblue=0;
  int reading = analogRead(FORCE_PIN);
  
  if (reading > 200) vred=true;
  if (reading > 450) vorange=true;
  if (reading > 650) vgreen=true;
  if (reading > 800) vyellow=true;
  if (reading > 900) vblue=true;
  
  digitalWrite(RED, vred ? HIGH : LOW);
  digitalWrite(ORANGE, vorange ? HIGH : LOW);
  digitalWrite(GREEN, vgreen ? HIGH : LOW);
  digitalWrite(YELLOW, vyellow ? HIGH : LOW);
  digitalWrite(BLUE, vblue ? HIGH : LOW);
}

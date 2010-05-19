#define THERM_PIN 0

//one second sample interval
#define SAMPLE_INTERVAL 1000

long lastSample = 0;

void setup()
{
  Serial.begin(9600);
}

void loop()
{
  if ((millis() - SAMPLE_INTERVAL) > lastSample)
  {
    Serial.println(analogRead(THERM_PIN));
    lastSample = millis();
  }
}

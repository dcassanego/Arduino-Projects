
void setup()
{
  pinMode(6, OUTPUT);
}

void loop(){
  digitalWrite(6, LOW);
  delay (400);
  digitalWrite(6, HIGH);   
  delay (200);

}

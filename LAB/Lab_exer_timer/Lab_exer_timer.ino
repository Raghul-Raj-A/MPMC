
 extern "C"
{
  void start();
  void work();
}
void setup() {
  //user-defined
  start();
}

void loop() {
  // user-defined
  work();
}
/*
const int LED_Pin = LED_BUILTIN;
void setup() 
{
  pinMode(LED_Pin, OUTPUT);
}

void loop() 
{
  digitalWrite(LED_Pin, LOW);
  delay(1000); 
  digitalWrite(LED_Pin, HIGH);
  delay(1000);
}
*/

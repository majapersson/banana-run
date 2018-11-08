int banana1 = 2;
int banana2 = 4;
int state1 = 0;
int state2 = 0;

void setup() {
  Serial.begin(9600);
}

void loop() {
  state1 = digitalRead(banana1);
  state2 = digitalRead(banana2);

  if(state1 == 0) {
    Serial.println("0");
  } 
    if(state2 == 0) {
    Serial.println("1");
  } 
  delay(20);
}

int input = 2;
int state = 0;

void setup() {
  Serial.begin(9600);
}

void loop() {
  state = digitalRead(input);
  Serial.println(state);
  delay(20);
}

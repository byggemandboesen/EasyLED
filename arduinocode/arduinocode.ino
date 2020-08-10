#define Red 11
#define Green 9
#define Blue 6

#include <SoftwareSerial.h>
int blue_TX = 0;
int blue_RX = 1;
SoftwareSerial bluetooth(blue_TX, blue_RX);

void setup() {
  Serial.begin(9600);
  bluetooth.begin(9600);
  pinMode(Red, OUTPUT);
  pinMode(Green, OUTPUT);
  pinMode(Blue, OUTPUT);
}

void loop() {
  unsigned int blue_data = bluetooth.read();
  
/*------------------------------------ON/OFF ALL COLORS---------------------------------------*/
  if (blue_data == 10 || blue_data == 5){
    all_on(blue_data);
  }
/*---------------------------------ON/OFF INDIVIDUAL COLOR------------------------------------*/
  else if (blue_data == 60 || blue_data == 55){
    red(blue_data);
  }
  else if (blue_data == 70 || blue_data == 65){
    green(blue_data);
  }
  else if (blue_data == 80 || blue_data == 75){
    blue(blue_data);
  }
}

/*-----------------------------------CONTROLS THE LIGHTS--------------------------------------*/
void all_on(int blue_data){
  Serial.println(blue_data);

  if (blue_data == 10){
    digitalWrite(Red, LOW);
    digitalWrite(Green, LOW);
    digitalWrite(Blue, LOW);    
  }
  else if (blue_data == 5){
    digitalWrite(Red, HIGH);
    digitalWrite(Green, HIGH);
    digitalWrite(Blue, HIGH);    
  }
  else{
    blue_data != bluetooth.read();
  }
}

void red(int blue_data){
  if (blue_data == 55){
    digitalWrite(Red, HIGH);
    Serial.println(blue_data);
  }
  else if (blue_data == 60){
    digitalWrite(Red, LOW);
    Serial.println(blue_data);
  }
}

void green(int blue_data){
  if (blue_data == 65){
    digitalWrite(Green, HIGH);
    Serial.println(blue_data);
  }
  else if (blue_data == 70){
    digitalWrite(Green, LOW);
    Serial.println(blue_data);
  }
}

void blue(int blue_data){
  if (blue_data == 75){
    digitalWrite(Blue, HIGH);
    Serial.println(blue_data);
  }
  else if (blue_data == 80){
    digitalWrite(Blue, LOW);
    Serial.println(blue_data);
  }
}

#include <Arduino.h>

//définition des pins
#define but_pin 2

//déclaration des variables
int pot_out[6] = {0, 0, 0, 0, 0, 0};
int mapped_output[6] = {0, 0, 0, 0, 0, 0};

//fonction qui s'exécute une fois en début de programme
void setup() {
  //ouverture de la communication
  Serial.begin(9600);
  //configuration du pin pour le bouton (utile pour les test)
  pinMode(but_pin, INPUT_PULLUP);
}

//fonction qui s'exécute en boucle
void loop() {
  //récupération et mapping des données
  pot_out[0] = analogRead(A0);
  pot_out[1] = analogRead(A1);
  pot_out[2] = analogRead(A2);
  pot_out[3] = analogRead(A3);
  pot_out[4] = analogRead(A4);
  pot_out[5] = analogRead(A5);
  pot_out[5] = 0;
  for(int i = 0; i < 6; i++) mapped_output[i] = map(pot_out[i], 0, 1023, 0, 295);

  if(digitalRead(but_pin) == HIGH){
    //transmission des données
    for(int i = 0; i < 6; i++){
     Serial.print(mapped_output[i]);
     Serial.print(",");
    }
    Serial.print("\n");
  }
  
}
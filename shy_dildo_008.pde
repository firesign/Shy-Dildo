/*
 Shy Dildo v 007
 Two IR sensors on dildo turn off vibrating motor
 PIR sensor enables vibrating motor on user proximity
 
 created July 19 2010
 by Michael B. LeBlanc
 NSCAD University 
 <http://generaleccentric.net>
 */

// set pin numbers:
const int sensorPin0 = 0;     // the number of the sensor pin
const int sensorPin1 = 1;     // the number of the sensor pin
const int PIRpin = 7;
const int ledPin =  13;       // the number of the LED pin

// Variables will change:
int sensorState0 = 0;         // variable for reading the sensor0 status
int sensorState1 = 0;         // variable for reading the sensor1 status
int ledState = LOW;             // ledState used to set the LED
int PIRstate = LOW;               // variable for reading the PIR status
long startTimer = 0;        
long currentTime = 0;
int flag;

// the follow variables is a long because the time, measured in miliseconds,
// will quickly become a bigger number than can be stored in an int.
long interval = 8000;           // interval at which to blink (milliseconds)

void setup() {
  // set the digital pin as output:
  pinMode(PIRpin, INPUT);  
  pinMode(12, OUTPUT);
  pinMode(sensorPin0, INPUT);    
  pinMode(sensorPin1, INPUT);
  pinMode(ledPin, OUTPUT); 

  digitalWrite(12,LOW);
  //Serial.begin(9600); 
}

void loop()
{

  sensorState0 = analogRead(sensorPin0);
  sensorState1 = analogRead(sensorPin1);

  if (sensorState0 <= 1022 || sensorState1 <= 1022) {     
    // turn LED off:    
    digitalWrite(ledPin, LOW);  
    delay(2000);
  } 
  
  else if (PIRstate == HIGH)
  {
    // turn LED on:
    digitalWrite(ledPin, HIGH); 
  }


  currentTime = millis();
  PIRstate = digitalRead(PIRpin);


  if (PIRstate == HIGH)  // if someone is close by, turn on PIRstate (turn on motor)
  {
    startTimer = millis();
    digitalWrite(12,HIGH);
    flag = HIGH;
  }

  else
  {
    if (flag == HIGH)   
    {
      flag = LOW;
    }

    currentTime = millis();

    if (currentTime - startTimer > interval) // no one is close so turn off PIRstate 
                                              
    {
      digitalWrite(12,LOW);
      digitalWrite(ledPin, LOW); // (turn off motor)
    }
  }

}

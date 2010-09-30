// Using this MIDI library
// http://timothytwillman.com/itp_blog/?page_id=240

#include "Midi.h"

#define STATUS1 7
#define STATUS2 6
#define STATUS3 5
#define STATUS4 4
#define STATUS5 3

class Rocker : public Midi {
  public:

  Rocker(HardwareSerial &s) : Midi(s) {}

  void handleNoteOn(unsigned int channel, unsigned int note, unsigned int velocity) {    
    int level = velocity * 2;
    
    if (level < 50) {
      level = 50;
    }
    
    if (note == 42 || note == 44 || note == 46) {
      // High Hat
      blink(STATUS1, velocity * 2);
    } else if (note == 41 || note == 43 || note == 45 || note == 48) {
      // Toms
      blink(STATUS3, velocity * 2);
    } else if (note == 38 || note == 40) {
      // Snare
      blink(STATUS2, velocity * 2);
    } else if (note == 49 || note == 51 || note == 52 || note == 53 || note == 55 || note == 57) {
      // Cymbals
      blink(STATUS4, velocity * 2);
    } else if (note == 36) {
      // Kick
      blink(STATUS5, velocity * 2);
    }
  }
};

Rocker midi(Serial);

void setup() {
  pinMode(STATUS1, OUTPUT);
  pinMode(STATUS2, OUTPUT);
  pinMode(STATUS3, OUTPUT);
  pinMode(STATUS4, OUTPUT);
  pinMode(STATUS5, OUTPUT);
  
  for (int i = 0; i < 10; i++) {
    digitalWrite(STATUS1, HIGH);
    digitalWrite(STATUS2, HIGH);
    digitalWrite(STATUS3, HIGH);
    digitalWrite(STATUS4, HIGH);
    digitalWrite(STATUS5, HIGH);
    delay(30);
    digitalWrite(STATUS1, LOW);
    digitalWrite(STATUS2, LOW);
    digitalWrite(STATUS3, LOW);
    digitalWrite(STATUS4, LOW);
    digitalWrite(STATUS5, LOW);
    delay(30);
  }
  
  midi.begin(0);
}

void loop() {
  midi.poll();
}

void blink(int pin, int level) {
  analogWrite(pin, level);
  delay(30);
  analogWrite(pin, 0);
  delay(30);
}

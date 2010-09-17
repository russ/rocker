#include "Midi.h"

const int ledPin = 9;

class Rocker : public Midi {
  public:

  Rocker(HardwareSerial &s) : Midi(s) {}

  void handleNoteOn(unsigned int channel, unsigned int note, unsigned int velocity) {
    analogWrite(ledPin, velocity * 2);
  }

  void handleNoteOff(unsigned int channel, unsigned int note, unsigned int velocity) {
    analogWrite(ledPin, 0);
  }
};

Rocker midi(Serial);

void setup() {
  pinMode(ledPin, OUTPUT);
  midi.begin(0);
}

void loop() {
  midi.poll();
}

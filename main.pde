#include "Midi.h"
#include "LEDPixels.h"
#include "Pillar.cpp"

LEDPixels LP;
int numberOfLeds = 160;
int display[160];

int black = LP.color(0, 0, 0);
int white = LP.color(31, 31, 31);
int blue = LP.color(0, 0, 31);
int red = LP.color(31, 0, 0);
int green = LP.color(0, 31, 0);
int yellow = LP.color(0, 31, 31);
int orange = LP.color(20, 31, 31);

Pillar highHatPillar(0, 30, yellow);
Pillar snarePillar(31, 60, red);
Pillar tomPillar(61, 90, blue);
Pillar cymbalPillar(91, 120, green);
Pillar kickPillar(121, 160, orange);

class Rocker : public Midi {
  public:
  Rocker(HardwareSerial &s) : Midi(s) {}

  void handleNoteOn(unsigned int channel, unsigned int note, unsigned int velocity) {
    if (note == 42 || note == 44 || note == 46) {
      highHatPillar.setDuration(30);
    } else if (note == 41 || note == 43 || note == 45 || note == 48) {
      tomPillar.setDuration(30);
    } else if (note == 38 || note == 40) {
      snarePillar.setDuration(30);
    } else if (note == 49 || note == 51 || note == 52 || note == 53 || note == 55 || note == 57) {
      cymbalPillar.setDuration(30);
    } else if (note == 36) {
      kickPillar.setDuration(30);
    }
  }
};

Rocker midi(Serial);

void fadeLights() {
  for (int i = 0; i < 32; i++) {
    LP.setRange(0, numberOfLeds, LP.color(i, i, i));
    LP.show();
    delay(30);
  }

  for (int i = 32; i >= 0; i--) {
    LP.setRange(0, numberOfLeds, LP.color(i, i, i));
    LP.show();
    delay(30);
  }
}

void blink() {
  Pillar pillar;
  Pillar pillars [] = {
    highHatPillar, snarePillar,
    tomPillar, cymbalPillar, kickPillar };

  for (int i = 0; i <= 4; i++) {
    pillar = pillars[i];

    if (pillar.getDuration() > 0) {
      LP.setRange(pillar.getStart(), pillar.getEnd(), pillar.getColor());
      LP.show();
      pillar.decrementDuration();
    } else {
      LP.setRange(pillar.getStart(), pillar.getEnd(), black);
      LP.show();
    }
  }
}

void setup() {
  // Microseconds, Number of leds, address of display, clock (green), data (yellow)
  LP.initialize(25, &display[0], numberOfLeds, 12, 11);
  LP.setRange(0, numberOfLeds, black);
  LP.show();

  fadeLights();

  midi.begin(0);
}

void loop() {
  midi.poll();

  blink();
}

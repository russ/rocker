#include "Midi.h"
#include "LEDPixels.h"

LEDPixels LP;
int display[119];

class Rocker : public Midi {
  public:

  Rocker(HardwareSerial &s) : Midi(s) {}

  void handleNoteOn(unsigned int channel, unsigned int note, unsigned int velocity) {    
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
  // Number of leds, address of display, clock (green), data (yellow)
  LP.initialize(129, &display[0], 60, 12, 11);
  LP.setRange(0, 119, LP.color(0, 0, 0));
  LP.show();

  // Fade lights on startup
  for (int i = 0; i < 32; i++) {
    LP.setRange(0, 119, LP.color(i, i, i));
    LP.show();
    delay(30);
  }

  for (int i = 32; i >= 0; i--) {
    LP.setRange(0, 119, LP.color(i, i, i));
    LP.show();
    delay(30);
  }

  midi.begin(0);
}

void loop() {
  midi.poll();
}

void blink(int pillar, int level) {
  LP.setRange(0, 20, LP.color(32, 32, 32));
  LP.show();
  delay(30);
  LP.setRange(0, 20, LP.color(0, 0, 0));
  LP.show();
  delay(30);
}

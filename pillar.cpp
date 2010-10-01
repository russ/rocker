class Pillar {
  int start, end, color, duration;

  public:

  Pillar(int s = 0, int e = 0, int c = 0) {
    setStart(s);
    setEnd(e);
    setColor(c);
    setDuration(0);
  }

  int getStart() { return this->start; }
  int getEnd() { return this->end; }
  int getColor() { return this->color; }
  int getDuration() { return this->duration; }

  void setStart(int s) { this->start = s; }
  void setEnd(int e) { this->end = e; }
  void setColor(int c) { this->color = c; }

  void setDuration(int d) {
    this->duration = d;

    if (duration > 30) {
      this->duration = 30;
    }
  }

  int decrementDuration() {
    if (duration > 0) {
      this->duration--;
    }
  }
};

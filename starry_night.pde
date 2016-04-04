float[] radii = new float[10000];
float[] angles = new float[10000];
float[] ground = new float[10];

int numStars;
float northStarX, northStarY;

void setup() {
  background(0);
  size(800, 400);
  northStarX = width * 0.8;
  northStarY = height * 0.3;
  numStars = radii.length/2;
  for (int i = 0; i < numStars; ++i) {
    float x = random(-max(width, height), max(width, height));
    float y = random(-max(width, height), max(width, height));
    radii[i] = sqrt(sq(x)+sq(y));
    angles[i] = atan2(y, x);
  }
  for (int i = 0; i < ground.length; ++i) {
    ground[i] = 30+noise(i)*50;
  }
  noSmooth();
}

void draw() {
  background(0);
  noStroke();
  fill(255);
  for (int i = 0; i < numStars; ++i) {
    ellipse(northStarX+radii[i]*cos(angles[i]), northStarY+radii[i]*sin(angles[i]), 1, 1);
    if (!keyPressed) {
      angles[i] += 0.0004;
    }
  }
  fill(55);
  beginShape();
  vertex(0, height);
  for (int i = 0; i < ground.length; ++i) {
    vertex(i*width/(ground.length-1), height-ground[i]);
  }
  vertex(width, height);
  endShape();

  if (mousePressed) {
    for (int i = 0; i < 10 && numStars < radii.length; ++i) {
      float x = random(50)*cos(random(TWO_PI));
      float y = random(50)*sin(random(TWO_PI));
      radii[numStars] = sqrt(sq(x+mouseX-northStarX)+sq(y+mouseY-northStarY));
      angles[numStars] = atan2(y+mouseY-northStarY, x+mouseX-northStarX);
      numStars++;
    }
  }
}
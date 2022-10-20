//Jason McDonald
//Started out making a noisy background using an array
//Then found a game tutorial and tried to convert to a soccer concept
//Then realized I used the array in the noise
//so couldn't get rid of the noise for a soccer field...
//so I'm saying it's grass...
//that is moving in the wind...


int cols = 800;
int rows = 800;
float force = .75;
float ballSpeedY = 0;
float ballSpeedX = 100;
float ballWeight = 0;
int ballXPos, ballYPos;
float ballDiam = 25;
int ballColor = color(238, 103, 48, 255);
int startBouncing = 0;
int kickForce = 3;
float xDecay = .04;
PFont f;
PShape shoe;

// Declare 2D array
int[][] noiseArray = new int[cols][rows];

void setup() {
  int w = 800;
  int h = 800; 
  ballXPos = width/2;
  ballYPos= height/4;
  shoe = loadShape("shoe.svg");
  size(800, 800);

}

void draw() {
  background(2,200,20,10);
  noCursor();
// Fill the noiseArray
  for (int i = 0; i < cols; i = i + (int) Math.round(random(1,10)) ) {
    for (int j = 0; j < rows; j = j + (int) Math.round(random(1,10))) {
      noiseArray[i][j] = int(random(255));
    }
  }

// Draw the noise
  for (int i = 0; i < cols; i = i + (int) Math.round(random(1,10))  ) {
    for (int j = 0; j < rows; j = j + (int) Math.round(random(1,10)) ) {
      stroke(noiseArray[i][j]);
      point(i, j);
    }
  }
  
  if (startBouncing == 0) {
    startBGNoise();
  }
  else {
   startBall(); 
  }
}

public void mousePressed() {
  if (startBouncing == 0) {
     startBouncing = 1; 
  }
}



void startBall() {
  initBall();
  gravity();
  boundary();
  kickBall();
  moveBallX();
  shape(shoe, mouseX, mouseY, 30, 50);
}

void initBall() {
  fill(ballColor);
  ellipse(ballXPos, ballYPos, ballDiam, ballDiam);
}

void startBGNoise() {
   background(0);
   textAlign(CENTER);
   text("Click anywhere to drop the ball.", width/2, height/2);
   text("Kick the ball with the shoe to move it around the screen.", width/2, height/1.8);
}

void gravity() {
  ballSpeedY += force;
  ballYPos += ballSpeedY;
}
//move ballSpeedY closer to 0 to increase gravity effect
void bounceBottom(float s) {
 ballYPos = int(s - (ballDiam/2));
 ballSpeedY*=-force;
}

void bounceTop(float s) {
 ballYPos = int(s + (ballDiam/2));
 ballSpeedY*=-1;
}

void bounceLeft(float s) {
  ballXPos = int(s +(ballDiam/2));
  ballSpeedX *=-1;
}

void bounceRight(float s) {
  ballXPos = int(s -(ballDiam/2));
  ballSpeedX *=-1;
}


void boundary() {
 //when the ball touches the bottom of the screen
 if (ballYPos+(ballDiam/2) > height) {
   bounceBottom(height); 
 }
 //top
 if (ballYPos - (ballDiam/2) < 0) {
   bounceTop(0);  
 }
 //left side
 if (ballXPos - (ballDiam/2) < 0) {
   bounceLeft(0); 
 }
 //right side
 if (ballXPos + (ballDiam/2) > width) {
   bounceRight(width); 
 }
}

void kickBall() {
  if (dist(mouseX, mouseY, ballXPos, ballYPos) < ballDiam) {
    
    if (pmouseY < ballYPos) {
      bounceBottom(mouseY);
      ballSpeedY*=abs(mouseY - pmouseY); 
    }
    if (pmouseY > ballYPos) {
      bounceTop(mouseY);
      ballSpeedY*=abs(mouseY - pmouseY);  
    }
    if(pmouseX > ballXPos) {
      bounceRight(mouseX);
      ballSpeedX*=abs(mouseX - pmouseX+1)*8; 
    }
    if (pmouseX < ballXPos) {
      bounceLeft(mouseX);
      ballSpeedX*=abs(mouseX - pmouseX+1)*8; 
    }
  }
  
}

void moveBallX() {
  ballXPos += ballSpeedX;
  ballSpeedX -= ballSpeedX * xDecay;
}

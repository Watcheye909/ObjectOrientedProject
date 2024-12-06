class player {
 
  PVector position, acceleration, velocity;
  
  ArrayList<PVector> trail = new ArrayList<PVector>();
  
  float fxSize; //never used this for anything
  
  boolean canHit = true;
  boolean dead = false;
  
  color col;
  int colRed = 0;
  int colGreen = 0;
  int colBlue = 0;
  
  boolean charged;
  
  //inputs
  boolean dashKey = false;
  boolean upKey = false;
  boolean downKey = false;
  boolean leftKey = false;
  boolean rightKey = false;
  
  player(float x, float y){
   position = new PVector(x, y); //assigning player position to = the PVector position
   acceleration = new PVector(0, -0.05); // never used acceleration for anything
   velocity = new PVector(3.5,-3.5); //assigns player movement speeds with a PVector

  }
  
  
  void moveUp(){
    //velocityY.sub(acceleration);
    if(position.y >= 10) //edge detection
    position.y += velocity.y;
  }
                                              //THESE MOVE THE POSITION OF THE PLAYER BY CHANGING THE position VECTOR'S .y VALUE
  void moveDown(){
    //velocityY.add(acceleration);
    if(position.y <= 390)
    position.y -= velocity.y;
  }
  
  void moveLeft(){
    //velocityX.sub(acceleration);
    if(position.x >= 10)
    position.x -= velocity.x;
  }
                                              //SAME THING APPLIES FOR THIS ONE, CONTROLLING THE DIRECTION WITH THE VECTOR'S .x VALUE
  void moveRight(){
    //velocityX.add(acceleration);
    if(position.x <= 390)
    position.x += velocity.x;
  }
  
  void dash(){
    dashDir = new PVector(); //I gave up on storing direction input since it was taking too long to figure out so this never is used
  }
   
  void display(){
    //drawing the player with the energy outline (the blue stuff)
    col = color(colRed, colGreen, colBlue);
    fxSize = 2;
    strokeWeight(fxSize);
    stroke(col);
    fill(255);
    rectMode(CENTER);
    rect(position.x, position.y, 20, 20);
    noStroke();
  }//display END
  
}//class END

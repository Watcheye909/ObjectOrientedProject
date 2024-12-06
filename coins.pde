class coins{

  PVector position;
  
  float posX = random(50, 300);//assign random coin positions
  float posY = random(50,300);
  
  color col;
  
  coins(float x, float y){
    position = new PVector(posX, posY); // uses the randomized coin positions to "spawn a new coin"
  }
  
  //draw the coin
  void display(){
    col = color(255, 200, 30);
    fill(col);
    circle(position.x, position.y, 15);
  }
  
}

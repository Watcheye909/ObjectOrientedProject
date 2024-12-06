class spikeBall{

  player player;
  
  PVector position, velocity;
  int size = 20;
  
  color col;
  
  float speedX = random(2,5); //assign random ball speeds to make them have variation
  float speedY = random(2,5);
  
  spikeBall(float x, float y){
    position = new PVector(x, y);//assigning the position PVector with th spikeBall position
    velocity = new PVector(speedX, speedY);//sets the velocity to the randomized speed value
    
    //starting the ball spawn in the top left corner of the screen
    position.x = 0;
    position.y = 0;
}
  
  void move(){ //moves the ball position with the velocity value from before
    position.x += velocity.x;
    position.y += velocity.y;
    
    //System.out.println(position.x);
    //System.out.println(position.y);
  }
  
  //checking when the balls make contact with a wall
  void wallCheck(){
    if(position.x > 400 || position.x < 0)
      bounceX();
      
    if(position.y > 400 || position.y < 0)
      bounceY();    
  }
  
  //reverse the ball velocity to make it bounce in the canvas
  void bounceX(){
    velocity.x *= -1;
    speedX = random(1,5);
  }
  
  void bounceY(){
    velocity.y *= -1;
    speedY = random(1,5);
  }
  
  //drawing the spikeBall
  void display(){   
    noStroke();
    col = color(255, 60, 60);
    fill(col);
    circle(position.x, position.y, size);
    
    //middle
    triangle(position.x - 5, position.y + 5, position.x + 5, position.y + 5, position.x, position.y + 20);
    triangle(position.x + 5, position.y - 5, position.x - 5, position.y - 5, position.x, position.y - 20);
    
    //corners 1
    triangle(position.x + 10, position.y - 5, position.x - 10, position.y, position.x - 15, position.y - 15);
    triangle(position.x + 10, position.y + 5, position.x - 10, position.y, position.x - 15, position.y + 15);
    
    //corners 2
    triangle(position.x - 10, position.y - 5, position.x + 10, position.y, position.x + 15, position.y - 15);
    triangle(position.x - 10, position.y + 5, position.x + 10, position.y, position.x + 15, position.y + 15);
    
    //sides
    triangle(position.x - 5, position.y - 10, position.x - 5, position.y + 5, position.x - 20, position.y);
    triangle(position.x + 5, position.y - 10, position.x + 5, position.y + 5, position.x + 20, position.y);
  }

}

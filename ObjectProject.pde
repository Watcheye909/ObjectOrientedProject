//CLASS REFERENCES

player player;
spikeBall spikeBall;

coins coins;

spikeBall[] spikeBalls = new spikeBall[10];//arraylist for the amount of balls to spawn in

//DASH VARIABLES

PVector dashDir;
boolean dashKey = false;
boolean isDashing = false;
float dashCooldown = 0;
float dashLength;

float invincible;

//GAME VARIABLES

int score = 0;
int highScore = 0;
float level = 0;

float textPosX = 182;
float textPosY = 80;

//on startup
void setup(){
 size(400, 400);
 
 //very chaotic way of referencing the other objects
 player = new player(width/2, 200);
 coins = new coins(width/2, height/2);
 spikeBalls[0] = new spikeBall(width/2, 100);
 spikeBalls[1] = new spikeBall(width/2, 100);
 spikeBalls[2] = new spikeBall(width/2, 100);
 spikeBalls[3] = new spikeBall(width/2, 100);
 spikeBalls[4] = new spikeBall(width/2, 100);
 spikeBalls[5] = new spikeBall(width/2, 100);
 spikeBalls[6] = new spikeBall(width/2, 100);
 spikeBalls[7] = new spikeBall(width/2, 100);
 spikeBalls[8] = new spikeBall(width/2, 100);
 spikeBalls[9] = new spikeBall(width/2, 100);
}

//update each frame
void draw(){
 background(0); 
 player.display();
 
 if(score == 0)
   guideText();
 
 System.out.println("invincible time: " + invincible);
 
 for(int i = 0; i < level; i++){ //spawn more balls based on the amount of coins collected
 
 /*I realized it would get very chaotic if each coin spawned a new ball so I used a variable called level instead.
 Since the balls spawn based on "i" being less than a whole number(score), changing "score" to "level", and 
 increasing "level" by a few decimals will result in a new ball spawning every couple of coins collected
   */
   if(i < 10){
     spikeBalls[i].display();
     spikeBalls[i].move();
     spikeBalls[i].wallCheck();
   
   //HIT DETECTION
   
   //checking if the objects have a realitivly similar position based on their diameter
     if((spikeBalls[i].position.x >= player.position.x - 25 && spikeBalls[i].position.x <= player.position.x + 25) && (spikeBalls[i].position.y >= player.position.y - 25 && spikeBalls[i].position.y <= player.position.y + 25) && player.canHit){
        player.dead = true;
        reset();
        System.out.println("PLAYER DEAD");
     }
   }
   /*
   MY OLD VERY INCONVENIENT METHOD OF CHANGING THE BALL SPAWN RATE
   if(score >= 1){
     spikeBalls[0].display();
     spikeBalls[0].move();
     spikeBalls[0].wallCheck();
     System.out.println("new ball");
   }
   
   if(score >= 5){
     spikeBalls[1].display();
     spikeBalls[1].move();
     spikeBalls[1].wallCheck();
     System.out.println("new ball");
   }
   
   if(score >= 10){
     spikeBalls[2].display();
     spikeBalls[2].move();
     spikeBalls[2].wallCheck();
     System.out.println("new ball");
   }
   
   if(score >= 12){
     spikeBalls[3].display();
     spikeBalls[3].move();
     spikeBalls[3].wallCheck();
     System.out.println("new ball");
   }
   
   if(score >= 14){
     spikeBalls[4].display();
     spikeBalls[4].move();
     spikeBalls[4].wallCheck();
     System.out.println("new ball");
   }
   
   if(score >= 16){
     spikeBalls[5].display();
     spikeBalls[5].move();
     spikeBalls[5].wallCheck();
     System.out.println("new ball");
   }
   */
   
 }
 
 coins.display(); //spawn coin
 scoreText(); //display scores
 highScoreText();
  
 //COIN DETECTION
 
 //checking for collision using position & object size
 if((coins.position.x >= player.position.x - 20 && coins.position.x <= player.position.x + 20) && ((coins.position.y >= player.position.y - 20 && coins.position.y <= player.position.y + 20))){ //collider for when the player touches the coin
   coins.position.x = random(50,300); //spawn new coin point
   coins.position.y = random(50,300);
   
   score += 1; //increase score
   level += 0.2;
   System.out.println("collect");
 }



 
 //PLAYER INPUT & DASHING
 
 

 // Add a point to the end of the trail at the player position
  player.trail.add(new PVector(player.position.x, player.position.y));
  
  // If the trail gets too long, remove the oldest point
  if (player.trail.size() == 10) {
    player.trail.remove(0);
  }
  
  //adds the outline when the player can dash & removes it when they can't
  if(player.charged){
    player.colRed = 100;
    player.colGreen = 255;
    player.colBlue = 255;
  }
  else{
    player.colRed = 0;
    player.colGreen = 0;
    player.colBlue = 0;
  }
 
 //if the player presses the dashKey and they have energy, the player will perform the dash(if it's not already happening)
 if(player.dashKey && !isDashing && player.charged){
   dashLength = 0.2; //set how long the dash will last
   invincible = 0.3; //set the additional invincibilty that the player gets when dashing
   isDashing = true;
   dashDir = new PVector(player.velocity.x+2, player.velocity.y-2); //never used this stuff so dashDir was pointless 
   player.charged = false;
   player.canHit = false;
 }
 
 if(!player.charged)
   coolDown(); //start the dash cooldown so the player can't spam the dash too much
   
   //when the cooldown timer is finished counting, the player can dash again
 if(dashCooldown <= 0){
   player.charged = true;
   dashCooldown = 1;
 }
 
 //while the dash is being performed(making sure it's only performing these actions according to the dashLength timer)
 if(isDashing && dashLength > 0){
   
  
  // DRAWING THE TRAIL
  for (int i = 0; i != player.trail.size() - 1; i++) {
    PVector p = player.trail.get(i);

    // The trail is smaller at the beginning,
    // and larger closer to the player
    float size = 25 * i / player.trail.size();
    fill(100, 255, 255);
    ellipse(p.x, p.y, size, size);
  }

  //increase player speed
   player.velocity.x += 1;
   player.velocity.y -= 1;
   
   //start the timer for how long the dash lasts
   dashLength -= 1/frameRate;
   
   //System.out.println("dash time: " + dashLength); debugging stuff
   //System.out.println("invincible time: " + invincible);
 }
 
 //when the dash is done (timer reaches 0), reset player speed and give extra invincibility time
 if(dashLength <=0){
   invincible -= 1/frameRate;
   player.velocity.x = 3.5;
   player.velocity.y = -3.5;
   isDashing = false;
 }
 
 //once invincibility is done (timer reaches 0), let the player be able to take damage again
 if(invincible <= 0){
   invincible = 0;
   player.canHit = true;
 }
 
 
 //BASIC MOVEMENT
 
 
 if(player.upKey){
   player.moveUp();
   //System.out.println(player.velocityY.mag());
 }
 
 if(player.downKey){
   player.moveDown();
   //System.out.println("y mag: " + player.velocityY.mag());
 }
 
 if(player.leftKey){
   player.moveLeft();
   //System.out.println(player.velocityX.mag());
 }
 
 if(player.rightKey){
   player.moveRight();
   //System.out.println(player.velocityX.mag());
 }
 
}//draw END


//METHODS


//timer that counts down from it's assigned starting point 
void coolDown(){
  dashCooldown -= 1/frameRate;
  System.out.println("cooldown time: " + dashCooldown);
}

//printing the current score of the player with a faded opacity
void scoreText(){
  textSize(68);
  fill(255, 255, 255, 50);
  text(score, textPosX, textPosY);
}

void highScoreText(){
  textSize(24);
  fill(255, 255, 255, 50);
  text("High Score: " + highScore, 240, 385);
}

void guideText(){
  textSize(24);
  fill(255, 255, 255, 50);
  text("Arrow keys - MOVE ", 10, 300);
  text("Shift - DASH ", 10, 330);
}

//reset the values in the game 
void reset(){
  if(score > highScore)
       highScore = score;
  for(int i = 0; i < level; i++){
   if(i < 10){
     spikeBalls[i].display();
     spikeBalls[i].move();
     spikeBalls[i].wallCheck();
     spikeBalls[i].position.x = 0;
     spikeBalls[i].position.y = 0;
   }
  }
  player.position.x = width/2;
  player.position.y = 200;
  score = 0;
  level = 0;
}


void keyPressed(){
  if(keyCode == UP || keyCode == 'w'){
    player.upKey = true;
    player.downKey = false;
  }
    
    if(keyCode == DOWN || keyCode == 'w'){
      player.downKey = true;
      player.upKey = false;
    }
    
  if(keyCode == LEFT || keyCode == 'a'){
    player.leftKey = true;
    player.rightKey = false;
  }
    
  if(keyCode == RIGHT || keyCode == 'a'){
    player.rightKey = true;
    player.leftKey = false;
  }
  
  if(keyCode == SHIFT || keyCode == 'a'){
    player.dashKey = true;
  }
}

void keyReleased(){
  if(keyCode == UP || keyCode == 'w')
    player.upKey = false;
    
  if(keyCode == DOWN || keyCode == 'w')
    player.downKey = false;
    
  if(keyCode == LEFT || keyCode == 'a')
    player.leftKey = false;
    
  if(keyCode == RIGHT || keyCode == 'a')
    player.rightKey = false;
  
  if(keyCode == SHIFT || keyCode == 'a'){
    player.dashKey = false;
  }
}

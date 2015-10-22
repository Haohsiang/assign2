PImage bg1, bg2, treasure, enemy, fighter, hp, start1, start2, end1, end2;
float hpX, treasureX, treasureY, enemyX, enemyY, bgFirstX, bgSecondX, fighterX, fighterY;
final int GAME_START = 1, GAME_RUN = 2, GAME_LOSE = 3;
int gameState;
boolean upPressed = false, downPressed = false, leftPressed = false, rightPressed = false;
float fighterSpeed = 5;



void setup () {
  size(640,480) ;  
  
  //start
  start1 = loadImage("img/start1.png");
  start2 = loadImage("img/start2.png");
  gameState = GAME_START;
  
  //end
  end1 = loadImage("img/end1.png");
  end2 = loadImage("img/end2.png");
  
  //background
  bg1 = loadImage("img/bg1.png");  
  bg2 = loadImage("img/bg2.png");
  bgFirstX = 0;
  bgSecondX = -641;
  
  //treasure
  treasure = loadImage("img/treasure.png");
  treasureX = random(600); // let the picture inside the screen
  treasureY = random(440); // let the picture inside the screen
  
  //enemy 
  enemy = loadImage("img/enemy.png");
  enemyX = 0;  // the enemy will move from the leftest side
  enemyY = random(420);  // let the picture inside the screen

  //fighter
  fighter = loadImage("img/fighter.png");
  fighterX = 589;
  fighterY = 214.5;
 
  //hp (top)
  fill(#CC0000);
  hpX = (205-10)*20/100; //10<=hpX<=205, at least 20 points of blood 
  hp = loadImage("img/hp.png"); 
}

void draw() {
switch (gameState){
    case GAME_START:
      image(start2, 0, 0);
      //mouse detecting
      if (mouseX >= width*95/300 && mouseX <= width*215/300 &&
          mouseY >= height*390/500 && mouseY <= height*435/500){
          image(start1, 0, 0);
      }else{
        image (start2, 0, 0);
      }
      //click to start
      if (mousePressed){
        if (mouseX >= width*95/300 && mouseX <= width*215/300 && 
            mouseY >= height*390/500 && mouseY <= height*435/500){
            gameState = GAME_RUN;
          }
      }
      break;
      
    case GAME_RUN:
      //background
      image(bg1, bgFirstX, 0);
      image(bg2, bgSecondX, 0);
      bgFirstX++;
      bgSecondX++;
      
      if (bgFirstX >= 641){
        bgFirstX = -641;
      }
      if (bgSecondX >= 641){
        bgSecondX = -641;
      }
        
      //treasure
      image(treasure, treasureX, treasureY);
      
      //enemy
      image(enemy, enemyX, enemyY);
      enemyX = enemyX + 5;
      enemyX %= 640;
      if (enemyY > fighterY){
      enemyY -= 2;
      } else if(enemyY < fighterY){
      enemyY += 2;
      }

      
    
      //fighter
      image(fighter, fighterX, fighterY); // the rightest, in the middle
        //derection controlling
      if (upPressed){
        fighterY -= fighterSpeed; 
      }
      if (downPressed){
        fighterY += fighterSpeed;
      }
      if (leftPressed){
        fighterX -= fighterSpeed;
      }
      if (rightPressed){
        fighterX += fighterSpeed;
      }
        //boundary controlling
      if (fighterX>589){
        fighterX = 589;
      }
      if (fighterX<0){
        fighterX = 0;
      }
      if (fighterY>429){
        fighterY = 429;
      }
      if (fighterY<0){
        fighterY = 0;
      }
      
      //hp
      fill(#CC0000);
      rectMode(CORNERS);
      rect(10,3,hpX,27); //under
      image(hp, 0, 0); //above
      if(hpX>=205){ // in case the blood exceeds the box
        hpX = 205;
      }
      
      //when fighter touches treasure, including six situations
     if (treasureX < fighterX && treasureY < fighterY && treasureX + 41 > fighterX && treasureY > fighterY){
       hpX = hpX + (205-10)*10/100; // add blood 10%
       treasureX = random(600); 
       treasureY = random(440);
     }
     if (treasureX < fighterX && treasureY > fighterY && treasureX + 41 > fighterX && treasureY < fighterY +51){
       hpX = hpX + (205-10)*10/100;
       treasureX = random(600);
       treasureY = random(440);
     }
     if (treasureX > fighterX && treasureY < fighterY && treasureX < fighterX + 51 && treasureY + 41 > fighterY){
       hpX = hpX + (205-10)*10/100;
       treasureX = random(600);
       treasureY = random(440);
     } 
     if (treasureX > fighterX && treasureY > fighterY && treasureX < fighterX + 51 && treasureY < fighterY +51){
       hpX = hpX + (205-10)*10/100;
       treasureX = random(600);
       treasureY = random(440); 
     }
     if (treasureX < fighterX && treasureX + 41 > fighterX && treasureY == fighterY){
       hpX = hpX + (205-10)*10/100;
       treasureX = random(600);
       treasureY = random(440); 
     }
     if (treasureX > fighterX && fighterX + 51 > treasureX && treasureY == fighterY){
       hpX = hpX + (205-10)*10/100;
       treasureX = random(600);
       treasureY = random(440); 
     }
      
      //when enemy touches fighter, including six situations
     if (enemyX < fighterX && enemyY < fighterY && enemyX + 61 > fighterX && enemyY + 61 > fighterY){
       hpX = hpX - (205-10)*20/100;
       enemyX = 0;
       fighterX = 589;
       fighterY = 214.5;
     }
     if (enemyX < fighterX && enemyY > fighterY && enemyX +61 > fighterX && enemyY < fighterY + 51){
       hpX = hpX - (205-10)*20/100;
       enemyX = 0;
       fighterX = 589;
       fighterY = 214.5;
     }
     if (enemyX > fighterX && enemyY < fighterY && enemyX < fighterX +51 && enemyY + 61 > fighterY){
       hpX = hpX - (205-10)*20/100;
       enemyX = 0;
       fighterX = 589;
       fighterY = 214.5;
     }
     if (enemyX > fighterX && enemyY > fighterY && enemyX < fighterX + 51 && enemyY < fighterY + 51){
       hpX = hpX - (205-10)*20/100;
       enemyX = 0;
       fighterX = 589;
       fighterY = 214.5;
     }
     if (enemyX < fighterX && enemyX+61 > fighterX && enemyY == fighterY){
       hpX = hpX - (205-10)*20/100;
       enemyX = 0;
       fighterX = 589;
       fighterY = 214.5;
     }
     if (enemyX > fighterX && fighterX+51 > enemyX && enemyY == fighterY){
       hpX = hpX - (205-10)*20/100;
       enemyX = 0;
       fighterX = 589;
       fighterY = 214.5;
     }
     
     //when to gameover
     if (hpX <= 10){
       gameState = GAME_LOSE;
       enemyX = 0;
       hpX = (205-10)*20/100;
       fighterX = 589;
       fighterY = 214.5;
     }
     break;
          
      
 case GAME_LOSE:
      image(end2, 0, 0);
      if (mouseX >= width*96/300 && mouseX <= width*205/300 && mouseY >= height*257/400 && mouseY <= height*292/400){
        image(end1, 0, 0);
      }else{
        image(end2, 0, 0);
      }
      //click to restart
      if (mousePressed){
        if (mouseX >= width*96/300 && mouseX <= width*205/300 && 
            mouseY >= height*257/400 && mouseY <= height*292/400){
            gameState = GAME_RUN;
          }
      }
  }
}

void keyPressed(){
  if (key==CODED){
    switch(keyCode){
      case UP:
        upPressed = true;
      break;
      case DOWN:
        downPressed = true;
      break;
      case LEFT:
        leftPressed = true;
      break;
      case RIGHT:
        rightPressed = true;
      break;
    }
  }
}

void keyReleased(){
  if (key==CODED){
      switch(keyCode){
        case UP:
          upPressed = false;
        break;
        case DOWN:
          downPressed = false;
        break;
        case LEFT:
          leftPressed = false;
        break;
        case RIGHT:
          rightPressed = false;
        break;
      }
  }
}

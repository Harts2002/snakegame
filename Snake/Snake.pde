
ArrayList<snake> S = new ArrayList(); 
Apple A = new Apple(); 
String direction ="dir"; 
int points = 1;   //snakelength
int counter = 0;  //used to count how many body rectangles to take off when self_collide
int counter2 = 0; //used to update the snakelength text
int lives = 3;  
int speed = 1; 
void setup() {
  size(700, 700); 
  background(0); 
  S.add(new snake(width/2, height/2)); //start with a snakehead in the middle of the screen
}
void draw() {
  background(0);

  if (lives != 0) {
  frameRate(speed*10); //adjusting the speed of the snake
  A.display(); 
  A.collision(); 
  S.get(0).out(); 
  S.get(0).keyPressed(); 
  S.get(0).collision();
  S.get(0).self_collide();
  for (int i = 0; i < S.size(); i++) {
    S.get(i).display();
  }

  //the texts on the upper part of the screen
  textSize(40); 
  fill(255); 
  text("length:", 10, 80);
  text(points, 150, 80);
  text("lives:", 530, 80); 
  text(lives, 630, 80);
  }else{
    background(0); 
    fill(0, 255, 0);
    textSize(50);
    text("Game OVER", 250, 200);
    text("Score:", 250, 300);
    text(points, 250, 400);
    text(points, 250, 400);
    textSize(30);
    text("esc to exit",290,500); 
  }

}
class snake {
  private int x; 
  private int y; 
  boolean add = false; 
  public snake(int a, int b) {
    this.x = a; 
    this.y = b;
  }
  public void display() {
    fill(255,182,193); 
    rect(this.x, this.y, 20, 20);
  }
  public int getX() {
    return this.x;
  }
  public int getY() {
    return this.y;
  }
  //checking to see if the snake goes out of the screen, if yes then gameover. 
  public void out(){
    if (this.x < 10 || this.x > 700){
      lives = 0; 
    }
    if (this.y > 680 || this.y <10){
      lives = 0; 
    }
  }
  //checking to see if the snakehead hit the apple
  public void collision() {
    int sx = A.getX();
    int sy = A.getY();
    if (sx - this.x < 20 && sx - this.x > -20) {
      if (sy - this.y < 20 && sy - this.y > -20) {
        add = true;
      }
    }
  }
  //checking to see if the snakehead hits its body
  public void self_collide() {
    counter = 0; 
    for (int i = 1; i < S.size(); i++) {
      if (this.x - S.get(i).x < 20 && this.x - S.get(i).x > -20) {
        if (this.y - S.get(i).y < 20 && this.y - S.get(i).y > -20) {
          counter = i;
          break;
        }
      }
    }
    //if counter > 0, the head has hit the body so now take off the right amount of rectangles
    if (counter > 0) {
      for (int i = S.size()-1; i >= counter; i--) {
        S.remove(i);
        speed = 1; 
        counter2++;
      }
      points -= counter2; 
      lives -= 1;
    }
    counter2 = 0;
  }
  void keyPressed() {
    if (key == CODED) {
      if (keyCode == LEFT) { 
        if (direction != "right") {  //to prevent the user from going opposite directions immediately
          S.add(0, new snake(S.get(0).x-20, S.get(0).y)); //create a new snake at the front of the ArrayList
          direction = "left"; //setting the current direction
          if (add == true) { //if add is true, then the last spot for the arraylist is kept
            add= false;
          } else {
            S.remove(S.size()-1); // if add is false, the last spot for the arraylist is deleted
          }
        } 
        // if the previous direction was the opposite of the keyCode, then continue moving in the previous direction
        else { 
          S.add(0, new snake(S.get(0).x+20, S.get(0).y));
          direction = "right";
          if (add == true) {
            add= false;
          } else {
            S.remove(S.size()-1);
          }
        }
      }

      if (keyCode == RIGHT) {
        if (direction != "left") {
          S.add(0, new snake(S.get(0).x+20, S.get(0).y));
          direction = "right";
          if (add == true) {
            add= false;
          } else {
            S.remove(S.size()-1);
          }
        } else {
          S.add(0, new snake(S.get(0).x-20, S.get(0).y));
          direction = "left";
          if (add == true) {
            add= false;
          } else {
            S.remove(S.size()-1);
          }
        }
      }

      if (keyCode == UP) {
        if (direction != "down") {
          direction = "up"; 
          S.add(0, new snake(S.get(0).x, S.get(0).y-20));
          if (add == true) {
            add= false;
          } else {
            S.remove(S.size()-1);
          }
        } else {
          S.add(0, new snake(S.get(0).x, S.get(0).y+20));
          if (add == true) {
            add= false;
          } else {
            S.remove(S.size()-1);
          }
        }
      }

      if (keyCode == DOWN) {
        if (direction != "up") {
          direction = "down"; 
          S.add(0, new snake(S.get(0).x, S.get(0).y+20));
          if (add == true) {
            add= false;
          } else {
            S.remove(S.size()-1);
          }
        } else {
          S.add(0, new snake(S.get(0).x, S.get(0).y-20));
          if (add == true) {
            add= false;
          } else {
            S.remove(S.size()-1);
          }
        }
      }
    }
  }
}
class Apple {
  private int x; 
  private int y; 
  public Apple() {
    this.x = int(random(1, 119)*5); // giving the apple a random x coordinate
    this.y = int(random(1, 119)*5); // giving the apple a random y coordinate
  }
  
  public void display() {
    fill(255, 0, 0);
    rect(this.x, this.y, 20, 20);
  }
  public int getX() {
    return this.x;
  }
  public int getY() {
    return this.y;
  }
  public void collision() {
    int sx = S.get(0).getX();
    int sy = S.get(0).getY();
    if (sx - x < 20 && sx - x > -20) {   // checking to see if the x coordinate of the snakehead and the apple are close enough
      if (sy - y < 20 && sy - y > -20) {  // checking to see if the y coordinate of the snakehead and the apple are close enough
        reset(); //giving the x coordinate and y coordinate of the apple new values
      }
    }
  }
  
  //giving the apple new location
  void reset() {
    this.x = int(random(1, 119)*5); 
    this.y = int(random(1, 119)*5);
    points += 1;
    //every 10 points the snake will speed up 
    if (points % 10 == 0 ){
      speed += 1; 
    }
  }
}
// endgame command
void keyPressed(){ 
    if (key == ESC){
      exit();
    }
  
}

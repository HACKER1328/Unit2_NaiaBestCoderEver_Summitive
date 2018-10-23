//Loading the music 
import processing.sound.*;
SoundFile file;

//variables
float y2; 
int score;
int score1;
int score2;
int scene0;
int scene1;
int scene2;
int scene3;
int scene4;
int scene = 4;
int timer;
int starttime;
int pausestart;
int pauseend;
float volume = 0.5;
PImage hand;
PImage potato;
PImage pl;
PImage pr;
float ballspeed = 1.5;
PFont Font;
boolean islooping = true;
boolean waslooping = true;



Blocker[] blockers = new Blocker[6];

void setup() {

  //loading images
  hand = loadImage("Hand.png");
  potato = loadImage("Potato.png");
  pl = loadImage("PL.png");
  pr = loadImage("PR.png");

  //music file
  file = new SoundFile(this, "Tobu - Candyland.mp3");
  file.loop();

  //size
  surface.setResizable(true);
  size(800, 850);
  //bockers code
  for (int i = 0; i < blockers.length; i++) {
    blockers [i] = new Blocker();
    blockers[i].y =200*i+100;
  }
  y2 = y2+7;

  //loading font
  Font = createFont("Copperplate", 60);
}

void draw() {

  //title screen
  if (scene == 4)
  {
    title();
  }

  //menu screen
  if (scene == 0)
  {
    menu();
  }

  //settings
  if (scene == 3)

  {
    setting();
  }

  //game screen
  if (scene == 1)
  {  
    if (islooping == true)
    {
      game();
    }
  }

  //end screen
  if (scene == 2)
  {
    end();
  }

  if (waslooping != islooping) {

    if (islooping == false) {
      pausestart = millis();
    } else {
      starttime += millis() - pausestart;
    }
  }
  waslooping = islooping;
}

void keyPressed() {

  //start button
  if (key == 's')
  {
    if (scene == 0) {
      scene = 1;
      starttime = millis();
      score = 0;
    }
  }

  //reset button
  if (key == 'r')
  {
    if (scene == 2) {
      scene = 1;
      starttime = millis();
      score = 0;
    }
  }

  //quit button
  if (key == 'q')
  {
    if (scene == 0) {
      exit();
    }
  }

  //menu button
  if (key == 'm')
  {
    if (scene == 2) {
      scene = 0;
    }

    if (scene == 3) {
      scene = 0;
    }
  }

  //settings button
  if (key == 't')
  {
    if (scene == 0) {
      scene = 3;
    }
  }

  //volume control keys
  if (key == 'q')
  {
    if (scene == 3) {
      if (volume < 1)
      {
        volume+=0.1;
        file.amp(volume);
        if(!file.isPlaying())
        {
        file.play();
        }
      }
    }
  }

  if (key == 'a')
  {
    if (scene == 3) {
      if (volume >= .1)
      {
        volume-=0.1;
        file.amp(volume);
    
        if (volume < 0.1) {

          file.pause();
        } 

        }
      }
    }

  //ball speed control keys
  if (key == 'w')
  {
    if (scene == 3) {
      if (ballspeed < 5)
      {
        ballspeed+=0.1;
      }
    }
  }

  if (key == 'e')
  {
    if (scene == 3) {
      if (ballspeed > .2)
      {
        ballspeed-=0.1;
      }
    }
  }

  //pause button

  if (key == 'p') {
    if (scene == 1)
    {
      if (islooping)
      {
        islooping = false;
      } else
      {
        islooping = true;
      }
    }
  }

  //pause music
  if (key == 'p') {
    if (scene == 1)
    {
      if (file.isPlaying()) {
        file.pause();
      } else {
        file.play();
      }
    }
  }
  //coding for plus and minus score
  boolean hit = false;
  if (scene == 1) {
    if (key == ' ') {
      for (int i = 0; i < 6; i++)
      {
        if (y2 > blockers [i].y + 30)
        { 
          if (y2 < blockers[i].y + 60)
          {          
            hit = true;
            score = score + 1;
          }
        }
      }
      if (hit == false)
      {
        score = score - 1;
      }
    }
  }
}

//click anywhere on screen' for title screen command
void mousePressed() {

  if (scene == 4) {
    scene = 0;
  }
}

void title() {

  background(0);

  frame.setSize(800, 850);  
  textAlign(CENTER);
  textFont(Font, 60);
  text("POTATO CATCH", 400, 350);

  textAlign(CENTER);
  textSize(20);
  text("click anywhere on the screen to start", 400, 600);

  imageMode(CENTER);
  image(pl, 140, 335, 40, 40);
  image(pr, 660, 335, 40, 40);
  imageMode(CORNER);
}

void menu() {

  background(0);

  frame.setSize(800, 850);
  //text on screen
  textAlign(CENTER);
  textFont(Font, 50);
  text("MENU", 400, 130);

  textAlign(CENTER);
  textSize(25);
  text("RULES", 350, 250);

  textAlign(CENTER);
  textSize(20);
  text("- Press the spacebar when on the hands to get points", 320, 300);

  textAlign(CENTER);
  textSize(20);
  text("- Do not press the spacebar when on the black area", 305, 350);

  textAlign(CENTER);
  textSize(20);
  text("- Collect as many points as possible, till the timer reaches 40", 360, 400);

  textAlign(CENTER);
  textSize(20);
  text("- At the end, the final score will be displayed", 275, 450);

  textAlign(CENTER);
  textSize(20);
  text("Press 's' to start", 600, 600);

  textAlign(CENTER);
  textSize(20);
  text("Press 'q' to exit", 600, 675);

  textAlign(CENTER);
  textSize(20);
  text("Press 't' for settings", 600, 750);
}

void setting() {

  background(0);

  frame.setSize(800, 850);

  //text on screen
  textAlign(CENTER);
  textSize(25);
  text("SETTINGS", 350, 200);

  //Increase and decrease volume
  textAlign(CENTER);
  textSize(20);
  text("Increase Volume Press : Q", 350, 250);

  textAlign(CENTER);
  textSize(20);
  text("Decrease Volume Press : A", 350, 300);

  text(volume, 350, 350);
  file.amp(volume);

  //Back to menu
  textAlign(CENTER);
  textSize(20);
  text("Press 'm' to menu", 600, 675);

  //Increase and decrease ball speed
  textAlign(CENTER);
  textSize(20);
  text("Increase Ball Speed Press : W", 350, 400);

  textAlign(CENTER);
  textSize(20);
  text("Decrease Ball Speed Press : E", 350, 450);

  text(ballspeed, 350, 500);
}

void game() {

  background(0);

  frame.setSize(350, 850);

  for (int i = 0; i < blockers.length; i++) {

    //blockers move command
    blockers [i].update();
    blockers [i].show();

    // the white circle
    fill(255);
    image(potato, 50, y2, 30, 30);

    //score and timer
    textAlign(CENTER);
    text("SCORE "+ score, 275, 50);

    textAlign(CENTER);
    text("TIMER "+ timer, 275, 100);

    textAlign(CENTER);
    text("TO PAUSE", 280, 150);
    text("PRESS 'P'", 280, 170);

    //timer
    if (millis() - starttime > 40000)
    {
      scene = 2;
    }
  }

  timer = (millis() - starttime) / 1000;

  //fall command ball
  y2 = y2 + ballspeed ; 

  if (y2 > height) 
  { 
    y2 = 0;
  }
}

void end() {

  background(0);

  frame.setSize(400, 850);

  //text on end screen
  textAlign(CENTER);
  textSize(30);
  text("FINAL SCORE "+ score, 200, 320);

  textAlign(CENTER);
  textSize(20);
  text("Press 'R' to restart", 200, 600);

  textAlign(CENTER);
  textSize(20);
  text("Press 'M' to go to menu", 200, 750);
}

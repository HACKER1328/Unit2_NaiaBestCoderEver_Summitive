//Loading the music 
import processing.sound.*;
SoundFile file;

//variables
float y2; 
int score;
int score1;
int score2;
int scene1;
int scene0;
int scene = 0;
int timer;
int starttime;

Blocker[] blockers = new Blocker[8];

void setup() {

  //music file
  file = new SoundFile(this, "Tobu - Candyland.mp3");
  file.play();
  //size
  surface.setResizable(true);
  size(200, 850);
  //bockers code
  for (int i = 0; i < blockers.length; i++) {
    blockers [i] = new Blocker();
    blockers[i].y =100*i+100;
  }

  y2 = y2+7;
}

void draw() {

  background(0);
  //coding for start screen
  if (scene == 0)
  {

    //text on screen
    frame.setSize(800, 850);
    textAlign(CENTER);
    textSize(25);
    text("RULES", 350, 200);

    textAlign(CENTER);
    textSize(20);
    text("- Press the spacebar when on the white blocks to get points", 350, 250);

    textAlign(CENTER);
    textSize(20);
    text("- Do not press the spacebar when on the black area", 305, 300);

    textAlign(CENTER);
    textSize(20);
    text("- Collect as many points as possible, till the timer reaches 60", 350, 350);

    textAlign(CENTER);
    textSize(20);
    text("- At the end, the final score will be displayed", 270, 400);

    textAlign(CENTER);
    textSize(20);
    text("Press 's' to start", 600, 600);

    textAlign(CENTER);
    textSize(20);
    text("Press 'q' to exit", 600, 675);
  }



  //coding for game screen
  if (scene == 1)

  {  
    frame.setSize(250, 850);
    for (int i = 0; i < blockers.length; i++) {

      //blockers move command
      blockers [i].update();
      blockers [i].show();

      // the white circle
      fill(255);
      ellipse(50, y2, 30, 30);

      //score and timer
      textAlign(CENTER);
      text("SCORE "+ score, 175, 50);

      textAlign(CENTER);
      text("TIMER "+ timer, 175, 100);

      //timer
      if (millis() - starttime > 60000)
      {
        scene = 2;
      }
    }

    timer = (millis() - starttime) / 1000;

    //fall command
    y2 = y2 + 1.5 ; 

    if (y2 > height) 
    { 
      y2 = 0;
    }
  }

  //coding for end screen
  if (scene == 2)
  {
    frame.setSize(400, 850);

    //text on end screen
    textAlign(CENTER);
    textSize(25);
    text("FINAL SCORE "+ score, 200, 425);

    textAlign(CENTER);
    textSize(25);
    text("Press 'r' to restart", 200, 600);

    textAlign(CENTER);
    textSize(25);
    text("Press 'q' to go to menu", 200, 750);
  }
}

void keyPressed() {

  //start button
  if (key == 's')
  {
    if (scene == 0) {
      scene = 1;
      starttime = millis();
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

  //menu button and quit button
  if (key == 'q')
  {
    if (scene == 0) {
      exit();
    }
    if (scene == 2) {
      scene = 0;
    }
  }


  //coding to plus and minus score
  boolean hit = false;
  if (scene == 1) {
    if (key == ' ') {
      for (int i = 0; i < 8; i++)
      {
        if (y2 > blockers [i].y)
        { 
          if (y2 < blockers[i].y + 20)
          {          

            hit = true;
            String s = "you win";
            println(s);
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

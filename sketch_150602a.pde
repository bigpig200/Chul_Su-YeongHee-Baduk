int wid=800; 
int hei=500;
float player[]={710,250,90,250};
float p_power[]={0,0};
float shoot_power=0;
float ball[]={0,0};
float h_event_x=0;
float h_event_y=0;
int time=0;
int ball_type[]={0,0};
float item_lo[]={0,0, 0,0};
int item_s[] = {1,1};
PImage obj_images;
int s_s=0;
float dog[]={400,250};
int ran_swit=0;
 
PImage[] ch_images = new PImage[12];
PImage[] y_images = new PImage[12];
PImage[] d_images = new PImage[12];
PImage[] item_images = new PImage[3];
PImage[] flo_images = new PImage[8];
PImage[] win_images = new PImage[2];
PImage map_images;
PImage arrow_images;
PImage bar_images;
PImage title_images;
int dog_ball_range[] = { 2500, 6400, 40000};


int dog_flag=0;
int dog_ran=60;
float dog_speed=2.0;
float dog_degree=0;
float dog_dx[] = {0,0};
int move_dog=0;
int p_score[]= {0,0};
int p_item[] = {0,0};
 
float speed=0;
int p_turn = 0;
int game_state=0;
int ch_move_state[] = {0,0};
 
 
//sound

import ddf.minim.*;
Minim minim;
AudioPlayer song;
AudioPlayer thr_ball;
AudioPlayer bark;
AudioPlayer end;
AudioPlayer collect;
AudioPlayer start;
AudioPlayer play;

//sound
 
 
void setup(){

size(wid,hei);
frameRate(60);
obj_images=loadImage("item/obj.png");
map_images=loadImage("map.png");
arrow_images=loadImage("item/arrow.png");
bar_images=loadImage("item/bar.png");
title_images=loadImage("item/title.png");
for(int i=0; i<12; i++){
  y_images[i] = loadImage("young/"+i+".png");
  ch_images[i] = loadImage("cheol/"+i+".png");
  d_images[i] = loadImage("baduk/"+i+".png");
  if(i<2) win_images[i]=loadImage("item/win_"+i+".png");
  if(i<3) item_images[i]=loadImage("item/ball_"+i+".png");
  if(i<8) flo_images[i]=loadImage("item/f_"+i+".png");
  }
 _reset();
 game_state=0;
 minim = new Minim(this);
 
 start=minim.loadFile("sound/start.mp3");

}

void player_item(){
  
  if(p_item[0]>0){
    pushMatrix();
  switch(p_item[0]){
    case 1:
    translate(96,60);
    rotate(radians(45));
    image(item_images[1],0,0);
    break;
    case 2:
    translate(96,60);
    rotate(radians(45));
    image(item_images[2], 0, 0);
    break;    
  }
  popMatrix();
  }
  if(p_item[1]>0){
    pushMatrix();
    switch(p_item[1]){
    case 1:
    translate(720,60);
    rotate(radians(45));
    image(item_images[1],0,0);
    break;
    case 2:
    translate(720,60);
    rotate(radians(45));
    image(item_images[2], 0, 0);
    break;    
  }
  popMatrix();
  }

  


}

void print_score(){

  for(int i=0; i<p_score[1]; i++){
    image(flo_images[(i+move)%4], 40, 60+40*i);
  }
  for(int i=0; i<p_score[0]; i++){
    image(flo_images[4+(3*i+move)%4], 730, 60+40*i);
  }


}

void char_move(){
  if(player[3]>420) player[3]=421; 
  else if(player[3]<100) player[3]=101;

  if(player[1]>420) player[1]=421;
  else if(player[1]<100) player[1]=101;

  
 
}


void draw_item(){
  for(int i=0; i<2; i++){ 
    if(item_s[i]==1){
    
    image(obj_images, item_lo[2*i]-19, item_lo[2*i+1]-19);
    if( (ball[0]-item_lo[2*i])*(ball[0]-item_lo[2*i]) + (ball[1]-item_lo[2*i+1])*(ball[1]-item_lo[2*i+1]) <360 ){
      if(random(0,100) > 20) p_item[p_turn]=int(random(0,100)%3);
      shoot_degree = random(-60,60);
      if(p_turn == 1) shoot_degree += 180;
      shoot_degree = 90-shoot_degree;
      h_event_x=(shoot_power/3)*sin(radians(shoot_degree));
      h_event_y=(shoot_power/3)*cos(radians(shoot_degree));
      item_s[i]=0;
    }
    
    }
  }
}
    
    

void locate_item(){
    item_lo[0]=random(200,400);
    item_lo[1]=random(120,380);
    item_lo[2]=random(400,600);
    item_lo[3]=random(120,380);
}

void _reset(){
  player[1]=250;
  player[3]=250;
  h_event_y=0;
  h_event_x=0;
  game_state=1;
  locate_item();
  shoot_power=0;
  item_s[0]=1;
  item_s[1]=1;
  dog[0]=400;
  dog[1]=250;
  s_s=0;
  switch(p_turn){
  case 0:
    ball[0]=710;
    ball[1]=250; 
  break;
  case 1:
      ball[0]=90;
      ball[1]=250; 
  break;
  
  }
  
    
}
 
void ball_range(){
  if( ball[0]>=750 ||  ball[0]<=50){
    if(ball[0]>=750){p_score[1]++; }
    if(ball[0]<=50) {p_score[0]++; }
    if(p_turn==0) p_turn=1;
    else p_turn=0;
    collect = minim.loadFile("sound/collect.wav");
    collect.play();
   _reset();
   
   
  }
  else if( ball[1]>=450){
    ball[1]=449; 
    h_event_y=-h_event_y;
    song = minim.loadFile("sound/ball_bounce.wav");
    song.play();

  }
  else if( ball[1]<=50){
    ball[1]= 51;
    h_event_y=-h_event_y;
    song = minim.loadFile("sound/ball_bounce.wav");
    song.play();
  }
 
}
 

float dx=0;
float dy=0;
float shoot_degree = 0;
float p_x=0;
float p_y=0;
void shoot_ball(){
  if(p_turn==1){
    p_x=player[0];
    p_y=player[1];
    ball[1] = player[1];
  }
  else{
    p_x=player[2];
    p_y=player[3];
   ball[1] = player[3];
  }
    
  dx = mouseX - p_x;
  dy = mouseY - p_y;
  shoot_degree = degrees(atan2(dy ,dx));
 
  if(p_turn==0){
    if(shoot_degree>60) shoot_degree=60;
    else if( shoot_degree< -60) shoot_degree=-60;
  }
  else if(p_turn==1){

    if(shoot_degree>-120 && shoot_degree < 0) shoot_degree=-120;
    else if( shoot_degree < 120 && shoot_degree>0) shoot_degree=120;
  }
 shoot_degree = 90-shoot_degree;
  pushMatrix();
  translate(p_x,p_y);
  rotate(radians(45-shoot_degree));
  image(arrow_images, 0, 0);
  popMatrix();
}
 
 
void ball_speed(){
  h_event_x=(shoot_power/3)*sin(radians(shoot_degree));
  h_event_y=(shoot_power/3)*cos(radians(shoot_degree));
}
 

 
void draw_bar(){
  fill(255,187,0);
  switch(p_turn){
    case 0:
    rect(80,player[3]-30,shoot_power,10);
    image(bar_images,80,player[3]-30);
    break;
    case 1:
    rect(680,player[1]-30,shoot_power,10);
    image(bar_images, 680,player[1]-30);
    break;
  

  }
}
 
 
void dog_move(){
  if(time%30==0) move_dog=++move_dog%3;
 
  if((dog[0]-ball[0])*(dog[0]-ball[0])+(dog[1]-ball[1])*(dog[1]-ball[1])< dog_ball_range[ball_type[p_turn]]){
    if(dog[0]>ball[0]) dog[0]-=dog_speed;
    else dog[0]+=dog_speed;
    if(dog[1]>ball[1]) dog[1]-=dog_speed;
    else dog[1]+=dog_speed;
    
    if(dog[0]<175) dog[0]=176;
    else if(dog[0]>620) dog[0]=619;
    
    
    if((dog[0]-ball[0])*(dog[0]-ball[0])+(dog[1]-ball[1])*(dog[1]-ball[1])<100) {
      bark = minim.loadFile("sound/bark.wav");
      bark.play();
      if(p_turn==0) p_turn=1;
      else p_turn=0;
      _reset();
      p_score[(p_turn+1)%2]++;
      
    }
   } 
  else{
 
  if(time%dog_ran == 0){
    dog_degree=radians(random(0,360));
    dog_ran=int(random(20,120));
    dog_speed=random(3,6);
    dog_dx[0]=sin(dog_degree)*dog_speed;
    dog_dx[1]=cos(dog_degree)*dog_speed;
  }
 
  
  if(dog[0]<175){
    dog_ran=60;
    dog[0]=176;
    dog_degree= radians((180+degrees(dog_degree))%360);
  }
  else if(dog[0]>620){
    dog_ran=60;
    dog[0]=619;
    dog_degree= radians((180+degrees(dog_degree))%360);
  }
  else if(dog[1]<70){
    dog_ran=60;
    dog[1]=71;
    dog_degree= radians((180+degrees(dog_degree))%360);
 
  }
  else if(dog[1]>410){
    dog_ran=60;
    dog[1]=409;
    dog_degree= radians((180+degrees(dog_degree))%360);
 
  }
    dog_dx[0]=sin(dog_degree)*dog_speed;
    dog_dx[1]=cos(dog_degree)*dog_speed;
 
}  
 
  dog[0]+=dog_dx[0];
  dog[1]+=dog_dx[1];
  
  pushMatrix();
  translate(dog[0],dog[1]);
  if(ran_swit==1) ellipse(0,0,sqrt(dog_ball_range[ball_type[p_turn]]),sqrt(dog_ball_range[ball_type[p_turn]]));
  translate(-42,-42);
  
  if(degrees(dog_degree)> 45 && degrees(dog_degree) < 135) image(d_images[6+move_dog], 0, 0);
  else if(degrees(dog_degree)> 135 && degrees(dog_degree) < 225) image(d_images[9+move_dog], 0, 0);
  else if(degrees(dog_degree)> 225 && degrees(dog_degree) < 315) image(d_images[3+move_dog], 0, 0);
  else image(d_images[0+move_dog], 0, 0);  
  popMatrix();
}
 

 
void phong_range(){ 
  if(ran_swit==1) rect(player[0]-29,player[1]-50,10,100);
  if(ran_swit==1) rect(player[2]+29,player[3]-70,10,140);
  
   if(ball[0]>=player[0]-30){      

      if(player[1]+50 > ball[1] && player[1]-50 < ball[1] ){
        if(p_turn==0&&s_s>0){
        song = minim.loadFile("sound/ball_bounce.wav");
        song.play();
        }
        else s_s++;
        ball[0]=player[0]-30;       
        h_event_x=-h_event_x;
        p_turn=1;
        ball_type[0]=0;
      }
   }
   if(ball[0]<=player[2]+30){
     if(player[3]+75 >ball[1] && player[3]-75 < ball[1] ){
         if(p_turn==1 && s_s>0){
        song = minim.loadFile("sound/ball_bounce.wav");
        song.play();
         }
         else s_s++;
    ball[0]=player[2]+30;
    h_event_x=-h_event_x;
    p_turn=0;
    ball_type[1]=0;

  }
 
   }
  

   }
 
int move=0;


 void draw_ball(){
  pushMatrix();
  translate(ball[0],ball[1]);
  rotate(radians(ball[0]%360));
  switch(ball_type[p_turn]){
  case 0:
  translate(-11,-11);
  image(item_images[0], 0, 0);
  break;
  case 1:
  translate(-5,-22);
  image(item_images[1], 0, 0);
  break;
  case 2:
  translate(-5,-22);
  image(item_images[2], 0, 0);
  break;
  }
  popMatrix();
}

void ball_move(){
    ball[0]+=h_event_x;
    ball[1]+=h_event_y;

}

void draw_char(){


  pushMatrix();
  translate(player[0],player[1]);
  if(ran_swit==1) ellipse(0,0,100,100);
  translate(-29,-29);
  if(ch_move_state[1]==0) image(ch_images[8+move%4], 0, 0);
  else if(ch_move_state[1]==1) image(ch_images[4+move%4], 0, 0);
  else image(ch_images[move%4], 0, 0);
 
  
  popMatrix();
  
  pushMatrix();
  translate(player[2],player[3]);
  if(ran_swit==1) ellipse(0,0,150,150);
  translate(-29,-29);
  if(ch_move_state[0]==0) image(y_images[8+move%4], 0, 0);
  else if(ch_move_state[0]==1) image(y_images[4+move%4], 0, 0);
  else image(y_images[move%4], 0, 0);

  popMatrix();

}



void catch_ball(){
if(keyPressed){
     if(key == 'a' || key == 'A') { println("catch!");
  if( (ball[0]-player[2])*(ball[0]-player[2]) + (ball[1]-player[3])*(ball[1]-player[3])  < 2500  ){
    game_state=1;
    p_turn=1;
    ball[0]=90;
    player[3]=ball[1];
    h_event_x=0;
    h_event_y=0;
  }
  }
  if(key == 'l' || key == 'L') {      
    if( (ball[0]-player[0])*(ball[0]-player[0]) + (ball[1]-player[1])*(ball[1]-player[1])  < 2500  ){
    game_state=1;
    p_turn=0;
    ball[0]=710;
    player[1]=ball[1];
    h_event_x=0;
    h_event_y=0;
  }
  }
  }
}



int jump=0;


void draw(){
  
  time++;  
  image(map_images, 0, 0);
  if(game_state==0){
    start.setGain(-10.0);
    start.play();
    pushMatrix();
    scale(2.0);
    image(ch_images[1], 120, 50);
    image(y_images[1], 220, 50);
    image(d_images[1], 160, 80);
    image(title_images, 50, 70);    
    popMatrix();
    if(keyPressed && key == ' ' && game_state==0 ){
      game_state=1;
      _reset();
      p_score[0]=0;
      p_score[1]=0;
      start.close();
      play=minim.loadFile("sound/play.mp3");
    }
    
  }
  
 if(game_state>0 && game_state<3){
  if(p_score[0]> 5 || p_score[1]>5 ){
    game_state = 3;
    end = minim.loadFile("sound/end.wav");
    play.close();
    
  }
  play.setGain(-20.0);
  play.play();
  noFill();
  catch_ball();
  
  if(time%20==0) move++;
  if(time%80==0){
    if(!keyPressed){
    if(ch_move_state[0]!=0) ch_move_state[0]=0;
    if(ch_move_state[1]!=0) ch_move_state[1]=0;
    }
  }  
  draw_item();
  player_item();
  print_score();
  ball_range();
  dog_move();  
  char_move();
  ball_move();
  phong_range();
  draw_char();
  draw_ball();
 
  //start_shoot
  if(game_state==1){
    if((mousePressed) && (mouseButton == LEFT) ){
        shoot_power++;
        if(shoot_power<10) shoot_power=10;
        shoot_power = shoot_power%35;
        draw_bar();
    }
    shoot_ball(); 
  }
 //start_shoot
 
 }
 
 if(game_state==3){
   end.play();   
   if(time%10 == 0) jump++;
   pushMatrix();
   scale(2.0);
   if(p_score[0] > p_score[1]){
    if(jump%2==0) image(ch_images[1], 160, 50);
    if(jump%2==1) image(ch_images[1], 160, 45);
   image(win_images[0], 140, 120);   
   }
   else {     

    if(jump%2==0) image(y_images[1], 160, 50);
    if(jump%2==1) image(y_images[1], 160, 45);
    image(win_images[1], 140, 120); 
   }
    popMatrix();
    if(mousePressed && game_state==3) {end.close();  start=minim.loadFile("sound/start.mp3"); game_state=0;}
   
 }

  println(game_state);
   
}

void keyPressed(){
  if(key == 'i' || key == 'I') { player[1]-=45;  ch_move_state[1]=1;}
  if(key == 'k' || key == 'K') { player[1]+=45; ch_move_state[1]=2;}
  
  if(key == 'w' || key == 'W') { player[3]-=30;  ch_move_state[0]=1;}
  if(key == 's' || key == 'S') { player[3]+=30; ch_move_state[0]=2;}
  if(key == 'q' || key == 'Q') { ball_type[1]=p_item[0]; p_item[0]=0; }
  if(key == 'o' || key == 'O') { ball_type[0]=p_item[1]; p_item[1]=0;}
  if(key == 'b' || key == 'B') {
    if(ran_swit==1) ran_swit=0;
    else ran_swit=1; }

  if(key == 'r' || key == 'R') _reset();  
}

void mouseReleased(){

if(game_state==1){
  ball_speed();
  game_state=2;
  thr_ball = minim.loadFile("sound/throw.wav");
  thr_ball.play();
}
}
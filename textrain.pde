import processing.video.*;

Capture video;
PImage show;
float threshold=50;
PFont f;

void setup(){
  f=createFont("Arial",16,true);
  size(320,240);
  video=new Capture(this,width,height,50);
  video.start();
}
int i=0,j=0;
int count=1;
FallLetter[] fallLet=new FallLetter[1];
FallLetter[] newFallLet;
void draw(){
  if(video.available()){
    video.read();
  }
  loadPixels();
  video.loadPixels();
  for(int x=0;x<video.width;x++)
  {
    for(int y=0;y<video.height;y++)
    {
      int loc=x+y*video.width;
      color cur=video.pixels[loc];
      float num=brightness(cur);
      if(num>threshold)
      {
        pixels[loc]=color(255);
      }
      else
      {
        pixels[loc]=color(0);
      }
    }
  }
  updatePixels();
  delay(50);
  textFont(f,14);
  fill(150,123,0);
  int randI=int(random(640));
  int randCh=int(random(65,90));
  newFallLet=new FallLetter[count];
  //deal with every letter
  for(int n=0;n<count;n++)
    {
      if(n==count-1)
        newFallLet[n]=new FallLetter(randI,randCh);
      else
        newFallLet[n]=fallLet[n];
      char show=newFallLet[n].GetCh();
      int xLoc=newFallLet[n].GetxLoc();
      int yLoc=newFallLet[n].GetyLoc();
     if(yLoc!=240)
      {     
        text(show,xLoc,yLoc);
        //if(red(pixels[xLoc+yLoc*width])==0&&green(pixels[xLoc+yLoc*width])==0&&blue(pixels[xLoc+yLoc*width])==0)
        if(yLoc>0)
        {
          if(brightness(pixels[xLoc+yLoc*width])<100)  
            newFallLet[n].UpdateY(-1);
          else
          {
            newFallLet[n].UpdateY(1);
          }
        }
      }
    }
    fallLet=new FallLetter[count];
   fallLet=newFallLet;
   count++;
   
}
class FallLetter{
  
  int xLocation,yLocation=10,ch;
  char chShow;
  FallLetter(int xLoc,int word)
 {
     xLocation=xLoc;
     chShow=char(word);
 }
 //falling y position update
  void UpdateY(int yLoc)
 {
   yLocation+=yLoc;
 }
 //get the position and char of the instance
  int GetxLoc()
 {
   return xLocation;
 }
  int GetyLoc()
 {
   return yLocation;
 }
  char GetCh()
 {
   return chShow;
 } 
}

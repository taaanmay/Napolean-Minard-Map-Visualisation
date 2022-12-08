// Initialise Variables
Table table;
float[] lonC, latC, lonT, lonP, latP;
String[] city, month, dir;
int[] temp, days, day, div, surv;
int N;
int originX, originY;
float textX, textY;
int time;
float wait = 0;
int tracker = 0;
String[] downCity = {"Kowno", "Smorgoni", "Molodexno", "Minsk", "Studienska", "Bobr", "Orscha", "Smolensk", "Wixma", "Malo-jarosewli"};


PFont f;
PImage img;



void setup() {
  //fullScreen();
  size(1392, 780);
  
  
  img = loadImage("map3.png");
  println("Height: "+img.height + " Width: "+img.width);
  //size(bg.width,bg.height);
 

originX = 1500;
originY = 4200;


table = loadTable("sample.csv", "header");


N = table.getRowCount();
lonC = new float[N];
latC = new float[N];
city = new String[N];
lonT = new float[N];
temp = new int[N];
days = new int[N];
month = new String[N]; 
day = new int[N];
lonP = new float[N];
latP = new float[N];
surv = new int[N];
dir = new String[N];
div = new int[N];

for (int i=0; i<N; i++)
{
  TableRow row = table.getRow(i);
  lonC[i] = row.getFloat("LONC");
  latC[i] = row.getFloat("LATC");
  city[i] = row.getString("CITY");
  lonT[i] = row.getFloat("LONT");
  temp[i] = row.getInt("TEMP");
  days[i] = row.getInt("DAYS");
  month[i] = row.getString("MON");
  day[i] = row.getInt("DAY");
  lonP[i] = row.getFloat("LONP");
  latP[i] = row.getFloat("LATP");
  surv[i] = row.getInt("SURV");
  dir[i] = row.getString("DIR");
  div[i] = row.getInt("DIV");
  
}

time = millis();//store the current time
if(millis() - time >= 6){
    println("tick");//if it is, do something
    time = millis();//also update the stored time
    
  }

f = createFont("Arial",8,true);
textFont(f,12);
fill(252, 186, 3);

} 






void draw(){
background(100);
image(img, 0, 0);
tracker++;
  


// Draw Lines representing Army Position
stroke(5,100,255);

for (int i=0; i<N-1; i++)
{
  
  
  if(millis() - time >= wait){
    time = millis();//also update the stored time
   
    
    // Show Army Positions using Circles
    //stroke(4, 38, 138, abs(temp[i]*4));
    stroke(4, 38, 138, 50);
    strokeWeight(55);
    point(lonP[i+1]*70-originX, (latP[i+1])*(-70) + originY);
    
    strokeWeight(surv[i]*0.0001);
    if(dir[i].equals("A")){
      stroke(66, 245, 179, surv[i]*0.01);
    }else{
      stroke(250, 55, 162, surv[i]*0.01);
    }
    line(lonP[i]*70-originX, (latP[i])*(-70) + originY, lonP[i+1]*70-originX, (latP[i+1])*(-70) +originY);
  }
  
}

// Draw Cities
stroke(75);
strokeWeight(15);
for (int i=0; i<N; i++)
{
  strokeWeight(15);
  point(lonC[i]*70-originX, ((latC[i])*(-70)) + originY);
  strokeWeight(2);
  textX = lonC[i]*70-originX;
  textSize(16);
  stroke(212, 160, 19);
  if(city[i].equals("Kowno") ||
      //city[i].equals("Smorgoni") ||
      city[i].equals("Molodexno") ||
      city[i].equals("Minsk") ||
      city[i].equals("Studienska") ||
      city[i].equals("Bobr") ||
      city[i].equals("Orscha") ||
      city[i].equals("Mohilow") ||
      city[i].equals("Smolensk") ||
      city[i].equals("Wixma") ||
      city[i].equals("Malo-jarosewli"))
  {
    if(city[i].equals("Orscha")){
      textY = ((latC[i])*(-70)) + originY + 10;
      textAlign(CENTER);
      text(city[i],textX,textY+15);
    }else if(city[i].equals("Bobr")){
      textY = ((latC[i])*(-70)) + originY + 70;
      textAlign(CENTER);
      text(city[i],textX,textY+15);
    }
    else{
      textY = ((latC[i])*(-70)) + originY + 40;
      textAlign(CENTER);
      text(city[i],textX,textY+15);
    }
    
  }else{
    if(city[i].equals("Smorgoni")){
      textY = ((latC[i])*(-70)) + originY - 80;
      textAlign(CENTER);
      text(city[i],textX,textY-15);
    }else
    {
    textY = ((latC[i])*(-70)) + originY - 40;
    textAlign(CENTER);
    text(city[i],textX,textY-15);
    }
  }
  
  line(lonC[i]*70-originX, ((latC[i])*(-70)) + originY, textX, textY);
  
}


// Temperature
// translate(width/2, height/2);
 //rotate(HALF_PI);
 text("Temperature", width - 50, height - 100);
for (int i = 0; i<4; i++) 
    { 
      float y = height - 150 + (i * 30);
      textAlign(RIGHT);
      strokeWeight(2);
      text(0f - i * 10 + "\u00B0" + "C", width - 100, y);
      
      strokeWeight(0.5);
      line(100, y, width - 100, y);
      
    }

for (int i=0; i<8; i++) {
      
      
  
      println("For temperature = "+ temp[i] + " lonT = "+(lonT[i]*70-2595)); //2632
      // Plot Lines for Temperature
      fill(0);
      stroke(0);
      strokeWeight(2);
      int y0 = height - 150 - temp[i] * 3;
      int y1 = height - 150 - temp[i+1] * 3;
      //line(lonT[i]*70-2000, y0 , lonT[i+1]*70-2000, y1);
      line(lonT[i]*70-originX, (y0), lonT[i+1]*70-originX, y1);
}  
for (int i=0; i<9; i++) {
      int y0 = height - 150 - temp[i] * 3;
      markPoints(lonT[i]*70-originX, y0, #84d1f0, map(days[i], 1, 10, 10, 20));
      fill(0);
      stroke(0);
      strokeWeight(2);
      textSize(12);
      textAlign(CENTER);
      fill(255);
      text(day[i] + " " + month[i] + ": " + temp[i] + "\u00B0 C", lonT[i]*70-originX + 20, y0 + 25);
      
      
      // Drawing line for temperature to map
      stroke(#84d1f0, 90);
      if(temp[i] == 0){
        line(lonT[i]*70-originX, y0, lonT[i]*70-originX,  280);
      }else{
        line(lonT[i]*70-originX, y0, lonT[i]*70-originX,  350);
      }
      
      
}   
  
  


println(tracker);


// Drawing Legend
int rectX = width - 200;
int rectY = height - 700;
fill(#a36d62, 55);
rect(rectX, rectY, 190, 420);

// Direction in Legend
fill(255);//set the text color to black
textFont(f,15);
//text("awesome text label", 25, 10);
text("DIRECTION", rectX + 100, rectY + 20);

fill(255);
textFont(f,15);
textSize(13);
textAlign(RIGHT);
strokeWeight(5);
text("ATTACK", rectX + 80, rectY + 50);
fill(66, 245, 179);
stroke(66, 245, 179);
rect(rectX + 105, rectY + 35, 40, 20);

fill(255);
textFont(f,15);
textSize(12);
textAlign(RIGHT);
strokeWeight(5);
text("RETREAT", rectX + 85, rectY + 90);
fill(250, 55, 162);
stroke(250, 55, 162);
rect(rectX + 105, rectY + 75, 40, 20);


textAlign(CENTER);
fill(255);//set the text color to black
textFont(f,15);
textSize(15.5);
//text("awesome text label", 25, 10);
text("ARMY SIZE", rectX + 80, rectY + 155);

textSize(13.5);
text("(People)", rectX + 155, rectY + 155);

textSize(15.5);


stroke(255);
strokeWeight(340000*0.0001);
line(rectX + 25, rectY +200, rectX + 55, rectY + 200);
text("340,000", rectX + 120, rectY + 205);

strokeWeight(100000*0.0001);
line(rectX + 25, rectY +250, rectX + 55, rectY + 250);
text("100,000", rectX + 120, rectY + 255);

strokeWeight(60000*0.0001);
line(rectX + 25, rectY +300, rectX + 55, rectY + 300);
text("60,000", rectX + 120, rectY + 305);

strokeWeight(20000*0.0001);
line(rectX + 25, rectY +350, rectX + 55, rectY + 350);
text("20,000", rectX + 120, rectY + 355);

strokeWeight(6000*0.0001);
line(rectX + 25, rectY +400, rectX + 55, rectY + 400);
text("6,000", rectX + 120, rectY + 405);

// Title
fill(#a36d62, 55);
rect(200 , 30, 985, 60);
strokeWeight(5);
textSize(25);
textAlign(CENTER);
fill(255);
text("MAP of successive loss in men of NAPOLEAN'S ARMY in the RUSSIAN CAMPAIGN", width/2, 60);

strokeWeight(5);
textSize(15);
textAlign(CENTER);
text("TEMPERATURE AT LOCATIONS DURING ARMY'S RETREAT", width/2, height - 15);
textSize(13);
text("Size of Markers encodes the number of days army survived", width -250, height - 45);


if(tracker > 2){
  saveFrame("Tanmay_Kaushik.png");
  stop();
}
tracker++;

}

public void markPoints(float x, float y, int colour, float size) {
  fill(colour);
  stroke(0);
  ellipse(x, y, size, size);
}

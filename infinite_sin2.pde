
import processing.pdf.*;
import java.util.Calendar;

boolean recordPDF = false;
boolean savePDF = false;

int num = 10;
float mx[] = new float[num];
float my[] = new float[num];

float px, py, px2, py2, px3, py3;
float angle, angle2;
float radius = 350;
float frequency = 2;
float frequency2 = 2;
float x, x2;

float a = 0.0;
float inc = TWO_PI/25.0;

void setup() {
  size(800, 800, P3D);
  stroke(255, 50); 
  fill(255, 50); 

  frameRate(20);
}

void draw() {
   if (savePDF) beginRecord(PDF, timestamp()+".pdf");
 
  background(0); 

  // Cycle through the array, using a different entry on each frame. 
  // Using modulo (%) like this is faster than moving all the values over.
  int which = frameCount % num;
  mx[which] = 100*px3;
  my[which] = 100*py3;

  for (int i = 0; i < 500; i++) {
    // which+1 is the smallest (the oldest in the array)
    int index = (which+1 + i) % num;
    //ellipse(mx[index], my[index], i, i);
    //line(500+tan(a)*40.0,mouseY,mx[index], my[index]);
    line(width/2+px2, py2+height/2, mx[index]+width/2, my[index]+height/2);
    ellipse(width/2+px2, py2+height/2, 2, 2);
    //line(random(800),random(800),random(800), random(800));


    px2 = cos(radians(angle2))*(radius);
    py2 = sin(radians(angle2))*(radius);

    px3 = cos(radians(angle2)*(radius));
    py3 = sin(radians(angle2)*(radius));

    angle2 -= frequency2;

    a = a + inc;
  }

  if (savePDF) {
    savePDF = false;
    endRecord();
  }
}

void keyReleased() {
  
  if (key == 'p' || key == 'P') savePDF = true;
  if (key =='r' || key =='R') {
    if (recordPDF== false) {
      beginRecord(PDF, timestamp()+".pdf");
      println("recording started");
      recordPDF = true;
      
      background(0);
      smooth();
     
    }
  } else if (key == 'e' || key == 'E') {
    if (recordPDF) {
      println("recording stop");
      endRecord();
      recordPDF = false;
      
    }
  }
 
}

// timestamp
String timestamp() {
  Calendar now = Calendar.getInstance();
  return String.format("%1$ty%1$tm%1$td_%1$tH%1$tM%1$tS", now);
}
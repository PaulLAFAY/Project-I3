import controlP5.*;
import processing.serial.*;



ControlP5 cp5;
RadioButton r;



Serial port;


void setup()
{
  
  size(500,500);
  cp5 = new ControlP5(this);
  
  
  /*println(Serial.list()); 
  for(int i = 0; i < Serial.list().length; i++){
    Bang myBang = cp5.addBang(Serial.list()[i]+"bang").setPosition(10+i*60,10).setSize(50,50);
  }*/

  println(Serial.list());
  r = cp5.addRadioButton("testRadio").setPosition(10, 100).setSize(20, 20).setSpacingRow(5);
  for(int i = 0; i < Serial.list().length; i++){
    r.add(Serial.list()[i], i);
  }

}



void draw()
{
  
  background(150,0,150);
  fill(0,255,0);
  
}







void controlEvent(ControlEvent theEvent)
{
  /*if(theEvent.isController()){
    print("recu un event de : "+theEvent.getName());
    println(" avec une valeur de : "+theEvent.getValue());
    
    if(theEvent.getName() == "COM3"){
      println("recu un event du controller bang");
    }
  }*/

  if(theEvent.isFrom(r)){
    println("event from "+theEvent.getName());
    println("value : "+theEvent.getValue());
  }

}

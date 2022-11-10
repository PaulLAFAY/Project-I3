/* autogenerated by Processing revision 1282 on 2022-06-02 */
import processing.core.*;
import processing.data.*;
import processing.event.*;
import processing.opengl.*;

import processing.serial.*;
import controlP5.*;

import java.util.HashMap;
import java.util.ArrayList;
import java.io.File;
import java.io.BufferedReader;
import java.io.PrintWriter;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.IOException;

public class ProjetI3_testCOMv2 extends PApplet {

//importation des bibliothèques



//déclaration des objets
Communication com;
UserInterface ui;
RobotArm ra;

PFont font;

//déclaration des variables
int[] data = {-1, -1, -1, -1, -1, -1};


//s'exécute une fois au démarrage du programme
 public void setup()
{
  //setup de la fenêtre
  /* size commented out by preprocessor */;
  surface.setTitle("testCOMv.2");
  surface.setResizable(false);
  surface.setLocation(displayWidth/2-width/2, displayHeight/2-height/2);

  //création de l'interface
  ui = new UserInterface(this);
}

//s'exécute en boucle
 public void draw()
{
  //dessine l'interface
  ui.drawUI();
  //si une connection est établie : on récupère les données et les affiche
  if(com != null){
    data = com.getInput();
    ui.drawData();
    AngleToPoint atp = new AngleToPoint(data);
    ra = new RobotArm(atp.convertAngle());
    if(data[0] != -1) ra.drawRobot();
  }

  //Pour fermer le programme, appuyer sur une touche (temporaire)
  if(keyPressed) exit();
}

class AngleToPoint {

    //attributs

    private int[] angle;

    //constructeurs

    public AngleToPoint(int[] angle){
        this.angle = new int[6];
        for(int i = 0; i < 6; i++){
            this.angle[i] = angle[i];
        }
    }

    //accesseurs

    //modifieurs

    //méthodes

    public Point[] convertAngle(){
        Point[] point = {new Point(), new Point(), new Point(), new Point(), new Point(), new Point()};

        //A
        point[0].setCoord(400, 700, 0);
        
        //B
        point[1].setCoord(point[0].getX(), point[0].getY() - AB, point[0].getZ());
        
        //C
        point[2].setCoord(PApplet.parseInt(point[1].getX() - BC * cos(radians(angle[0]))), point[1].getY(), PApplet.parseInt(point[1].getZ() - BC * sin(radians(angle[0]))));
        
        //D
        point[3].setCoord(point[2].getX(), PApplet.parseInt(point[2].getY() - CD * cos(radians(angle[1]))), PApplet.parseInt(point[2].getZ() - CD * sin(radians(angle[1]))));
        
        //E
        point[4].setCoord(PApplet.parseInt(point[3].getX() - DE * cos(radians(angle[2]))), point[3].getY(), PApplet.parseInt(point[3].getZ() - DE * sin(radians(angle[2]))));
        
        //F
        point[5].setCoord(point[4].getX(), PApplet.parseInt(point[4].getY() - EF * cos(radians(angle[3]))), PApplet.parseInt(point[4].getZ() - EF * sin(radians(angle[3]))));

        return point;
    }
}

class Communication extends Serial {

  //attributs

  private String input;
  private int[] tInput = {0, 0, 0, 0, 0, 0};
  //private int[] buffer = {0, 0, 0, 0, 0, 0};
  private String portName;

  //constructeur
  
  public Communication(PApplet parent, String portName, int baudRate) {
    super(parent, portName, baudRate, 'N', 8, 1);
    this.bufferUntil('\n');
    this.portName = portName;
  }

  //accesseurs

  public int[] getInput() {

    /*if(input != null){
      for(int i = 0; i < 100; i++){
        input = trim(input);
        buffer = int(split(input, ','));
        for(int j = 0; j < 6; j++) tInput[j] += buffer[j];
      }
      for(int i = 0; i < 6; i++) int(tInput[i] /= 100);
      input = null;
    }*/
    
    if (input != null) {
      input = trim(input);
      tInput = PApplet.parseInt(split(input, ','));
      input = null;
    }
    return tInput;
  }

  public String getPortName(){
    return portName;
  }

  //modifieurs

  public void setInput() {
    input = this.readStringUntil('\n');
  }

  //méthodes
  
}

//fonction qui s'exécute quand le port de communication reçoit des données
 public void serialEvent(Communication com){
  com.setInput();
}

//fonction pour fermer la communication
 public void closeCom(String portName){
  println(portName+" is close");
  com.clear();
  com.stop();
  com = null;
}

//fonction pour ouvrir la communication
 public void openCom(String comPort){
  println(comPort+" is open");
  if(com != null) closeCom(comPort);
  com = new Communication(this, comPort, 9600);
  com.clear();
}


class Point {
    
    //attributs

    private int x;
    private int y;
    private int z;

    //constructeurs

    public Point(){
        x = 0;
        y = 0;
        z = 0;
    }
    public Point(int x, int y, int z){
        this.x = x;
        this.y = y;
        this.z = z;
    }

    //accesseurs

    public int getX(){
        return x;
    }
    public int getY(){
        return y;
    }
    public int getZ(){
        return z;
    }

    //modifieurs

    public void setX(int x){
        this.x = x;
    }
    public void setY(int y){
        this.y = y;
    }
    public void setZ(int z){
        this.z = z;
    }
    public void setCoord(int x, int y, int z){
        setX(x);
        setY(y);
        setZ(z);
    }

    //méthodes

}

final int AB = 30*3;
final int BC = 30*3;
final int CD = 48*3;
final int DE = 30*3;
final int EF = 30*3;


class RobotArm {

    //attributs

    private Point[] point;

    //constructeurs

    public RobotArm(){
        point = new Point[6];
        for(int i = 0; i < 6; i++) this.point[i] = new Point();
    }
    public RobotArm(Point[] point){
        this.point = new Point[6];
        for(int i = 0; i < 6; i++){
            this.point[i] = new Point();
            this.point[i].setX(point[i].getX());
            this.point[i].setY(point[i].getY());
            this.point[i].setZ(point[i].getZ());
        }
    }

    //accesseurs

    public Point[] getPoints(){
        return point;
    }

    //modifieurs

    public void setRobotPos(Point[] point){
        for(int i = 0; i < 6; i++){
            this.point[i].setX(point[i].getX());
            this.point[i].setY(point[i].getY());
            this.point[i].setZ(point[i].getZ());
        }
    }

    public void drawRobot(){
        fill(255);
        textAlign(LEFT, TOP);
        textSize(30);
        text("Coord. :", 10, 420);
        textSize(15);
        text("A : "+point[0].getX()+";"+point[0].getY()+";"+point[0].getZ(), 10, 470);
        text("B : "+point[1].getX()+";"+point[1].getY()+";"+point[1].getZ(), 10, 470+30);
        text("C : "+point[2].getX()+";"+point[2].getY()+";"+point[2].getZ(), 10, 470+60);
        text("D : "+point[3].getX()+";"+point[3].getY()+";"+point[3].getZ(), 10, 470+90);
        text("E : "+point[4].getX()+";"+point[4].getY()+";"+point[4].getZ(), 10, 470+120);
        text("F : "+point[5].getX()+";"+point[5].getY()+";"+point[5].getZ(), 10, 470+150);


        stroke(255);
        strokeWeight(4);
        for(int i = 0; i < 5; i++){
            line(point[i].getX(), point[i].getY(), point[i].getZ(), point[i+1].getX(), point[i+1].getY(), point[i+1].getZ());
        }
        noStroke();
    }

    //méthodes

}

class UserInterface {

    //attributs

    ControlP5 cp5;
    RadioButton radioButton;

    //constructeur

    public UserInterface(PApplet sketch){
        //background
        background(50);
        fill(25);
        rect(0, 0, 100, height);

        //communication
        cp5 = new ControlP5(sketch);
        radioButton = cp5.addRadioButton("comPort").setPosition(10, 10).setSize(20, 20).setSpacingRow(5);
        for(int i = 0; i < Serial.list().length; i++){
            radioButton.add(Serial.list()[i], i);
        }

        //police d'écriture
        font = createFont("arial.ttf", 128);
        textFont(font);
    }

    //accesseurs

    //modifieurs

    //méthodes

     public void drawUI(){
        background(50);
        fill(25);
        rect(0, 0, 150, height);
    }

     public void drawData(){
        fill(255);
        textAlign(LEFT, TOP);
        
        textSize(30);
        text("Pot. :", 10, 150);
        textSize(15);
        for(int i = 0; i < 6; i++){
            text("p"+i+" : "+data[i], 10, 200+30*i);
        }
    }

}

//fonction qui s'active quand un bouton est clické
 public void controlEvent(ControlEvent event){
    for(int i = 0; i < Serial.list().length; i++){
        if(event.getValue() == i){
            openCom(Serial.list()[i]);
        }
        else if(event.getValue() == -1){
            if(com != null) closeCom(com.getPortName());
        }
    }
}


  public void settings() { size(800, 800, P3D); }

  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "ProjetI3_testCOMv2" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}

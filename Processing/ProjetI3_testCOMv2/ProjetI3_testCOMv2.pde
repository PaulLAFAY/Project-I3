//importation des bibliothèques
import processing.serial.*;
import controlP5.*;

//déclaration des objets
Communication com;
UserInterface ui;
RobotArm ra;

PFont font;

//déclaration des variables
int[] data = {-1, -1, -1, -1, -1, -1};


//s'exécute une fois au démarrage du programme
void setup()
{
  //setup de la fenêtre
  size(800, 800, P3D);
  surface.setTitle("testCOMv.2");
  surface.setResizable(false);
  surface.setLocation(displayWidth/2-width/2, displayHeight/2-height/2);

  //création de l'interface
  ui = new UserInterface(this);
}

//s'exécute en boucle
void draw()
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

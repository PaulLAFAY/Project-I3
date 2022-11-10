
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
      tInput = int(split(input, ','));
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
void serialEvent(Communication com){
  com.setInput();
}

//fonction pour fermer la communication
void closeCom(String portName){
  println(portName+" is close");
  com.clear();
  com.stop();
  com = null;
}

//fonction pour ouvrir la communication
void openCom(String comPort){
  println(comPort+" is open");
  if(com != null) closeCom(comPort);
  com = new Communication(this, comPort, 9600);
  com.clear();
}

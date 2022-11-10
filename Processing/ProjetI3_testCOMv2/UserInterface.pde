
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

    void drawUI(){
        background(50);
        fill(25);
        rect(0, 0, 150, height);
    }

    void drawData(){
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
void controlEvent(ControlEvent event){
    for(int i = 0; i < Serial.list().length; i++){
        if(event.getValue() == i){
            openCom(Serial.list()[i]);
        }
        else if(event.getValue() == -1){
            if(com != null) closeCom(com.getPortName());
        }
    }
}

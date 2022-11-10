
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

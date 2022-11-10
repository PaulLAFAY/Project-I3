
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
        point[2].setCoord(int(point[1].getX() - BC * cos(radians(angle[0]))), point[1].getY(), int(point[1].getZ() - BC * sin(radians(angle[0]))));
        
        //D
        point[3].setCoord(point[2].getX(), int(point[2].getY() - CD * cos(radians(angle[1]))), int(point[2].getZ() - CD * sin(radians(angle[1]))));
        
        //E
        point[4].setCoord(int(point[3].getX() - DE * cos(radians(angle[2]))), point[3].getY(), int(point[3].getZ() - DE * sin(radians(angle[2]))));
        
        //F
        point[5].setCoord(point[4].getX(), int(point[4].getY() - EF * cos(radians(angle[3]))), int(point[4].getZ() - EF * sin(radians(angle[3]))));

        return point;
    }
}
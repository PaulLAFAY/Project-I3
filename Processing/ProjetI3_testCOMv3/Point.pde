
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

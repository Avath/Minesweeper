

import de.bezier.guido.*;
 int NUM_ROWS =20; 
 int NUM_COLS = 20; 
private MSButton[][] buttons;
private ArrayList <MSButton> bombs;  
int bombrow;
int bombcol;
void setup ()
{
    size(400, 400);
    textAlign(CENTER,CENTER);
      
    // make the manager
    Interactive.make( this );
    
   buttons =new MSButton [NUM_ROWS][NUM_COLS] ;
    
  for(int i=0; i<NUM_ROWS;i++) {
     for(int j=0; j<NUM_COLS; j++)
        buttons[i][j]=new MSButton(i,j);
}
    bombs= new ArrayList <MSButton> ();

 for(int i=0;i<2;i++){
    setBombs();
} 
}
public void setBombs() 
{
    bombrow=(int)(Math.random()*NUM_ROWS);
bombcol=(int)(Math.random()*NUM_COLS);
        if(!bombs.contains(buttons[bombrow][bombcol]))
            bombs.add( buttons[bombrow][bombcol]);
    

}


 
public void draw ()
{
    background( 0 );
    if(isWon())
        displayWinningMessage();
}  
public boolean isWon()
{
    for(int r=0; r<NUM_ROWS; r++){
        for(int c=0; c<NUM_COLS; c++){
            if(!bombs.contains(this)&&buttons[r][c].isClicked())
                return true;
        }
    }
    return false;
}
public void displayLosingMessage()
{
   
 textSize(41);

   text("GAME OVER", 100,100);
   textSize(12);
  for(int r=0; r<NUM_ROWS; r++){
        for(int c=0; c<NUM_COLS; c++){
            if(bombs.contains(buttons[r][c])&&!buttons[r][c].isClicked())
             
                buttons[r][c].mousePressed();
        }
    }
}
public void displayWinningMessage()
{   
    text("YOU WIN", 100,100);
}

public class MSButton
{
    private int r, c;
    private float x,y, width, height;
    private boolean clicked, marked;
    private String label;
    
    public MSButton ( int rr, int cc )
    {
         width = 400/NUM_COLS;
         height = 400/NUM_ROWS;
        r = rr;
        c = cc; 
        x = c*width;
        y = r*height;
        label = "";
        marked = clicked = false;
        Interactive.add( this ); // register it with the manager
    }
    public boolean isMarked()
    {
        return marked;
    }
    public boolean isClicked()
    {
        return clicked;
    }
    // called by manager
    
    public void mousePressed () 
    {
        clicked = true;
      if(keyPressed==true&&marked==false)
        marked=true;
    else if(keyPressed==true&&marked==true){
        marked=false;
    clicked=false;
}
    else if(bombs.contains(this))
        displayLosingMessage();
    else if(countBombs(r,c)>0)
        label=Integer.toString(this.countBombs(r,c));
    else {
            if(isValid(r,c-1)&&!buttons[r][c-1].isClicked())
            buttons[r][c-1].mousePressed();
            if(isValid(r-1,c)&&!buttons[r-1][c].isClicked())
            buttons[r-1][c].mousePressed();
            if(isValid(r+1,c)&&!buttons[r+1][c].isClicked())
            buttons[r+1][c].mousePressed();
            if(isValid(r,c+1)&&!buttons[r][c+1].isClicked())
            buttons[r][c+1].mousePressed();  
            if(isValid(r-1,c-1)&&!buttons[r-1][c-1].isClicked())
            buttons[r-1][c-1].mousePressed();
            if(isValid(r+1,c-1)&&!buttons[r+1][c-1].isClicked())
            buttons[r+1][c-1].mousePressed();
            if(isValid(r-1,c+1)&&!buttons[r-1][c+1].isClicked())
            buttons[r-1][c+1].mousePressed();
            if(isValid(r+1,c+1)&&!buttons[r+1][c+1].isClicked())
            buttons[r+1][c+1].mousePressed();  
  
        
       
        
    }
    }

    public void draw () 
    {    
        if (marked)
            fill(0);
         else if( clicked && bombs.contains(this) ){
             fill(255,0,0);
         
         displayLosingMessage();}
        else if(clicked)
            fill( 200 );
        else 
            fill( 100 );

        rect(x, y, width, height);
        fill(0);
        text(label,x+width/2,y+height/2);
    }
    public void setLabel(String newLabel)
    {
        label = newLabel;
    }
    public boolean isValid(int r, int c)
    {
        if(r>-1&&r<NUM_ROWS&&c>-1&&c<NUM_COLS)
            return true; 
        return false;
    }
    public int countBombs(int row, int col)
    {
        int numBombs = 0;
        if(isValid(r-1,c)&&bombs.contains(buttons[row-1][col]))
            numBombs+=1; 
        if(isValid(r-1,c-1)&&bombs.contains(buttons[row-1][col-1]))
            numBombs+=1;
        if(isValid(r-1,c+1)&&bombs.contains(buttons[row-1][col+1]))
            numBombs+=1;
         if(isValid(r,c-1)&&bombs.contains(buttons[row][col-1]))
            numBombs+=1;
         if(isValid(r,c+1)&&bombs.contains(buttons[row][col+1]))
            numBombs+=1;
         if(isValid(r+1,c)&&bombs.contains(buttons[row+1][col]))
            numBombs+=1;
         if(isValid(r+1,c-1)&&bombs.contains(buttons[row+1][col-1]))
            numBombs+=1;
         if(isValid(r+1,c+1)&&bombs.contains(buttons[row+1][col+1]))
            numBombs+=1;

        return numBombs;
    }
}



 
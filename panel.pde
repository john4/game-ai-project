abstract class Panel  {
  float x, y, width; // positional values
  boolean isVisible;
  ArrayList<ITarget> targets;
  Panel(float x, float y, float width, ArrayList<ITarget> targets) {
    this.x = x;
    this.y = y;
    this.width = width;
    isVisible = false;
    this.targets = targets;
  }

  void draw() {
    float posX = x - boardMap.xo;
    float posY = y - boardMap.yo;

    if(isVisible) {
      rect(posX,posY,width,200);
      fill(255,0,0);
      drawContent();
    }
  }

  void click() {
    
  }

  abstract void drawContent();
}

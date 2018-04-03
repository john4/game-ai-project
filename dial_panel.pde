class DialPanel extends Panel {
  DialPanel(float x, float y, float width, ArrayList<ITarget> targets){
    super(x,y,width,targets);
  }

  @Override
  void click() {
    float posX = x - boardMap.xo;
    float posY = y + boardMap.yo;

    if(isVisible) {
      print("CLICK " + mouseX + " " + mouseY + "\n");
      for (int i = 0;i<targets.size();i++) {
        if(posX+10+i*60 < mouseX && mouseX < posX+70+i*60 && posY+30 < mouseY && mouseY < posY +70) {
          targets.get(i).increment();
          print("increment");
        } else if(posX+10+i*60 < mouseX && mouseX < posX+70+i*60 && posY+130 < mouseY && mouseY < posY +170) {
          targets.get(i).decrement();
          print("decrement");
        }
      }
    }
  }

  @Override
  void drawContent() {
    float posX = x - boardMap.xo;
    float posY = y - boardMap.yo;
    for (int i = 0;i<targets.size();i++) {
      text(targets.get(i).getName(), posX+10+i*60,posY+30);
      rect(posX+10+i*60,posY+30,40,40);
      rect(posX+10+i*60,posY+130,40,40);
    }
  }
}

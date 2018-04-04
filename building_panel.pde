class BuildingPanel extends Panel {
  ArrayList<String> buildingNames;
  BuildingPanel(float x, float y, float width, ArrayList<ITarget> targets){
    super(x,y,width,targets);
    buildingNames = new ArrayList<String>();
    buildingNames.add("Farm");
    buildingNames.add("Hovel");
    buildingNames.add("Sawmill");
    buildingNames.add("Stockpile");
  }

  BuildingPanel(float x, float y, float width){
    this(x,y,width, new ArrayList<ITarget>());
  }

  @Override
  void click() {
    print("CLICK " + mouseX + " " + mouseY + "\n");
    for (int i = 0;i<buildingNames.size();i++) {
      float posX = x - boardMap.xo;
      float posY = y - boardMap.yo;
      if(posX+10+i*80 < mouseX && mouseX < posX+50+i*80 && posY+50 < mouseY && mouseY < posY+90) {
        buildingName = buildingNames.get(i);
        placingBuilding = true;
      }
    }
  }

  @Override
  void drawContent(){
    for (int i = 0;i<buildingNames.size();i++) {
      float posX = x - boardMap.xo;
      float posY = y - boardMap.yo;
      text(buildingNames.get(i), posX+10+i*80,posY+30);
      rect(posX+10+i*80,posY+50,40,40);
    }
  }
}

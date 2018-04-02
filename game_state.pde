class GameState {
  int STEP_FOOD_DEPLETION = 1000;
  int STEP_BIRTH = 2000;

  ArrayList<Building> buildings;
  ArrayList<Citizen> citizens;
  ArrayList<Soldier> soldiers;
  ArrayList<Message> messages;
  ArrayList<Panel> panels;

  double gameStateIndex;
  double foodDepletionIndex;
  double birthIndex;

  int foodSupply;
  int lumberSupply;
  int populationCapacity;

  GameState() {
    // Assumes map has been generated
    // Place town square, add initial Humans and supplies
    buildings = new ArrayList<Building>();
    citizens = new ArrayList<Citizen>();
    soldiers = new ArrayList<Soldier>();
    messages = new ArrayList<Message>();
    panels = new ArrayList<Panel>();

    gameStateIndex = 0;
    foodDepletionIndex = STEP_FOOD_DEPLETION;
    birthIndex = 0;

    // Add town center to random grass cell
    while (true) {
      int townRow = int(random(boardMap.numRows));
      int townCol = int(random(boardMap.numCols));
      if (boardMap.cells[townRow][townCol].terraintype == 0) {
        buildings.add(new TownSquare(boardMap.cells[townRow][townCol]));
        break;
      }
    }

    foodSupply = 12;
    lumberSupply = 12;
    populationCapacity = 2;

    messages.add(new Message("Welcome to <insert name here>", 20));
    messages.add(new Message("Need additional Pylons", 20));

    int cellSize = boardMap.gridsize;
    int rows = boardMap.numRows;
    int cols = boardMap.numCols;

    ArrayList<ITarget> targets = new ArrayList<ITarget>();
    targets.add(new FarmerTarget());
    targets.add(new LumberjackTarget());
    targets.add(new PopulationTarget());
    targets.add(new SoldierTarget());

    panels.add(new Panel(200, cols*cellSize-200,rows*cellSize-400, targets));
  }

  void step() {
    // Iterate states of all Humans, update game stats (food levels, etc.)

    // Food depletion
    if (gameStateIndex >= foodDepletionIndex) {
      int foodEaten = citizens.size() + (soldiers.size() * 2);
      foodSupply -= foodEaten;
      foodDepletionIndex += STEP_FOOD_DEPLETION;
    }

    // Births
    // TODO: add new citizens at hovels if we have any
    if (citizens.size() < populationCapacity && gameStateIndex >= birthIndex) {
      citizens.add(new FreeCitizen(buildings.get(0).loc, buildings.get(0)));
      // citizens.add(new FreeCitizen(boardMap.cells[int(random(boardMap.numRows))][int(random(boardMap.numCols))], buildings.get(0)));
      birthIndex += STEP_BIRTH;
    }

    gameStateIndex += 1;
  }

  void draw() {
    for (Building building : buildings) {
      building.draw();
    }
    for (Citizen citizen : citizens) {
      citizen.draw();
    }
    for (Soldier soldier : soldiers) {
      soldier.draw();
    }
    drawInterfaces();
  }

  void drawInterfaces() {
    textSize(14);
    String terrain = "";
    int cellSize = boardMap.gridsize;
    int x = mouseX/cellSize;
    int y = mouseY/cellSize;
    int rows = boardMap.numRows;
    int cols = boardMap.numCols;
    if(x >= 0 && x < rows && y >= 0 && y < cols) {
      terrain = boardMap.cells[x][y].getTerrainName();
    }
    for(Building building : state.buildings) {
      if (building.loc.isIn(mouseX-boardMap.xo,mouseY-boardMap.yo)) {
        terrain += ", " + building.getName();
      }
    }
    String cursor = "(" + (mouseX- boardMap.xo) + ", " + (mouseY- boardMap.yo) + "), " + terrain;
    String resources = "Food: " + state.foodSupply + "  Lumber: " + state.lumberSupply + "  Population: " + state.citizens.size() + "  Soldiers: " + state.soldiers.size();
    fill(255);
    rect(-boardMap.xo,-boardMap.yo, rows*cellSize,20);
    rect(mouseX + 10- boardMap.xo, mouseY-10- boardMap.yo, cursor.length() * 8,20);
    rect(rows*cellSize-200-boardMap.xo,40-boardMap.yo,200,max(state.messages.size()*60, 40));
    // control panel
    for(Panel panel : state.panels) {
      panel.draw();
    }

    fill(0,255,255);
    rect(200-boardMap.xo, cols*cellSize-20-boardMap.yo,20,20);

    fill(0);
    text(cursor, mouseX + 10- boardMap.xo, mouseY + 2.5- boardMap.yo);
    text(resources, 20 - boardMap.xo,15 - boardMap.yo);
    String messages = "";
    for(Message message: state.messages) {
      messages += message.message + "\n\n";
    }

    text(messages, rows*cellSize-190-boardMap.xo, 40 - boardMap.yo, 200, 1000);
  }

  // Get the first unoccupied citizen, else null
  Citizen getFreeCitizen() {
    for (Citizen citizen : citizens) {
      if (citizen.isFree()) {
        return citizen;
      }
    }
    return null;
  }

  void addLumberjack() {
    Citizen freeCitizen = getFreeCitizen();
    if (freeCitizen != null) {
      citizens.add(new Lumberjack(freeCitizen.loc, buildings.get(0)));
      citizens.remove(freeCitizen);
    }
  }

  void removeLumberjack() {

  }

  void addFarmer() {
    Citizen freeCitizen = getFreeCitizen();
    if (freeCitizen != null) {
      citizens.add(new Farmer(freeCitizen.loc, buildings.get(0)));
      citizens.remove(freeCitizen);
    }
  }

  void removeFarmer() {

  }
}

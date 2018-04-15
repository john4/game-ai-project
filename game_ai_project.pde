// Game Artificial Intelligence
// Professor Gold
// Spring 2018
// Final Project
//
// John Martin, Arianna Tang, Nicholas Lailler

import java.util.Random;
import java.util.Collections;
import processing.sound.*;

BoardMap boardMap;
GameState state;
UserInterface userInterface;
boolean showControlPanel = true;
final int CELL_SIZE = 10;
final int FRAME_RATE = 60;
SoundFile bgmFile;
SoundFile buildingSound;

Random rng = new Random();

// temp
PotentialPathNode path;

void setup() {
  size(960, 540);
  noSmooth();
  frameRate(FRAME_RATE);
  boardMap = new BoardMap(960, 540, CELL_SIZE);
  boardMap.generate();
  state = new GameState();
  userInterface = new UserInterface();
  // bgmFile = new SoundFile(this, "bgm-drizzle.mp3");
  // bgmFile = new SoundFile(this, "forgotten-plains.mp3");
  bgmFile = new SoundFile(this, "wind-of-prairie.mp3");
  bgmFile.amp(0.25);
  bgmFile.loop();
  buildingSound = new SoundFile(this, "hammering-nails.wav");

  // path = boardMap.findPath(state.getBuildings().get(0).loc, state.getBuildings().get(2).loc);
}

void draw() {
  boardMap.draw();
  state.draw();
  state.step();
  userInterface.draw(state.humanPlayer);
  // path.draw();
}

void mouseClicked() {
  if (mouseButton == LEFT) {
    System.out.println("Left Click");

    int cellSize = boardMap.gridsize;
    int x = mouseX/cellSize;
    int y = mouseY/cellSize;
    int rows = boardMap.numRows;
    int cols = boardMap.numCols;
    BuildingCode pB = state.humanPlayer.placingBuilding;

    if (pB != BuildingCode.NONE) {
      Cell hoveredCell = boardMap.cellAtPos(new PVector(mouseX, mouseY));
      if (boardMap.validBuildingSpot(hoveredCell)) {
        state.humanPlayer.placeBuilding(hoveredCell);
        buildingSound.play();
      } else {
        userInterface.messageQueue.add(new Message("Cannot place " + pB.toString() + " there!", state.gameStateIndex+FRAME_RATE*5));
      }
    }

    for (Panel panel : userInterface.panels) {
      if (panel.inPanelToggle(mouseX, mouseY)) {
        panel.toggleVisible();
      }

      panel.click();
    }
  } else {
    System.out.println("Right Click");
    state.humanPlayer.placingBuilding = BuildingCode.NONE;
  }

}

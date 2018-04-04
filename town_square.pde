class TownSquare extends Building {
  TownSquare(Cell initialLocation) {
    super(initialLocation, "TownSquare");
    this.c = new int[]{255,215,0};
  }

  @Override
  void clickAction() {
    buildingInterface.isVisible = !buildingInterface.isVisible;
    clickDelay = 180;
  }
}

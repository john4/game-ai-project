class TownSquare extends Building {
  TownSquare(Cell initialLocation, int[] rgb) {
    super(initialLocation, "TownSquare");
    this.impassable = true;
    this.c = new int[]{ rgb[0], rgb[1], rgb[2] };
  }
}

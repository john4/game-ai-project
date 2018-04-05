abstract class Building extends WorldlyObject {
  int[] c = new int[3];
  String name;

  Building(Cell location, String name) {
    super(location);
    this.c = new int[]{20, 20, 20};
    this.name = name;
    location.addBuilding(this);
  }

  void draw() {
    fill(c[0], c[1], c[2]);
    rect(this.loc.x + 1, this.loc.y + 1, this.w, this.h);
  }

  String getName() {
    return this.name;
  }
}

enum BuildingCode {
  NONE, FARM, CROP, HOVEL, SAWMILL, STOCKPILE, TOWNSQUARE, FOUNDRY, BARRACKS;
}

enum ResourceCode {
  LUMBER, METAL;
}

class BuildingCosts {
  HashMap<BuildingCode, HashMap<ResourceCode, Integer>> costs;

  BuildingCosts() {
    HashMap<ResourceCode, Integer> free = new HashMap<ResourceCode, Integer>();
    free.put(ResourceCode.LUMBER, 0);
    free.put(ResourceCode.METAL, 0);

    HashMap<ResourceCode, Integer> farm = new HashMap<ResourceCode, Integer>();
    farm.put(ResourceCode.LUMBER, 12);
    farm.put(ResourceCode.METAL, 0);

    HashMap<ResourceCode, Integer> sawmill = new HashMap<ResourceCode, Integer>();
    sawmill.put(ResourceCode.LUMBER, 16);
    sawmill.put(ResourceCode.METAL, 4);

    HashMap<ResourceCode, Integer> hovel = new HashMap<ResourceCode, Integer>();
    hovel.put(ResourceCode.LUMBER, 4);
    hovel.put(ResourceCode.METAL, 0);


    costs = new HashMap<BuildingCode, HashMap<ResourceCode, Integer>>();
    for (BuildingCode buildingCode : BuildingCode.values()) {
      costs.put(buildingCode, free);
    }
    costs.put(BuildingCode.FARM, farm);
    costs.put(BuildingCode.SAWMILL, sawmill);
    costs.put(BuildingCode.HOVEL, hovel);
  }
}
class HeatCellData {
  int number;
  int level;
  int count;
  DateTime? nextReviewAt;
  HeatCellData(this.number, this.level, this.count, this.nextReviewAt);
}

class HeatCellColor {
  double colorLevel;
  HeatCellColor(this.colorLevel);
}

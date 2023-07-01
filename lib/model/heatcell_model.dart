class HeatCellData {
  int number;
  int level;
  int count;
  DateTime? nextReviewAt;
  bool today;
  HeatCellData(
      this.number, this.level, this.count, this.nextReviewAt, this.today);
}

class HeatCellColor {
  double colorLevel;
  HeatCellColor(this.colorLevel);
}

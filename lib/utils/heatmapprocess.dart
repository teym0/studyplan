import 'package:leadstudy/model/heatcell_model.dart';
import 'package:leadstudy/model/record_model.dart';

List<HeatCellData> generateHeatMapDataFromRecords(
    int bookAmount, List<Record> records, Set<int> todayPages) {
  List<HeatCellData> heatMapData = [];
  for (var i = 0; i < bookAmount; i++) {
    heatMapData.add(HeatCellData(i + 1, 0, 0, null, false));
  }
  // 順番に表示しないとnextReviewの時に渡すdatetimeが最後のものではなくなってしまうのでreversed
  for (Record record in records.reversed) {
    final length = record.last - record.start + 1;
    for (var i = 0; i < length; i++) {
      heatMapData[record.start - 1 + i].count += 1;
      heatMapData[record.start - 1 + i].level += 1;
      heatMapData[record.start - 1 + i].nextReviewAt = DateTime(2050);
      if (todayPages.contains(record.start - 1 + i)) {}
    }
  }
  // 今日のページを薄くする
  for (int page in todayPages) {
    heatMapData[page].today = true;
  }
  return heatMapData;
}

List<HeatCellColor> generateHeatMapColorData(List<HeatCellData> heatMapData) {
  List<HeatCellColor> heatMapColorData = [];
  for (HeatCellData heatCell in heatMapData) {
    double colorLevel = 0;
    if (heatCell.count == 0) {
      colorLevel = 0;
    } else if (heatCell.nextReviewAt!.isBefore(DateTime.now())) {
      colorLevel = 0.1;
    } else {
      colorLevel = 1;
    }
    if (heatCell.today) {
      if (heatCell.count == 0) {
        // 一度もやったことのない箇所
      } else {
        // 二度目以降(復習)の箇所
        colorLevel = 0.4;
      }
    }
    heatMapColorData.add(HeatCellColor(colorLevel));
  }
  return heatMapColorData;
}

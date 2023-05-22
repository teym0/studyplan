import 'package:leadstudy/model/heatcell_model.dart';
import 'package:leadstudy/model/record_model.dart';

DateTime nextReviewDate(int count, DateTime lastReview) {
  lastReview = lastReview.copyWith(
      hour: 0, minute: 0, second: 0, millisecond: 0, microsecond: 0);
  if (count == 0) {
    return DateTime.now().copyWith(
        hour: 0, minute: 0, second: 0, millisecond: 0, microsecond: 0);
  } else if (count == 1) {
    return lastReview.add(const Duration(days: 1));
  } else if (count == 2) {
    return lastReview.add(const Duration(days: 7));
  } else if (count == 3) {
    return lastReview.add(const Duration(days: 30));
  } else if (count == 4) {
    return lastReview.add(const Duration(days: 90));
  } else {
    return lastReview.add(const Duration(days: 300));
  }
}

List<HeatCellData> generateHeatMapDataFromRecords(
    int bookAmount, List<Record> records) {
  List<HeatCellData> heatMapData = [];
  for (var i = 0; i < bookAmount; i++) {
    heatMapData.add(HeatCellData(i + 1, 0, 0, null));
  }
  // 順番に表示しないとnextReviewの時に渡すdatetimeが最後のものではなくなってしまうのでreversed
  for (Record record in records.reversed) {
    final length = record.last - record.start + 1;
    for (var i = 0; i < length; i++) {
      heatMapData[record.start - 1 + i].count += 1;
      heatMapData[record.start - 1 + i].level += 1;
      heatMapData[record.start - 1 + i].nextReviewAt = nextReviewDate(
          heatMapData[record.start - 1 + i].count, record.startedAt);
    }
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
    heatMapColorData.add(HeatCellColor(colorLevel));
  }
  return heatMapColorData;
}

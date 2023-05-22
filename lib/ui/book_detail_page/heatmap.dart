import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:leadstudy/model/heatcell_model.dart';

class HeatMap extends StatelessWidget {
  const HeatMap(
      {super.key,
      required this.single,
      required this.heatMapData,
      required this.heatMapColorData});
  final bool single;
  final List<HeatCellData> heatMapData;
  final List<HeatCellColor> heatMapColorData;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      // scrollDirection: Axis.vertical,
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 10),
      itemCount: heatMapColorData.length,
      shrinkWrap: !single,
      physics: (single) ? null : const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return heatCell(heatMapData[index], heatMapColorData[index].colorLevel);
      },
    );
  }

  Widget cellNumberText(int number) {
    var brightness = SchedulerBinding.instance.window.platformBrightness;
    late Color baseColor;
    if (brightness == Brightness.light) {
      baseColor = Colors.black;
    } else {
      baseColor = Colors.white;
    }
    if (number % 10 == 0) {
      return Text(
        number.toString(),
        style: TextStyle(
            color: baseColor, fontSize: 12, fontWeight: FontWeight.bold),
      );
    } else {
      return Text(
        number.toString(),
        style: TextStyle(color: baseColor.withAlpha(50), fontSize: 12),
      );
    }
  }

  String toolTipText(HeatCellData heatCellData) {
    if (heatCellData.count == 0 || heatCellData.nextReviewAt == null) {
      return "データなし";
    } else if (heatCellData.nextReviewAt!.isBefore(DateTime.now())) {
      return "${heatCellData.number}\n回数: ${heatCellData.count}回\n次回復習: 今すぐ";
    } else {
      final nextReviewAt = heatCellData.nextReviewAt!
          .difference(DateTime.now().copyWith(
              hour: 0, minute: 0, second: 0, millisecond: 0, microsecond: 0))
          .inDays;
      return "${heatCellData.number}\n回数: ${heatCellData.count}回\n次回復習: $nextReviewAt日後";
    }
  }

  Widget heatCell(HeatCellData heatCellData, double level) {
    final percent = (level * 100).round();
    Color color = Colors.grey.withOpacity(0.1);
    if (level != 0) {
      color = Colors.green.withOpacity(percent / 100);
    }
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: Tooltip(
        message: toolTipText(heatCellData),
        triggerMode: TooltipTriggerMode.tap,
        child: Container(
          alignment: Alignment.center,
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            // color: Colors.grey.shade200,
            color: color,
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: cellNumberText(heatCellData.number),
        ),
      ),
    );
  }
}

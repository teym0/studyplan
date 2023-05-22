import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:leadstudy/stream/provider.dart';
import 'package:leadstudy/view_model/add_record_from_goal_view_model.dart';
import 'package:leadstudy/view_model/record_view_model.dart';

import '../../model/book_model.dart';
import '../../model/goal_model.dart';
import 'add_record_page.dart';

Widget addRecordFromGoalTabView(
    BuildContext context, WidgetRef ref, Book book, Goal? goal) {
  final goalCells = ref.watch(goalCellsProvider);
  final durationControllerProvider = ref.watch(durationControllerStateProvider);
  if (goal == null) {
    return const Center(child: Text("目標の選択は準備中です。"));
  }
  return GestureDetector(
    onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
    child: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: durationControllerProvider,
              inputFormatters: [
                LengthLimitingTextInputFormatter(5),
                FilteringTextInputFormatter.digitsOnly,
              ],
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "時間(分)",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    ref.read(goalCellsProvider.notifier).checkTodayTask(goal);
                  },
                  label: const Text("今日分選択"),
                  icon: const Icon(Icons.check),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    ref.read(goalCellsProvider.notifier).uncheckAll();
                  },
                  label: const Text("全選択解除"),
                  icon: const Icon(Icons.remove),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            goalCells.when(
              data: (data) {
                final checkedCount =
                    data.where((goalCell) => goalCell.checked).length;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FutureBuilder(
                        future: ref
                            .read(goalsServiceProvider)
                            .getTaskInformationFromGoal(goal),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Text(
                              "選択中: $checkedCount/${snapshot.data!.item1.length}",
                              style: const TextStyle(fontSize: 18),
                            );
                          }
                          return Text(
                            "選択中: $checkedCount/$checkedCount",
                            style: const TextStyle(fontSize: 18),
                          );
                        }),
                    const SizedBox(
                      height: 20,
                    ),
                    GridView.builder(
                      // scrollDirection: Axis.vertical,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 10),
                      itemCount: data.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return _heatCell(ref, data[index]);
                      },
                    ),
                  ],
                );
              },
              error: (error, stackTrace) => const Text("Error!"),
              loading: () => const CircularProgressIndicator(),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FilledButton.icon(
                  onPressed: () {
                    final records =
                        ref.read(goalCellsProvider.notifier).getCheckedRecords(
                              book,
                              int.parse(durationControllerProvider.text),
                            );
                    ref.read(recordListProvider.notifier).addItems(records);
                    Navigator.of(context).pop();
                  },
                  label: const Text("記録する"),
                  icon: const Icon(Icons.save_outlined),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}

Widget _heatCell(WidgetRef ref, GoalCell cellData) {
  Color color = Colors.grey.withOpacity(0.1);
  if (cellData.done) {
    color = Colors.green;
  }
  if (cellData.checked) {
    color = Colors.pink.shade200;
  }
  return GestureDetector(
    onTap: () {
      ref.read(goalCellsProvider.notifier).tapNumber(cellData.number);
    },
    child: Padding(
      padding: const EdgeInsets.all(3.0),
      child: Container(
        alignment: Alignment.center,
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          // color: Colors.grey.shade200,
          color: color,
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: _cellNumberText(cellData.number),
      ),
    ),
  );
}

Widget _cellNumberText(int number) {
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

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:leadstudy/component/constants.dart';
import 'package:leadstudy/stream/provider.dart';

import '../../model/book_model.dart';

final goalRatioBoardProvider = StateProvider.autoDispose<List<int>>((ref) {
  return [1, 1, 1, 1, 1, 1, 1];
});

final rangeProvider = StateProvider.autoDispose<int>((ref) => 0);

final weekdayCountProvider = StateProvider.autoDispose<int>((ref) {
  final endDate = ref.watch(endDateProvider);
  final goalService = ref.watch(goalsServiceProvider);
  final goalRatioBoardData = ref.watch(goalRatioBoardProvider);
  final weekdaycount = goalService.getOriginalRemainingDays(
      DateTime.now(), endDate, goalRatioBoardData);
  return weekdaycount;
});

final totalRatioCellCountProvider = StateProvider.autoDispose((ref) {
  final endDate = ref.watch(endDateProvider);
  final goalService = ref.watch(goalsServiceProvider);
  final goalRatioBoardData = ref.watch(goalRatioBoardProvider);
  final total = goalService.getTotalRatioUnitCount(
      DateTime.now(), endDate, goalRatioBoardData.join());
  return total;
});

final singleCellPagesProvider = StateProvider.autoDispose<int>((ref) {
  final range = ref.watch(rangeProvider);
  final weekdaycount = ref.watch(totalRatioCellCountProvider);
  if (weekdaycount == 0) {
    return range;
  }
  return (range / weekdaycount).floor();
});

final endDateProvider = StateProvider<DateTime>(
    (ref) => DateTime.now().add(const Duration(days: 7)));

Future<DateTime?> _selectDate(
    BuildContext context, DateTime initialDate) async {
  final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2000),
      lastDate: DateTime.now().add(const Duration(days: 360)));
  return picked;
}

Future<TimeOfDay?> _selectTime(
    BuildContext context, DateTime initialDate) async {
  final initialTime = TimeOfDay.fromDateTime(initialDate);
  final TimeOfDay? picked =
      await showTimePicker(context: context, initialTime: initialTime);
  return picked;
}

class CreateGoalArgument {
  Book book;
  CreateGoalArgument(this.book);
}

class CreateGoalPage extends ConsumerStatefulWidget {
  const CreateGoalPage({super.key, required this.args});
  final CreateGoalArgument args;

  @override
  ConsumerState<CreateGoalPage> createState() => _CreateGoalPageState();
}

class _CreateGoalPageState extends ConsumerState<CreateGoalPage> {
  final startController = TextEditingController();
  final lastController = TextEditingController();

  Widget goalRatioBoardCell(
      int weeknumber, int number, List<int> goalRatioBoardData) {
    final checked = number <= goalRatioBoardData[weeknumber];
    return GestureDetector(
      onTap: () {
        if (number == goalRatioBoardData[weeknumber]) {
          goalRatioBoardData[weeknumber] = 0;
        } else {
          goalRatioBoardData[weeknumber] = number;
        }
        ref.read(goalRatioBoardProvider.notifier).state = [
          ...goalRatioBoardData
        ];
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 4.0),
        child: Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            color: (checked)
                ? Theme.of(context).colorScheme.primary.withOpacity(0.8)
                : Theme.of(context).colorScheme.primary.withOpacity(0.2),
            borderRadius: BorderRadius.circular(5.0),
          ),
        ),
      ),
    );
  }

  Widget goalRatioBoardLine(
      int weeknumber, String dayoftheweek, List<int> goalRatioBoardData) {
    return Column(
      children: [
        goalRatioBoardCell(weeknumber, 8, goalRatioBoardData),
        goalRatioBoardCell(weeknumber, 7, goalRatioBoardData),
        goalRatioBoardCell(weeknumber, 6, goalRatioBoardData),
        goalRatioBoardCell(weeknumber, 5, goalRatioBoardData),
        goalRatioBoardCell(weeknumber, 4, goalRatioBoardData),
        goalRatioBoardCell(weeknumber, 3, goalRatioBoardData),
        goalRatioBoardCell(weeknumber, 2, goalRatioBoardData),
        goalRatioBoardCell(weeknumber, 1, goalRatioBoardData),
        Text(dayoftheweek),
      ],
    );
  }

  Widget goalRatioBoard() {
    final goalRatioBoardData = ref.watch(goalRatioBoardProvider);
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            goalRatioBoardLine(0, "Mon", goalRatioBoardData),
            goalRatioBoardLine(1, "Tue", goalRatioBoardData),
            goalRatioBoardLine(2, "Wed", goalRatioBoardData),
            goalRatioBoardLine(3, "Thu", goalRatioBoardData),
            goalRatioBoardLine(4, "Fri", goalRatioBoardData),
            goalRatioBoardLine(5, "Sat", goalRatioBoardData),
            goalRatioBoardLine(6, "Sun", goalRatioBoardData),
          ],
        ),
      ),
    );
  }

  void updateRange() {
    final start =
        int.parse(startController.text.isEmpty ? "0" : startController.text);
    final end =
        int.parse(lastController.text.isEmpty ? "0" : lastController.text);
    final pages = end - start + 1;
    ref.read(rangeProvider.notifier).state = pages;
  }

  @override
  Widget build(BuildContext context) {
    final endDate = ref.watch(endDateProvider);
    final singleCellPages = ref.watch(singleCellPagesProvider);
    final weekdaycount = ref.watch(weekdayCountProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("目標を立てる"),
      ),
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 5,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.numbers),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          Flexible(
                            child: TextField(
                              controller: startController,
                              onChanged: (_) {
                                updateRange();
                              },
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(5),
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                labelText: "開始",
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              "〜",
                              style: TextStyle(fontSize: 30),
                            ),
                          ),
                          Flexible(
                            child: TextField(
                              controller: lastController,
                              onChanged: (_) {
                                updateRange();
                              },
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(5),
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                labelText: "終了",
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.timer_outlined),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                DateFormat('yyyy年MM月dd日').format(endDate),
                                style: const TextStyle(fontSize: 20),
                              ),
                              IconButton(
                                  onPressed: () async {
                                    final DateTime? picked =
                                        await _selectDate(context, endDate);
                                    if (picked != null) {
                                      ref.read(endDateProvider.notifier).state =
                                          endDate.copyWith(
                                              year: picked.year,
                                              month: picked.month,
                                              day: picked.day);
                                    }
                                  },
                                  icon: const Icon(Icons.calendar_month)),
                            ],
                          ),
                          Text(
                            "実質日数: $weekdaycount日",
                            style: const TextStyle(fontSize: 20),
                          ),
                          Text(
                            "1マスあたり: $singleCellPages${widget.args.book.unitName}",
                            style: const TextStyle(fontSize: 20),
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                goalRatioBoard(),
                const SizedBox(height: 18),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    FilledButton.icon(
                      onPressed: () {
                        final goalRatioBoard = ref.read(goalRatioBoardProvider);
                        if (goalRatioBoard.every((element) => element == 0)) {
                          context.showErrorSnackBar(
                              message: "最低1日は比率を1以上に指定してください。");
                          return;
                        }
                        ref.read(goalsServiceProvider).addItem(
                              widget.args.book,
                              startController.text,
                              lastController.text,
                              endDate,
                              goalRatioBoard.join().toString(),
                            );
                        Navigator.of(context).pop();
                      },
                      label: const Text("設定する"),
                      icon: const Icon(Icons.save_outlined),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

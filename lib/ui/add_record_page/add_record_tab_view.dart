import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:leadstudy/model/book_model.dart';
import 'package:leadstudy/ui/add_record_page/add_record_page.dart';
import 'package:leadstudy/view_model/record_view_model.dart';

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

Widget addRecordTabView(BuildContext context, WidgetRef ref, Book book) {
  final startControllerProvider = ref.watch(startControllerStateProvider);
  final lastControllerProvider = ref.watch(lastControllerStateProvider);
  final durationControllerProvider = ref.watch(durationControllerStateProvider);
  final datetimeControllerProvider = ref.watch(datetimeStateProvider);

  return GestureDetector(
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
                          controller: startControllerProvider,
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
                          controller: lastControllerProvider,
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
                      TextField(
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
                      const SizedBox(height: 20),
                      const Text("開始時刻"),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            DateFormat('yyyy年MM月dd日')
                                .format(datetimeControllerProvider),
                            style: const TextStyle(fontSize: 20),
                          ),
                          IconButton(
                              onPressed: () async {
                                final DateTime? picked = await _selectDate(
                                    context, datetimeControllerProvider);
                                if (picked != null) {
                                  ref
                                          .read(datetimeStateProvider.notifier)
                                          .state =
                                      datetimeControllerProvider.copyWith(
                                          year: picked.year,
                                          month: picked.month,
                                          day: picked.day);
                                }
                              },
                              icon: const Icon(Icons.calendar_month)),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            DateFormat('kk時mm分')
                                .format(datetimeControllerProvider),
                            style: const TextStyle(fontSize: 20),
                          ),
                          IconButton(
                              onPressed: () async {
                                final TimeOfDay? picked = await _selectTime(
                                    context, datetimeControllerProvider);
                                if (picked != null) {
                                  ref
                                          .read(datetimeStateProvider.notifier)
                                          .state =
                                      datetimeControllerProvider.copyWith(
                                          hour: picked.hour,
                                          minute: picked.minute);
                                }
                              },
                              icon: const Icon(Icons.watch)),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FilledButton.icon(
                  onPressed: () {
                    final startedAt = ref.read(datetimeStateProvider);
                    ref.read(recordListProvider.notifier).addRecord(
                          startControllerProvider.text,
                          lastControllerProvider.text,
                          durationControllerProvider.text,
                          book,
                          startedAt,
                        );
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

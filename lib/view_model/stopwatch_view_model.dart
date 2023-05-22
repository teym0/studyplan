import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:leadstudy/ui/add_record_page/add_record_page.dart';

final addRecordProvider =
    StateNotifierProvider.autoDispose<StopwatchViewModel, StopwatchModel>(
        (ref) {
  return StopwatchViewModel(ref);
});

class StopwatchViewModel extends StateNotifier<StopwatchModel> {
  StopwatchViewModel(this.ref) : super(_initialState);
  static final _initialState = StopwatchModel(
      working: false, started: null, time: "00:00:00", historySeconds: 0);

  late Timer timer;
  final Ref ref;

  @override
  void dispose() {
    if (state.working) {
      timer.cancel();
    }
    super.dispose();
  }

  void sendToRecordTab() {
    if (state.working) {
      timer.cancel();
    }
    late Duration pastTime;
    if (state.started == null) {
      pastTime = Duration.zero;
    } else {
      pastTime = DateTime.now().difference(state.started!);
    }
    final minutes = (state.historySeconds / 60).floor() + pastTime.inMinutes;
    ref.read(durationControllerStateProvider.notifier).state.text =
        minutes.toString();
    state = StopwatchModel(
        working: false,
        time: state.time,
        historySeconds: state.historySeconds + pastTime.inSeconds);
  }

  void start() {
    // timer.cancel();
    if (state.working) {
      return;
    }
    state = StopwatchModel(
        working: true,
        started: DateTime.now(),
        time: _convertDuration(Duration(seconds: state.historySeconds)),
        historySeconds: state.historySeconds);
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _updateString();
    });
  }

  void stop() {
    if (!state.working) {
      reset();
    }
    timer.cancel();
    state = StopwatchModel(
        working: false,
        time: state.time,
        historySeconds: state.historySeconds +
            DateTime.now().difference(state.started!).inSeconds);
  }

  void reset() {
    state = StopwatchModel(
        working: false,
        time: "00:00:00",
        historySeconds: 0,
        started: DateTime.now());
  }

  void _updateString() {
    late String newTime;
    if (state.started == null) {
      newTime = _convertDuration(Duration(seconds: state.historySeconds));
    } else {
      newTime = _convertDuration(DateTime.now().difference(state.started!) +
          Duration(seconds: state.historySeconds));
    }

    state = StopwatchModel(
        working: state.working,
        started: state.started,
        time: newTime,
        historySeconds: state.historySeconds);
  }

  String _convertDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }
}

class StopwatchModel {
  final bool working;
  final DateTime? started;
  final String time;
  final int historySeconds;

  StopwatchModel(
      {required this.working,
      this.started,
      required this.time,
      required this.historySeconds});
}

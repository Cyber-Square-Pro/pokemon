import 'dart:async';

import 'package:flutter/material.dart';

class TimerProvider extends ChangeNotifier {
  late StreamController<int> _timerController;
  late Stream<int> timerStream;
  late Timer _timer;

  int initialTimeInSeconds = 180; // 3 minutes

  TimerProvider() {
    _timerController = StreamController<int>();
    timerStream = _timerController.stream.asBroadcastStream();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (initialTimeInSeconds > 0) {
        initialTimeInSeconds--;
        _timerController.add(initialTimeInSeconds);
        notifyListeners();
      } else {
        _timer.cancel();
        notifyListeners();
      }
    });

    notifyListeners();
  }

  void _stopTimer() {
    _timer.cancel();
    notifyListeners();
  }

  void restartTimer() {
    _stopTimer();
    initialTimeInSeconds = 180;
    _timerController.add(initialTimeInSeconds);
    _startTimer();
  }

  @override
  void dispose() {
    _timerController.close();
    super.dispose();
  }
}

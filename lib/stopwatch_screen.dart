import 'package:flutter/material.dart';

class StopwatchScreen extends StatefulWidget {
  const StopwatchScreen({super.key});

  @override
  State<StopwatchScreen> createState() => _StopwatchScreenState();
}

class _StopwatchScreenState extends State<StopwatchScreen> {
  int _elapsedMilliseconds = 0;
  bool _isTimerRunning = false;
  Stopwatch? _stopwatch;

  void _startTimer() {
    setState(() {
      _isTimerRunning = true;
    });

    _stopwatch ??= Stopwatch()..start();

    Future.delayed(const Duration(milliseconds: 10), () {
      if (_isTimerRunning) {
        setState(() {
          _elapsedMilliseconds = _stopwatch!.elapsedMilliseconds;
        });
        _startTimer();
      } else {
        _stopwatch!.stop();
      }
    });
  }

  void _stopTimer() {
    setState(() {
      _isTimerRunning = false;
    });
    _stopwatch?.stop();
  }

  void _resetTimer() {
    _stopTimer();
    setState(() {
      _elapsedMilliseconds = 0;
      _stopwatch?.reset();
    });
  }

  String _formatTime(int milliseconds) {
    final int seconds = (milliseconds / 1000).floor();
    final int remainingMilliseconds = milliseconds - (seconds * 1000);
    final String secondsStr = seconds.toString().padLeft(2, '0');
    final String millisecondsStr =
        remainingMilliseconds.toString().padLeft(3, '0');
    return '$secondsStr.$millisecondsStr s';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _formatTime(_elapsedMilliseconds),
              style: const TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: _isTimerRunning ? null : _startTimer,
                  child: const Text('Start'),
                ),
                ElevatedButton(
                  onPressed: _isTimerRunning ? _stopTimer : null,
                  child: const Text('Stop'),
                ),
                ElevatedButton(
                  onPressed: _resetTimer,
                  child: const Text('Clear'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class StopwatchScreen extends StatefulWidget {
  const StopwatchScreen({super.key});

  @override
  State<StopwatchScreen> createState() => _StopwatchScreenState();
}

class _StopwatchScreenState extends State<StopwatchScreen> {
  int _elapsedSeconds = 0;
  bool _isTimerRunning = false;

  void _startTimer() {
    setState(() {
      _isTimerRunning = true;
    });

    Future.delayed(const Duration(seconds: 1), () {
      if (_isTimerRunning) {
        setState(() {
          _elapsedSeconds++;
        });
        _startTimer();
      }
    });
  }

  void _stopTimer() {
    setState(() {
      _isTimerRunning = false;
    });
  }

  void _resetTimer() {
    _stopTimer();
    setState(() {
      _elapsedSeconds = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '$_elapsedSeconds s',
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

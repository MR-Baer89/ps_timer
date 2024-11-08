import 'package:flutter/material.dart';

class TimerScreen extends StatefulWidget {
  const TimerScreen({super.key});

  @override
  TimerScreenState createState() => TimerScreenState();
}

class TimerScreenState extends State<TimerScreen> {
  int _remainingSeconds = 0;
  bool _isTimerRunning = false;
  final TextEditingController _durationController = TextEditingController();

  void _startTimer() {
    final durationInSeconds = int.tryParse(_durationController.text);
    if (durationInSeconds == null || durationInSeconds <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Bitte eine gültige Dauer eingeben')),
      );
      return;
    }

    setState(() {
      _remainingSeconds = durationInSeconds;
      _isTimerRunning = true;
    });

    _runTimer();
  }

  Future<void> _runTimer() async {
    while (_isTimerRunning && _remainingSeconds > 0) {
      await Future.delayed(const Duration(seconds: 1));
      if (!_isTimerRunning) return;

      setState(() {
        _remainingSeconds--;
      });

      if (_remainingSeconds == 0) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Timer abgelaufen!')),
        );
        _isTimerRunning = false;
      }
    }
  }

  void _stopTimer() {
    setState(() {
      _isTimerRunning = false;
    });
  }

  void _clearTimer() {
    setState(() {
      _remainingSeconds = 0;
      _isTimerRunning = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _durationController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                  labelText: 'Dauer in Sekunden', border: OutlineInputBorder()),
            ),
            const SizedBox(height: 20),
            Text(
              'Verbleibende Zeit: ${(_remainingSeconds / 60).floor()}:'
              '${_remainingSeconds % 60}',
              style: const TextStyle(fontSize: 24),
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
                  onPressed: _clearTimer,
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

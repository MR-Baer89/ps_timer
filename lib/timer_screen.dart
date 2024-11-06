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

  Future<void> _startTimer() async {
    setState(() {
      _isTimerRunning = true;
    });

    final durationInSeconds = int.tryParse(_durationController.text) ?? 0;
    for (int i = durationInSeconds; i >= 0; i--) {
      await Future.delayed(const Duration(seconds: 1));
      setState(() {
        _remainingSeconds = i;
      });
      if (i == 0) {
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
              ],
            ),
          ],
        ),
      ),
    );
  }
}

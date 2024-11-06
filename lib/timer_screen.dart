import 'dart:async';
import 'package:flutter/material.dart';

class TimerScreen extends StatefulWidget {
  const TimerScreen({super.key});

  @override
  TimerScreenState createState() => TimerScreenState();
}

class TimerScreenState extends State<TimerScreen> {
  int remainingSeconds = 0;
  Timer? timer;
  final TextEditingController durationController = TextEditingController();

  void startTimer() {
    final durationInSeconds = int.tryParse(durationController.text) ?? 0;
    remainingSeconds = durationInSeconds;

    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (remainingSeconds > 0) {
          remainingSeconds--;
        } else {
          timer.cancel();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Timer abgelaufen!')),
          );
        }
      });
    });
  }

  void stopTimer() {
    timer?.cancel();
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
              controller: durationController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                  labelText: 'Dauer in Sekunden', border: OutlineInputBorder()),
            ),
            const SizedBox(height: 20),
            Text(
              'Verbleibende Zeit: ${(remainingSeconds / 60).floor()}:'
              '${remainingSeconds % 60}',
              style: const TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: startTimer,
                  child: const Text('Start'),
                ),
                ElevatedButton(
                  onPressed: stopTimer,
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

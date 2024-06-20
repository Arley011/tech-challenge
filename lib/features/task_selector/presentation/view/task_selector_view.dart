import 'package:flutter/material.dart';
import 'package:hymate_test/features/challenge/presentation/view/challenge_view.dart';
import 'package:hymate_test/features/task_1/presentation/view/task_1_view.dart';

class TaskSelectorView extends StatelessWidget {
  const TaskSelectorView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'HyMate Test App by Artur',
        ),
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: const Text('Task 1'),
              onPressed: () => _handleTask1Pressed(context),
            ),
            const Padding(padding: EdgeInsets.symmetric(horizontal: 16)),
            ElevatedButton(
              child: const Text('Challenge'),
              onPressed: () => _handleChallengePressed(context),
            ),
          ],
        ),
      ),
    );
  }

  void _handleTask1Pressed(BuildContext context) {
    Navigator.of(context).push(Task1View.route());
  }

  void _handleChallengePressed(BuildContext context) {
    Navigator.of(context).push(ChallengeView.route());
  }
}

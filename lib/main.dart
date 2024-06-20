import 'package:flutter/material.dart';
import 'package:hymate_test/features/task_selector/presentation/view/task_selector_view.dart';

void main() {
  runApp(const HyMateTestApp());
}

class HyMateTestApp extends StatelessWidget {
  const HyMateTestApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'HyMate Test App',
      theme: ThemeData(
          colorScheme: ColorScheme.dark(
            primary: Colors.green,
            surface: Colors.green.withOpacity(0.2),
          ),
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.green.withOpacity(0.7),
            titleTextStyle: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.5,
              fontSize: 24,
            ),
          ),
          textTheme: const TextTheme(
            labelLarge: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.5,
              fontSize: 18,
            ),
          )),
      home: const TaskSelectorView(),
    );
  }
}

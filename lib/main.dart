import 'package:flutter/material.dart';
import 'package:kanban_issues_app/views/home_view.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      home: HomeView()
    );
  }
}

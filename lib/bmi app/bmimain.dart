import 'package:flutter/material.dart';

import 'bmihome1.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      color: Colors.purple,
      theme: ThemeData(
          colorScheme: const ColorScheme.dark()
              .copyWith(primary: Colors.purple, secondary: Colors.purpleAccent),
          textSelectionTheme:
              const TextSelectionThemeData(cursorColor: Colors.purple)),
      home: const Home(),
    );
  }
}

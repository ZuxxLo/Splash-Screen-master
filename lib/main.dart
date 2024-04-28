import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'Note it/home_page.dart';

void main() {
  runApp(const MyApp());
}

FlutterTts flutterTts = FlutterTts();

Future<void> configureTts() async {
  await flutterTts.setLanguage('en-US');
  await flutterTts.setSpeechRate(1.0);
  await flutterTts.setVolume(1.0);
}

void speakText(String text) async {
  await flutterTts.speak(text);
}

void stopSpeaking() async {
  await flutterTts.stop();
}

final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Salatuk',
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      navigatorObservers: [routeObserver],
      //  theme: ThemeData.dark(),
      home: const HomePage(),
    );
  }
}

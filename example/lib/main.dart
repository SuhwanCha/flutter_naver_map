import 'package:example/path_example.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const FlutterNaverMapExampleScreen(),
    );
  }
}

class FlutterNaverMapExampleScreen extends StatelessWidget {
  const FlutterNaverMapExampleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Naver Map Example'),
      ),
      body: const PathExample(),
    );
  }
}

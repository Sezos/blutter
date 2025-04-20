import 'package:flutter/material.dart';
import 'package:blutter/blutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const BText('My Flutter Package Example')),
        body: const Center(
          child: BText(
            "Do i really need to do this? \t - No\n am i gonna do it anyways? - Absolutely",
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'screens/canvas_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Asteroid Bomber',
      debugShowCheckedModeBanner: false,
      home: CanvasView(),
    );
  }
}

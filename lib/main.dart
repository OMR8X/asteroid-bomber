import 'package:flutter/material.dart';

import 'screens/rocket_drag.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Asteroid Bomber',
      debugShowCheckedModeBanner: false,
      home: RocketDragView(),
    );
  }
}

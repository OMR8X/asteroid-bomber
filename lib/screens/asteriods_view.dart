import 'package:asteroid_bomber/resources/colors_resources.dart';
import 'package:flutter/material.dart';

class AsteroidsView extends StatefulWidget {
  const AsteroidsView({super.key});

  @override
  State<AsteroidsView> createState() => _AsteroidsViewState();
}

class _AsteroidsViewState extends State<AsteroidsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onPanUpdate: (details) {},
        onPanEnd: (details) {},
        onPanDown: (details) {},
        child: Container(
          color: ColorsResources.surface,
          child: const Stack(
            children: [],
          ),
        ),
      ),
    );
  }
}

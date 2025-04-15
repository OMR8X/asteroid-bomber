import 'package:asteroid_bomber/resources/colors_resources.dart';
import 'package:asteroid_bomber/screens/asteriods_view.dart';
import 'package:flutter/material.dart';

import 'rocket_drag.dart';

class CanvasView extends StatefulWidget {
  const CanvasView({super.key});

  @override
  State<CanvasView> createState() => _CanvasViewState();
}

class _CanvasViewState extends State<CanvasView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onPanUpdate: (details) {},
        onPanEnd: (details) {},
        onPanDown: (details) {},
        child: Container(
          color: ColorsResources.surface,
          child: Stack(
            children: [
              const AsteroidsView(),
              RocketDragView(),
            ],
          ),
        ),
      ),
    );
  }
}

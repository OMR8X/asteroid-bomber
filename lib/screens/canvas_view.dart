import 'package:asteroid_bomber/resources/colors_resources.dart';
import 'package:asteroid_bomber/screens/asteriods_view.dart';
import 'package:asteroid_bomber/screens/ship_view.dart';
import 'package:flutter/material.dart';

class CanvasView extends StatefulWidget {
  const CanvasView({super.key});

  @override
  State<CanvasView> createState() => _CanvasViewState();
}

class _CanvasViewState extends State<CanvasView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsResources.surface,
      body: GestureDetector(
        onPanUpdate: (details) {},
        onPanEnd: (details) {},
        onPanDown: (details) {},
        child: Container(
          color: ColorsResources.surface,
          child: const Stack(
            children: [
              AsteroidsView(),
              ShipView(),
            ],
          ),
        ),
      ),
    );
  }
}

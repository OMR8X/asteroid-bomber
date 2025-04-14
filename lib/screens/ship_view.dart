import 'package:asteroid_bomber/resources/colors_resources.dart';
import 'package:flutter/material.dart';

class ShipView extends StatefulWidget {
  const ShipView({super.key});

  @override
  State<ShipView> createState() => _ShipViewState();
}

class _ShipViewState extends State<ShipView> {
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

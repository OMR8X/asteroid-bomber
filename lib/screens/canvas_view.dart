import 'package:asteroid_bomber/resources/colors_resources.dart';
import 'package:asteroid_bomber/screens/asteriods_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/game_bloc/game_bloc.dart';
import '../widgets/rocket_drag_widget.dart';

class CanvasView extends StatefulWidget {
  const CanvasView({super.key});

  @override
  State<CanvasView> createState() => _CanvasViewState();
}

class _CanvasViewState extends State<CanvasView> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GameBloc(),
      child: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Container(
            color: ColorsResources.surface,
            child: Stack(
              children: [
                const AsteroidsView(),
                RocketDragWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

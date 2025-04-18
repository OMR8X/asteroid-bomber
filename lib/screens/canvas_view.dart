import 'package:asteroid_bomber/resources/colors_resources.dart';
import 'package:asteroid_bomber/screens/asteriods_view.dart';
import 'package:asteroid_bomber/widgets/background_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/rocket_bloc/rocket_bloc.dart';
import '../injection/app_inj.dart';
import '../widgets/rocket_drag_widget.dart';

class CanvasView extends StatefulWidget {
  const CanvasView({super.key});

  @override
  State<CanvasView> createState() => _CanvasViewState();
}

class _CanvasViewState extends State<CanvasView> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: sl<RocketBloc>(),
      child: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Container(
            child: Stack(
              children: [
                BackTo(),
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

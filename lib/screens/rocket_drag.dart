import 'package:asteroid_bomber/blocs/rocket_drag_bloc/rocket_bloc.dart';
import 'package:asteroid_bomber/resources/images_resources.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RocketDragView extends StatelessWidget {
  const RocketDragView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RocketBloc(),
      child: Scaffold(
        backgroundColor: Colors.black,
        body: BlocBuilder<RocketBloc, RocketState>(
          builder: (context, state) {
            return Stack(
              fit: StackFit.expand,
              children: <Widget>[
                Positioned(
                  left: state.position.dx,
                  top: state.position.dy,
                  child: GestureDetector(
                    onPanUpdate: (details) {
                      context
                          .read<RocketBloc>()
                          .add(RocketPositionUpdated(details.delta));
                    },
                    child: Image.asset(
                      ImagesResources.rocketImagePath,
                      width: 100,
                      height: 100,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

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
      child: BlocBuilder<RocketBloc, RocketState>(
        buildWhen: (previous, current) {
          // TODO: use build when
          // previous.position != current.position
          return true;
        },
        builder: (context, state) {
          return Stack(
            fit: StackFit.expand,
            children: <Widget>[
              Positioned(
                left: state.position.dx,
                // TODO: FREEZE THE ROCKET on vertical axes , rocket should only move horizontally
                top: state.position.dy,
                child: GestureDetector(
                  onPanUpdate: (details) {
                    // TODO: improvments
                    /*
                    ✅ 1. Throttle position updates
                    Reduce the number of events fired to BLoC using a cool-down timer:
                    DateTime? lastUpdate;
                    onPanUpdate: (details) {
                      final now = DateTime.now();
                      if (lastUpdate == null || now.difference(lastUpdate!) > Duration(milliseconds: 16)) {
                        lastUpdate = now;
                        context.read<RocketBloc>().add(RocketPositionUpdated(details.delta));
                      }
                    },
                    This gives you roughly 60 updates per second (similar to screen refresh rate). 
                    */
                    context.read<RocketBloc>().add(RocketPositionUpdated(details.delta));
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
    );
  }
}

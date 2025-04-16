import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/rocket_drag_bloc/rocket_bloc.dart';

import '../../resources/images_resources.dart';
import '../../constants/layout_constants.dart';

class RocketDragWidget extends StatelessWidget {
  const RocketDragWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final screenSize = Size(constraints.maxWidth, constraints.maxHeight);
        return BlocProvider(
          create: (_) =>
              RocketBloc()..add(RocketScreenInitializedEvent(screenSize)),
          child: BlocBuilder<RocketBloc, RocketState>(
            builder: (context, state) {
              return GestureDetector(
                onPanUpdate: (details) {
                  final touchY = details.globalPosition.dy;
                  if (touchY < state.lowerBoundY) {
                    context.read<RocketBloc>().add(
                          RocketPositionUpdatedEvent(
                              Offset(details.delta.dx, 0)),
                        );
                  } else {
                    context.read<RocketBloc>().add(
                          RocketPositionUpdatedEvent(details.delta),
                        );
                  }
                },
                child: Stack(
                  children: [
                    AnimatedPositioned(
                      duration: const Duration(milliseconds: 50),
                      curve: Curves.easeOut,
                      left: state.position.dx,
                      top: state.position.dy,
                      child: Image.asset(
                        ImagesResources.rocketImagePath,
                        width: LayoutConstants.rocketSize.width,
                        height: LayoutConstants.rocketSize.height,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}

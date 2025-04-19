import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/rocket_bloc/rocket_bloc.dart';
import '../resources/images_resources.dart';
import '../constants/layout_constants.dart';

class RocketDragWidget extends StatelessWidget {
  const RocketDragWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          final rocketBloc = context.read<RocketBloc>();
          rocketBloc.add(RocketScreenInitializedEvent());
        });
        return BlocBuilder<RocketBloc, RocketState>(
          builder: (context, state) {
            return GestureDetector(
              onTapDown: (details) {
                final newX = details.localPosition.dx -
                    (LayoutConstants.rocketSize.width / 2);

                context.read<RocketBloc>().add(
                      RocketPositionChangedEvent(
                        Offset(newX, state.rocketPosition.dy),
                      ),
                    );
              },
              onPanUpdate: (details) {
                final localDx = details.localPosition.dx;
                final rocketWidth = LayoutConstants.rocketSize.width;

                final newX = localDx - rocketWidth / 2;
                context.read<RocketBloc>().add(
                      RocketPositionChangedEvent(
                          Offset(newX, state.rocketPosition.dy)),
                    );
              },
              child: Stack(
                children: [
                  ...state.bullets.map((pos) {
                    return Positioned(
                      left: pos.position.dx - 6,
                      top: pos.position.dy,
                      child: Image.asset(
                        ImagesResources.bulletImagePath,
                      ),
                    );
                  }),
                  Positioned(
                    left: state.rocketPosition.dx,
                    top: state.rocketPosition.dy,
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
        );
      },
    );
  }
}

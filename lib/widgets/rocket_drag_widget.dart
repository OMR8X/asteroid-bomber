import 'package:asteroid_bomber/widgets/bullet_painter_widget.dart';
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
        final screenSize = Size(constraints.maxWidth, constraints.maxHeight);

        WidgetsBinding.instance.addPostFrameCallback((_) {
          final rocketBloc = context.read<RocketBloc>();
          if (rocketBloc.state.screenSize == Size.zero) {
            rocketBloc.add(RocketScreenInitializedEvent(screenSize));
          }
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
                  CustomPaint(
                    size: screenSize,
                    painter: BulletPainter(
                      state.bullets.map((b) => b.position).toList(),
                    ),
                  ),
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

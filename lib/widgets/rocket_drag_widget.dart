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
                final newX = details.localPosition.dx - (LayoutConstants.rocketSize.width / 2);

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
                      RocketPositionChangedEvent(Offset(newX, state.rocketPosition.dy)),
                    );
              },
              child: Stack(
                children: [
                  ...state.bullets.map((pos) {
                    final left = pos.position.dx;
                    final top = pos.position.dy;
                    if (pos.isExploding && pos.explosionStartTime != null) {
                      final progress = DateTime.now().difference(pos.explosionStartTime!).inMilliseconds / 200;
                      final size = 40 * (1 - progress.clamp(0.0, 1.0));
                      return Positioned(
                        left: left - size / 4,
                        top: top,
                        child: Container(
                          width: size / 2,
                          height: size / 2,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.orange,
                          ),
                        ),
                      );
                    } else {
                      return Positioned(
                        left: pos.position.dx - 6,
                        top: pos.position.dy,
                        child: Image.asset(
                          ImagesResources.bulletImagePath,
                        ),
                      );
                    }
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

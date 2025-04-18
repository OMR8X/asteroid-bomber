import 'package:asteroid_bomber/blocs/background_bloc/background_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScrollingBackgroundView extends StatelessWidget {
  const ScrollingBackgroundView({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return BlocBuilder<BackgroundBloc, BackgroundState>(
      builder: (context, state) {
        double scrollValue = 0.0;

        if (state is BackgroundScrollInProgress) {
          scrollValue = state.scrollValue;
        }

        return Stack(
          children: [
            Positioned(
              top: scrollValue * height,
              left: 0,
              right: 0,
              child: Image.asset(
                'assets/images/stardust.png',
                fit: BoxFit.cover,
                width: width,
                height: height,
              ),
            ),
            Positioned(
              top: (scrollValue * height) - height,
              left: 0,
              right: 0,
              child: Image.asset(
                'assets/images/stardust.png',
                fit: BoxFit.cover,
                width: width,
                height: height,
              ),
            ),
          ],
        );
      },
    );
  }
}

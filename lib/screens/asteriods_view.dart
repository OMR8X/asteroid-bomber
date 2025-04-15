import 'dart:async';
import 'dart:math';

import 'package:asteroid_bomber/blocs/asteriods_bloc/asteriods_bloc.dart';
import 'package:asteroid_bomber/resources/colors_resources.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AsteroidsView extends StatefulWidget {
  const AsteroidsView({super.key});

  @override
  State<AsteroidsView> createState() => _AsteroidsViewState();
}

class _AsteroidsViewState extends State<AsteroidsView> {
  late AsteroidsBloc asteroidsBloc;
  late Timer asteroidTimer;

  @override
  void initState() {
    super.initState();
    asteroidsBloc = AsteroidsBloc();
    asteroidsBloc.add(AddAsteroidEvent());
    asteroidTimer = Timer.periodic(Duration(milliseconds: 300), (timer) {
      asteroidsBloc.add(UpdateAsteroidEvent());
      // 10%
      if (Random().nextInt(100) < 10) {
        asteroidsBloc.add(AddAsteroidEvent());
      }
    });
  }

  @override
  void dispose() {
    asteroidTimer.cancel();
    asteroidsBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: asteroidsBloc,
      child: Container(
        color: Colors.transparent,
        child: Stack(
          children: [
            BlocBuilder<AsteroidsBloc, AsteroidsState>(
              builder: (context, state) {
                return Stack(
                  children: state.asteroids.map((asteroid) {
                    return AnimatedPositioned(
                      key: ValueKey(asteroid.id),
                      duration: Duration(milliseconds: 300),
                      curve: Curves.linear,
                      left: asteroid.line * (MediaQuery.sizeOf(context).width / 7),
                      top: asteroid.position,
                      child: SizedBox(
                        width: 50,
                        height: 50,
                        child: Image.asset(asteroid.imagePath),
                      ),
                    );
                  }).toList(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

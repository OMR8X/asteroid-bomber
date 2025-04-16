import 'dart:async';
import 'dart:math';

import 'package:asteroid_bomber/blocs/asteriods_bloc/asteriods_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../resources/asteroids_resources.dart';

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
    int noAsteroids = 0;
    asteroidTimer = Timer.periodic(Duration(milliseconds: 300), (timer) {

      asteroidsBloc.add(UpdateAsteroidEvent(screenHeight: MediaQuery.sizeOf(context).height));
      if (Random().nextInt(100) < (100 - noAsteroids * (100 / AsteroidsResources.maxNoAsteroids))) {
        asteroidsBloc.add(AddAsteroidEvent());
        noAsteroids = asteroidsBloc.state.asteroids.length;
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
                      left: asteroid.line * (MediaQuery.sizeOf(context).width / AsteroidsResources.maxNoLine),
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

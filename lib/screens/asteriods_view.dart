import 'dart:async';
import 'dart:math';

import 'package:asteroid_bomber/blocs/asteriods_bloc/asteriods_bloc.dart';
import 'package:asteroid_bomber/injection/app_inj.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../resources/asteroids_resources.dart';

class AsteroidsView extends StatefulWidget {
  const AsteroidsView({super.key});

  @override
  State<AsteroidsView> createState() => _AsteroidsViewState();
}

class _AsteroidsViewState extends State<AsteroidsView> with SingleTickerProviderStateMixin {
  late Timer asteroidTimer;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      sl<AsteroidsBloc>().add(AddAsteroidEvent());
    });
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();
  }

  @override
  void dispose() {
    asteroidTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: sl<AsteroidsBloc>(),
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
                      child: RotationTransition(
                        turns: _controller,
                        child: SizedBox(
                          width: 50,
                          height: 50,
                          child: Image.asset(asteroid.imagePath),
                        ),
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

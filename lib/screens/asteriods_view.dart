import 'dart:async';

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
                    final left = (asteroid.line - 0.5) * (MediaQuery.sizeOf(context).width / AsteroidsResources.maxNoLine) - 25;
                    final top = asteroid.position;

                    if (asteroid.isExploding && asteroid.explosionStartTime != null) {
                      final progress = DateTime.now().difference(asteroid.explosionStartTime!).inMilliseconds / 200;
                      final size = 50 + 30 * (0.5 - (progress - 0.5).abs()); // تكبر وتصغر

                      return Positioned(
                        key: ValueKey('explosion_${asteroid.id}'),
                        left: left,
                        top: top,
                        child: Container(
                          width: size,
                          height: size,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                        ),
                      );
                    } else {
                      return AnimatedPositioned(
                        key: ValueKey(asteroid.id),
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.linear,
                        left: left,
                        top: top,
                        child: RotationTransition(
                          turns: _controller,
                          child: SizedBox(
                            width: 50,
                            height: 50,
                            child: Image.asset(asteroid.imagePath),
                          ),
                        ),
                      );
                    }
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

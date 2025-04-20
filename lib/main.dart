import 'dart:async';
import 'package:asteroid_bomber/blocs/background_sounds_bloc/background_sounds_bloc.dart';
import 'package:flutter/material.dart';
import 'blocs/asteriods_bloc/asteriods_bloc.dart';
import 'blocs/rocket_bloc/rocket_bloc.dart';
import 'constants/layout_constants.dart';
import 'injection/app_inj.dart';
import 'models/screen_size.dart';
import 'screens/canvas_view.dart';

Timer? updateFramesTimer;
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  initGetIt();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context, child) {
        if (!sl.isRegistered<ScreenSize>()) {
          sl.registerSingleton(ScreenSize(
            width: MediaQuery.sizeOf(context).width,
            height: MediaQuery.sizeOf(context).height,
          ));
        }
        if (updateFramesTimer == null) {
          startUpdateFramesTimer();
        }
        return child!;
      },
      title: 'Asteroid Bomber',
      debugShowCheckedModeBanner: false,
      home: CanvasView(),
    );
  }
}

int noAsteroids = 0;
startUpdateFramesTimer() {
  updateFramesTimer = Timer.periodic(const Duration(milliseconds: 33), (timer) {
    //  laeth Bloc
    sl<AsteroidsBloc>().add(UpdateAsteroidEvent());
    // about bloc
    sl<RocketBloc>().add(BulletsUpdatedEvent());
    //
    if (timer.tick % 8 == 0) {
      final rocketTipX = sl<RocketBloc>().state.rocketPosition.dx + (LayoutConstants.rocketSize.width / 2);
      final rocketTipY = sl<RocketBloc>().state.rocketPosition.dy;
      sl<RocketBloc>().add(BulletFiredEvent(Offset(rocketTipX, rocketTipY)));
    }
  });
}

/// [Branch]
/// [ main , asteroids_improvement ]
/// [git push origin asteroids_improvement]
///
/// [ ***GIT COMMANDS*** ]
///
/// [ GIT ADD & COMMIT ]
/// git commit -am "MESSAGE"
/// [ GIT PUSH TO SPECIFIC BRANCH ]
/// git push origin "NAME"
///
/// [EXPLORE BRANCHes]
/// git branch
/// [CREATE BRANCH]
/// git branch "NAME"
/// [SWITCH TO BRANCH]
/// git checkout "NAME"
/// [CREATE & SWITCH TO NEW BRANCH]
/// git checkout -b "NAME"
/// [DELETE BRANCH]
/// git branch -D "NAME"
/// [SWITCH TO REMOTE BRANCH]
/// git checkout --track origin/"NAME"

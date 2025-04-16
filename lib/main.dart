import 'package:flutter/material.dart';

import 'screens/canvas_view.dart';
import 'widgets/rocket_drag_widget.dart';
import 'screens/asteriods_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Asteroid Bomber',
      debugShowCheckedModeBanner: false,
      home: CanvasView(),
    );
  }
}
/// [Branch]
/// [ main , asteroids_improvement ]
/// [git push origin asteroids_improvement]
///
///
///
///
///
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
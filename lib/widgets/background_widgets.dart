import 'package:asteroid_bomber/blocs/background_bloc/background_bloc.dart';
import 'package:asteroid_bomber/screens/background_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// Update this to your correct import path

class BackTo extends StatelessWidget {
  const BackTo({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => BackgroundBloc()..add(const StartBackgroundScroll()),
      child: const ScrollingBackgroundView(),
    );
  }
}

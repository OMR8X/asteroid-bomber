import 'package:asteroid_bomber/blocs/asteriods_bloc/asteriods_bloc.dart';

import '../blocs/background_sounds_bloc/background_sounds_bloc.dart';
import '../blocs/rocket_bloc/rocket_bloc.dart';
import 'app_inj.dart';

controllerInj() {
  sl.registerSingleton(AsteroidsBloc());
  sl.registerSingleton(RocketBloc());
  sl.registerSingleton(BackgroundSoundsBloc());
}

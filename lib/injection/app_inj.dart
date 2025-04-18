import 'package:asteroid_bomber/injection/controller_inj.dart';
import 'package:get_it/get_it.dart';

var sl = GetIt.instance;
initGetIt() async {
  // register controllers
  controllerInj();
}

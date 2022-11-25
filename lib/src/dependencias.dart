import 'package:get_it/get_it.dart';
import 'package:state_project/src/pages/home/controller/home_controller.dart';
import 'package:state_project/src/pages/home/repositorios/home_repository.dart';

GetIt di = GetIt.I;

void registerDependencies() {
  //
  di.registerLazySingleton<HomeRepository>(() => HomeRepository());
  di.registerLazySingleton<HomeController>(() => HomeController(di.get()));
}

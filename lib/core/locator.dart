import 'package:app_trabalho/themes/theme_model.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

void setupDependencies() {
  locator.registerSingleton<ThemeModel>(ThemeModel());
}

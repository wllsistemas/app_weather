import 'package:app_trabalho/themes/enums.dart';
import 'package:app_trabalho/themes/theme_green.dart';
import 'package:app_trabalho/themes/theme_purple.dart';
import 'package:app_trabalho/themes/theme_red.dart';
import 'package:app_trabalho/themes/theme_blue.dart';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class ThemeModel extends ChangeNotifier {
  ThemeData _currentTheme = themePurple;

  ThemeData get currentTheme => _currentTheme;

  ThemeModel() {
    updateTheme();
  }

  updateTheme() {
    _currentTheme = getThemeCustom();
    notifyListeners();
  }

  ThemeData getThemeCustom() {
    final box = GetStorage();
    final themeColor = strToEnumTema(box.read('tema') ?? 'Purple');

    final result = switch (themeColor) {
      ColorTema.blue => themeBlue,
      ColorTema.red => themeRed,
      ColorTema.green => themeGreen,
      _ => themePurple,
    };
    return result;
  }

  ColorTema strToEnumTema(String? value) {
    final result = switch (value) {
      'Blue' => ColorTema.blue,
      'Red' => ColorTema.red,
      'Green' => ColorTema.green,
      'Purple' => ColorTema.purple,
      _ => ColorTema.purple,
    };
    return result;
  }
}

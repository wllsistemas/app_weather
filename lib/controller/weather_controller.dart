import 'package:app_trabalho/core/constants.dart';
import 'package:app_trabalho/core/locator.dart';
import 'package:app_trabalho/provider/weather_provider.dart';
import 'package:app_trabalho/themes/theme_model.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class WeatherController extends ChangeNotifier {
  String description = '';
  int temp = 0;
  bool isLoading = false;
  final box = GetStorage();

  final WeatherProvider provider;

  WeatherController({required this.provider});

  void themeModify() {
    if (temp <= Constants.limiteTemperaturaBaixa) {
      box.write('tema', 'Blue');
    } else if (temp >= Constants.limiteTemperaturaAlta) {
      box.write('tema', 'Red');
    } else {
      box.write('tema', 'Green');
    }
    locator.get<ThemeModel>().updateTheme();
  }

  Future getWeatherApi(String cityName) async {
    try {
      description = '';
      temp = 0;

      isLoading = true;
      notifyListeners();

      var codeCity = await provider.getRequestCodeCity(cityName);

      if (codeCity == null) {
        isLoading = false;
        notifyListeners();
        return;
      }

      var json = await provider.getRequestWeather(codeCity);

      description = json?.data['results']['description'];
      temp = json?.data['results']['temp'];
      themeModify();
      isLoading = false;

      notifyListeners();
    } catch (e) {
      isLoading = false;
      print(e);
    }
  }
}

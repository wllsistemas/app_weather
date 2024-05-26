import 'package:dio/dio.dart';

class WeatherProvider {
  Dio dio = Dio();

  initDio() {
    dio.options.connectTimeout = const Duration(seconds: 5);
    dio.options.receiveTimeout = const Duration(seconds: 10);
  }

  final endPointWeather =
      'https://api.hgbrasil.com/weather/?format=json-cors&key=development&woeid={code}';
  final endPointCodeCity =
      'https://api.hgbrasil.com/stats/find_woeid?key=17284dd0&format=json-cors&sdk_version=console&city_name={cidade}';

  Future<int?> getRequestCodeCity(String city) async {
    try {
      initDio();
      var url = endPointCodeCity.replaceAll('{cidade}', city);
      final response = await dio.get(url);

      return response.data['woeid'];
    } on DioException catch (e) {
      print(e);
    }

    return null;
  }

  Future<Response?> getRequestWeather(int codeCity) async {
    try {
      initDio();
      var url = endPointWeather.replaceAll('{code}', codeCity.toString());
      final response = await dio.get(url);

      return response;
    } on DioException catch (e) {
      print(e);
    }

    return null;
  }
}

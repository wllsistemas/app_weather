import 'package:app_trabalho/controller/weather_controller.dart';
import 'package:app_trabalho/core/constants.dart';
import 'package:app_trabalho/provider/weather_provider.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final WeatherProvider provider = WeatherProvider();
  late final WeatherController ctlWeatherController;
  final _formState = GlobalKey<FormState>();
  final TextEditingController _input = TextEditingController();

  @override
  void initState() {
    super.initState();
    ctlWeatherController = WeatherController(provider: provider);
  }

  @override
  void dispose() {
    super.dispose();
    ctlWeatherController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            buildForm(),
            const SizedBox(height: 20),
            buildButton(),
            const SizedBox(height: 20),
            buildAnimatedText(),
          ],
        ),
      ),
    );
  }

  Widget buildForm() {
    return Form(
      key: _formState,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: TextFormField(
          controller: _input,
          keyboardType: TextInputType.text,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.white,
          ),
          decoration: const InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(5)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(5)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(5)),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.yellow),
              borderRadius: BorderRadius.all(Radius.circular(5)),
            ),
            labelText: 'Consultar Cidade',
            labelStyle: TextStyle(color: Colors.white),
            errorStyle: TextStyle(color: Colors.yellow),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Informe a Cidade !';
            }
            return null;
          },
        ),
      ),
    );
  }

  Widget buildButton() {
    return ElevatedButton.icon(
      onPressed: () async {
        if (_formState.currentState!.validate()) {
          await ctlWeatherController.getWeatherApi(_input.text);
        }
      },
      label: const Text('Consultar Temperatura'),
      icon: const Icon(Icons.refresh),
    );
  }

  Widget buildAnimatedText() {
    return AnimatedBuilder(
      animation: ctlWeatherController,
      builder: (_, child) {
        return ctlWeatherController.isLoading
            ? const CircularProgressIndicator(
                color: Colors.white,
              )
            : ctlWeatherController.description.isEmpty
                ? Container()
                : Column(
                    children: [
                      const Text(
                        'Frio: abaixo de ${Constants.limiteTemperaturaBaixa} ºC',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      const Text(
                        'Agradável: ${Constants.limiteTemperaturaBaixa} ºC até ${Constants.limiteTemperaturaAlta} ºC',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      const Text(
                        'Quente: acima de ${Constants.limiteTemperaturaAlta} ºC',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 15),
                      Text(
                        'Temperatura ${ctlWeatherController.temp.toString()} ºC',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                        ),
                      ),
                      const SizedBox(height: 15),
                      Text(
                        ctlWeatherController.description,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                        ),
                      ),
                    ],
                  );
      },
    );
  }
}

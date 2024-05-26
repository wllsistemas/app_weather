import 'package:app_trabalho/app.dart';
import 'package:app_trabalho/core/locator.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  await GetStorage.init();

  setupDependencies();

  runApp(const MyApp());
}

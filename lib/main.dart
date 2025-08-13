import 'package:flutter/material.dart';
import 'package:tramo_pos/app.dart';
import 'package:tramo_pos/di.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  runApp(const App());
}

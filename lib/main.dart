import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tramo_pos/app.dart';
import 'package:tramo_pos/di.dart';
import 'package:tramo_pos/features/auth/presentation/authCubit/auth_cubit.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  runApp(BlocProvider(create: (_) => getIt<AuthCubit>(), child: const App()));
}

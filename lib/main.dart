import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tramo_pos/app.dart';
import 'package:tramo_pos/di.dart';
import 'package:tramo_pos/features/auth/presentation/authCubit/auth_cubit.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = AppBlocObserver();
  await initDependencies();
  runApp(BlocProvider.value(value: getIt<AuthCubit>(), child: const App()));
}

class AppBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    // ignore: avoid_print
    print('${bloc.runtimeType} -> $change');
    super.onChange(bloc, change);
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tramo_pos/core/config/router/app_router.dart';
import 'package:tramo_pos/di.dart';
import 'package:tramo_pos/features/auth/presentation/authCubit/auth_cubit.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocListener<AuthCubit, AuthState>(
      bloc: getIt<AuthCubit>(),
      listenWhen: (prev, curr) => curr is AuthAuthenticated || curr is AuthUnauthenticated,
      listener: (context, state) {
        final next = (state is AuthAuthenticated) ? AppRoutes.products : AppRoutes.signIn;

        Navigator.of(context).pushNamedAndRemoveUntil(next, (route) => false);
      },
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 8),
              Text('Cargando...', style: theme.textTheme.bodyMedium),
              const SizedBox(height: 12),
              const CircularProgressIndicator(),
            ],
          ),
        ),
      ),
    );
  }
}

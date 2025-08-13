import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tramo_pos/core/config/router/app_router.dart';
import 'package:tramo_pos/features/auth/presentation/authCubit/auth_cubit.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  bool _navigated = false;

  @override
  void initState() {
    super.initState();
    _decideNext();
  }

  void _decideNext() {
    final authState = context.read<AuthCubit>().state;

    final next = (authState is AuthAuthenticated) ? AppRoutes.products : AppRoutes.signIn;

    Future.microtask(() {
      if (!mounted || _navigated) return;
      _navigated = true;
      Navigator.of(context).pushNamedAndRemoveUntil(next, (_) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
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
    );
  }
}

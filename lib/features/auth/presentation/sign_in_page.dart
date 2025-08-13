import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tramo_pos/core/config/router/app_router.dart';
import 'package:tramo_pos/core/helper/app_navigator.dart';
import 'package:tramo_pos/di.dart';
import 'package:tramo_pos/features/auth/presentation/signInCubit/sign_in_form_cubit.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return BlocProvider<SignInFormCubit>(
      create: (_) => getIt<SignInFormCubit>(),
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          body: SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                final isWide = constraints.maxWidth >= 720;
                final cardMaxWidth = isWide ? 480.0 : 560.0;

                return Center(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: cardMaxWidth),
                      child: Card(
                        elevation: 1,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: BlocConsumer<SignInFormCubit, SignInFormState>(
                            listener: (context, state) {
                              if (state.isSuccess) {
                                // Navega al módulo de productos y reemplaza la pila.
                                context.pushReplacementNamed(AppRoutes.products);
                              } else if (state.error != null) {
                                ScaffoldMessenger.of(
                                  context,
                                ).showSnackBar(SnackBar(content: Text(state.error!)));
                              }
                            },
                            builder: (context, state) {
                              final cubit = context.read<SignInFormCubit>();

                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  // Header
                                  Row(
                                    children: [
                                      Container(
                                        width: 44,
                                        height: 44,
                                        decoration: BoxDecoration(
                                          color: colorScheme.primaryContainer,
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        child: Icon(
                                          Icons.store_rounded,
                                          color: colorScheme.onPrimaryContainer,
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text('Tramo POS', style: textTheme.titleLarge),
                                          Text(
                                            'Inicia sesión para continuar',
                                            style: textTheme.bodyMedium?.copyWith(
                                              color: Theme.of(context).hintColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 24),

                                  // Email
                                  Text('Correo', style: textTheme.labelLarge),
                                  const SizedBox(height: 6),
                                  TextFormField(
                                    enabled: !state.isLoading,
                                    textInputAction: TextInputAction.next,
                                    keyboardType: TextInputType.emailAddress,
                                    autofillHints: const [
                                      AutofillHints.username,
                                      AutofillHints.email,
                                    ],
                                    decoration: const InputDecoration(
                                      hintText: 'tu@correo.com',
                                      border: OutlineInputBorder(),
                                    ),
                                    onChanged: cubit.updateEmail,
                                  ),
                                  const SizedBox(height: 12),

                                  // Password
                                  Text('Contraseña', style: textTheme.labelLarge),
                                  const SizedBox(height: 6),
                                  TextFormField(
                                    enabled: !state.isLoading,
                                    obscureText: state.isObscure,
                                    textInputAction: TextInputAction.done,
                                    autofillHints: const [AutofillHints.password],
                                    decoration: InputDecoration(
                                      border: const OutlineInputBorder(),
                                      hintText: '••••••••',
                                      suffixIcon: IconButton(
                                        onPressed: cubit.toggleObscure,
                                        icon: Icon(
                                          state.isObscure ? Icons.visibility : Icons.visibility_off,
                                        ),
                                        tooltip: state.isObscure ? 'Mostrar' : 'Ocultar',
                                      ),
                                    ),
                                    onChanged: cubit.updatePassword,
                                    onFieldSubmitted: (_) => cubit.submit(),
                                  ),
                                  const SizedBox(height: 4),

                                  // Error inline (opcional además del SnackBar)
                                  if (state.error != null) ...[
                                    const SizedBox(height: 8),
                                    Text(
                                      state.error!,
                                      style: textTheme.bodySmall?.copyWith(
                                        color: colorScheme.error,
                                      ),
                                    ),
                                  ],
                                  const SizedBox(height: 16),

                                  // Botón principal
                                  SizedBox(
                                    height: 48,
                                    child: FilledButton(
                                      onPressed: state.isLoading ? null : () => cubit.submit(),
                                      child: state.isLoading
                                          ? const SizedBox(
                                              width: 20,
                                              height: 20,
                                              child: CircularProgressIndicator(strokeWidth: 2),
                                            )
                                          : const Text('Entrar'),
                                    ),
                                  ),

                                  const SizedBox(height: 12),
                                  // Nota de ayuda
                                  Text(
                                    '¿Olvidaste tu contraseña? Contacta a un administrador.',
                                    textAlign: TextAlign.center,
                                    style: textTheme.bodySmall?.copyWith(
                                      color: Theme.of(context).hintColor,
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tramo_pos/core/config/router/app_router.dart';
import 'package:tramo_pos/di.dart';
import 'package:tramo_pos/features/auth/presentation/authCubit/auth_cubit.dart';
import 'package:tramo_pos/features/profile/domain/entities/profile.dart';
import 'package:tramo_pos/features/profile/presentation/profileDisplayCubit/profile_display_cubit.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<AuthCubit, AuthState, String?>(
      selector: (state) => state is AuthAuthenticated ? state.userId : null,
      builder: (context, userId) {
        if (userId == null) {
          return const Center(child: Text('No autenticado'));
        }
        return BlocProvider(
          create: (_) => getIt<ProfileDisplayCubit>()..loadMe(userId),
          child: Scaffold(
            appBar: AppBar(title: const Text('Mi perfil')),
            body: SafeArea(
              child: BlocBuilder<ProfileDisplayCubit, ProfileDisplayState>(
                builder: (context, state) {
                  switch (state) {
                    case ProfileDisplayInitial():
                      return const SizedBox.shrink();
                    case ProfileDisplayLoading():
                      return const Center(child: CircularProgressIndicator());
                    case ProfileDisplayLoaded():
                      return _ProfileContent(state.profile);
                    case ProfileDisplayFailure():
                      return Center(child: Text(state.error));
                  }
                },
              ),
            ),
          ),
        );
      },
    );
  }
}

class _ProfileContent extends StatelessWidget {
  const _ProfileContent(this._profile);

  final Profile _profile;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Center(
          child: _Avatar(
            nameOrEmail: _profile.firstName.isNotEmpty
                ? '${_profile.firstName} ${_profile.lastName}'
                : _profile.email,
            avatarUrl: _profile.avatarUrl,
          ),
        ),
        const SizedBox(height: 16),
        Center(
          child: Text(
            _profile.firstName.isNotEmpty ? _profile.firstName : '—',
            style: Theme.of(context).textTheme.titleLarge,
            textAlign: TextAlign.center,
          ),
        ),
        if (_profile.email.isNotEmpty) ...[
          const SizedBox(height: 4),
          Center(
            child: Text(
              _profile.email,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: Theme.of(context).hintColor),
            ),
          ),
        ],
        const SizedBox(height: 24),
        Card(
          elevation: 0,
          child: Column(
            children: [
              ListTile(
                leading: const Icon(Icons.person_outline),
                title: const Text('Nombre'),
                subtitle: Text(
                  _profile.firstName.isNotEmpty ? _profile.firstName : 'No establecido',
                ),
              ),
              const Divider(height: 0),
              ListTile(
                leading: const Icon(Icons.email_outlined),
                title: const Text('Correo'),
                subtitle: Text(_profile.email.isNotEmpty ? _profile.email : 'No disponible'),
              ),
              const Divider(height: 0),
              ListTile(
                leading: const Icon(Icons.badge_outlined),
                title: const Text('Rol'),
                subtitle: Text(
                  _profile.roleId.isNotEmpty == true ? _profile.roleId : 'No asignado',
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        FilledButton.icon(
          onPressed: () {
            final navigator = Navigator.of(context);
            final auth = context.read<AuthCubit>();

            showDialog<bool>(
              context: context,
              builder: (ctx) => AlertDialog(
                title: const Text('Cerrar sesión'),
                content: const Text('¿Seguro que deseas cerrar sesión?'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(ctx, false),
                    child: const Text('Cancelar'),
                  ),
                  FilledButton(
                    onPressed: () => Navigator.pop(ctx, true),
                    child: const Text('Cerrar sesión'),
                  ),
                ],
              ),
            ).then((confirm) {
              if (confirm == true) {
                auth.signOut().whenComplete(() {
                  if (!navigator.mounted) return;
                  navigator.pushNamedAndRemoveUntil(AppRoutes.signIn, (_) => false);
                });
              }
            });
          },
          icon: const Icon(Icons.logout_rounded),
          label: const Text('Cerrar sesión'),
        ),
      ],
    );
  }
}

class _Avatar extends StatelessWidget {
  const _Avatar({required this.nameOrEmail, this.avatarUrl});
  final String nameOrEmail;
  final String? avatarUrl;

  @override
  Widget build(BuildContext context) {
    final initials = _toInitials(nameOrEmail);
    final bg = Theme.of(context).colorScheme.primaryContainer;
    final fg = Theme.of(context).colorScheme.onPrimaryContainer;

    if (avatarUrl != null && avatarUrl!.isNotEmpty) {
      return CircleAvatar(radius: 40, backgroundImage: NetworkImage(avatarUrl!));
    }
    return CircleAvatar(
      radius: 40,
      backgroundColor: bg,
      child: Text(initials, style: Theme.of(context).textTheme.titleLarge?.copyWith(color: fg)),
    );
  }

  String _toInitials(String s) {
    final parts = s.trim().split(RegExp(r'\s+'));
    if (parts.length >= 2) {
      return (parts[0].isNotEmpty ? parts[0][0] : '') + (parts[1].isNotEmpty ? parts[1][0] : '');
    }
    return s.isNotEmpty ? s[0] : '?';
  }
}

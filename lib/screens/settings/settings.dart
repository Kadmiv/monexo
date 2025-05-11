import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:monexo/generated/l10n.dart';
import 'package:monexo/models/user.dart';
import 'package:monexo/screens/categories/categories.dart';
import 'package:monexo/screens/login/login.dart';
import 'package:monexo/shared/utils.dart';
import 'package:monexo/shared/wave_clipper.dart';

import 'settings_bloc.dart';
import 'settings_event.dart';
import 'settings_state.dart';

/// Сторінка для налаштувань додатку - інформація про користувача, вихід з аккаунту, робота з категоріями, тощо
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late final SettingsBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = SettingsBloc();
    _bloc.add(const LoadUser());
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _bloc,
      child: BlocListener<SettingsBloc, SettingsState>(
        listener: (context, state) {
          if (state is SettingsError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          } else if (state is SettingsInitial) {
            Navigator.pushNamedAndRemoveUntil(
              context,
              LoginScreen.routeName,
              (route) => false,
            );
          }
        },
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView(
                shrinkWrap: true,
                children: <Widget>[
                  /// Заголовок  меню відображення  інформації про користувача
                  BlocBuilder<SettingsBloc, SettingsState>(
                    builder: (context, state) {
                      if (state is SettingsLoaded) {
                        return DrawerHeader(user: state.user);
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                  const SizedBox(height: 10),

                  /// Категорії
                  ListTile(
                    onTap: () {
                      Navigator.pushNamed(context, CategoriesScreen.routeName);
                    },
                    leading: const Icon(Icons.category),
                    title: Text(S.of(context).categories),
                  ),
                  const Divider(),

                  /// Вийти з аккаунту
                  ListTile(
                    onTap: () {
                      _bloc.add(const Logout());
                    },
                    leading: const Icon(Icons.exit_to_app),
                    title: Text(S.of(context).goOut),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: FutureBuilder<String>(
                initialData: '',
                future: getVersionCode(),
                builder: (context, snapshot) {
                  return Text(
                    snapshot.data ?? '',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.labelMedium,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Заголовок бокового меню с информацией о пользователе
final class DrawerHeader extends StatelessWidget {
  const DrawerHeader({
    super.key,
    required this.user,
  });

  final AppUser user;

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: const WaveClipper(),
      child: Container(
        width: double.infinity,
        height: 180,
        color: Theme.of(context).colorScheme.primary,
        child: Padding(
          padding: const EdgeInsets.only(left: 20, bottom: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 45),

              /// Ім'я користувача
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.person_outline,
                    size: 32,
                    color: Colors.white,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    user.name,
                    style: const TextStyle(
                      fontSize: 22,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5),

              /// Електронна пошта користувача
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.email,
                    size: 32,
                    color: Colors.white,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    user.email,
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:monexo/screens/login/login.dart';
import 'package:monexo/screens/main/main.dart';
import 'package:monexo/screens/onboarding/profile_setup/profile_setup.dart';
import 'package:monexo/shared/widgets/custom_logo.dart';

import 'splash_bloc.dart';
import 'splash_event.dart';
import 'splash_state.dart';

/// Сторінка для показу при запуску додатку
/// При старті додатку відбувається перевірка авторизації користувача
/// Якщо авторизація пройшла відповідно переходить на головну сторінку
/// Якщо авторизація не пройшла відповідно переходить на сторінку входу
/// Якщо пройшла авторизація і користувач не має створеного рахунку відповідно переходить на сторінку створення рахунку
final class SplashScreen extends StatefulWidget {
  static const String routeName = '/splash';

  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with AfterLayoutMixin<SplashScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final bloc = SplashBloc();

  @override
  void afterFirstLayout(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          statusBarColor: Theme.of(context).colorScheme.primary,
          systemNavigationBarColor: Theme.of(context).colorScheme.primary,
        ),
      );

      Future.delayed(const Duration(seconds: 1), () {
        bloc.add(const CheckAuthentication());
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => bloc,
      child: BlocListener<SplashBloc, SplashState>(
        listener: (context, state) {
          if (state is SplashAuthenticated) {
            if (state.isNewUser) {
              setSystemUIOverlayStyle();
              Navigator.pushReplacementNamed(
                  context, ProfileSetupScreen.routeName);
            } else {
              setSystemUIOverlayStyle();
              Navigator.pushReplacementNamed(context, MainScreen.routeName);
            }
          } else if (state is SplashUnauthenticated) {
            setSystemUIOverlayStyle();
            Navigator.pushReplacementNamed(context, LoginScreen.routeName);
          } else if (state is SplashError) {
            showDialog(
              context: context,
              builder: (context) => Dialog(
                child: Container(
                  padding: const EdgeInsets.all(40),
                  child: Text(state.message),
                ),
              ),
            );
          }
        },
        child: Scaffold(
          key: _scaffoldKey,
          body: Container(
            color: Theme.of(context).colorScheme.primary,
            child: const Center(
              child: CustomLogo(
                size: 100,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void setSystemUIOverlayStyle() {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Theme.of(context).colorScheme.surface,
        systemNavigationBarColor: Theme.of(context).colorScheme.surface,
      ),
    );
  }
}

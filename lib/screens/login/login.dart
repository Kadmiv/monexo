import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:monexo/generated/l10n.dart';
import 'package:monexo/screens/login/login_bloc.dart';
import 'package:monexo/screens/login/login_event.dart';
import 'package:monexo/screens/login/login_state.dart';
import 'package:monexo/screens/main/main.dart';
import 'package:monexo/screens/screens.dart';
import 'package:monexo/shared/wave_clipper.dart';

/// Сторінка для входу в аккаунт додатку - Google або як гість(анонімний режим без можливості увійти повторно)
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  static const String routeName = '/login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final bloc = LoginBloc();

  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      key: scaffoldMessengerKey,
      child: BlocProvider(
        create: (context) => bloc,
        child: BlocListener<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state is LoginSuccess) {
              if (state.isNewUser) {
                Navigator.pushReplacementNamed(
                    context, ProfileSetupScreen.routeName);
              } else {
                Navigator.pushReplacementNamed(context, MainScreen.routeName);
              }
            } else if (state is LoginFailure) {
              scaffoldMessengerKey.currentState?.showSnackBar(
                SnackBar(content: Text('Failed to sign in: ${state.error}')),
              );
            }
          },
          child: Material(
            child: Column(
              children: <Widget>[
                Flexible(
                  flex: 3,
                  child: Stack(
                    children: <Widget>[
                      ClipPath(
                        child: Container(
                          color: Theme.of(context).colorScheme.primary,
                          child: Stack(
                            children: <Widget>[
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.9,
                                  height: 260,
                                  margin: const EdgeInsets.only(bottom: 40),
                                  child: Stack(
                                    children: const <Widget>[
                                      Align(
                                        alignment: Alignment.bottomLeft,
                                        child: Opacity(
                                          opacity: 0.25,
                                          child: Image(
                                            image: AssetImage(
                                                'assets/images/coins.png'),
                                            width: 120,
                                            height: 120,
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.topCenter,
                                        child: Image(
                                          image: AssetImage(
                                              'assets/images/money_plant.png'),
                                          width: 240,
                                          height: 240,
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.bottomRight,
                                        child: Opacity(
                                          opacity: 0.25,
                                          child: Image(
                                            image: AssetImage(
                                                'assets/images/wallet.png'),
                                            width: 120,
                                            height: 120,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: 20),
                            ],
                          ),
                        ),
                        clipper: WaveClipper(),
                      ),
                    ],
                  ),
                ),
                Flexible(
                  flex: 2,
                  child: Column(
                    children: <Widget>[
                      const Spacer(flex: 2),
                      /// Відображення опису програми
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: Text(
                          S.of(context).appPromoDescription,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            height: 1.6,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const Spacer(flex: 2),
                      
                      /// Відображення кнопки для входу через Google
                      BlocBuilder<LoginBloc, LoginState>(
                        builder: (context, state) {
                          return SizedBox(
                            width: MediaQuery.of(context).size.width * 0.8,
                            child: TextButton.icon(
                              onPressed: state is LoginLoading
                                  ? null
                                  : () => context
                                      .read<LoginBloc>()
                                      .add(SignInWithGoogle()),
                              style: TextButton.styleFrom(
                                foregroundColor:
                                    Theme.of(context).colorScheme.primary,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 15),
                              ),
                              icon: const Image(
                                image:
                                    AssetImage('assets/images/google_icon.png'),
                                width: 28,
                                height: 28,
                              ),
                              label: Text(
                                S.of(context).loginThroughGoogle,
                                style: const TextStyle(fontSize: 16),
                              ),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 15),
                      
                      /// Відображення кнопки для входу як гість
                      BlocBuilder<LoginBloc, LoginState>(
                        builder: (context, state) {
                          return SizedBox(
                            width: MediaQuery.of(context).size.width * 0.8,
                            child: TextButton(
                              onPressed: state is LoginLoading
                                  ? null
                                  : () => context
                                      .read<LoginBloc>()
                                      .add(SignInAnonymously()),
                              style: TextButton.styleFrom(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 15),
                              ),
                              child: Text(
                                S.of(context).enterAsAGuest,
                                style: const TextStyle(fontSize: 16),
                              ),
                            ),
                          );
                        },
                      ),
                      const Spacer(flex: 2),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

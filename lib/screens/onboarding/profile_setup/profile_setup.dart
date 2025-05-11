import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:monexo/generated/l10n.dart';
import 'package:monexo/screens/onboarding/profile_setup/profile_setup_bloc.dart';
import 'package:monexo/screens/screens.dart';
import 'package:monexo/shared/onboarding_header.dart';
import 'package:monexo/shared/widgets/custom_button.dart';

import 'profile_setup_event.dart';
import 'profile_setup_state.dart';

/// Сторінка для створення профілю користувача
final class ProfileSetupScreen extends StatefulWidget {
  static const String routeName = '/profile-setup';

  const ProfileSetupScreen({super.key});

  @override
  State<ProfileSetupScreen> createState() => _ProfileSetupScreenState();
}

class _ProfileSetupScreenState extends State<ProfileSetupScreen>
    with AfterLayoutMixin<ProfileSetupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();

  final bloc = ProfileSetupBloc();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  void afterFirstLayout(BuildContext context) {
    Future.delayed(const Duration(milliseconds: 500), () {
      bloc.add(const ProfileSetupInitialized());
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => bloc,
      child: BlocListener<ProfileSetupBloc, ProfileSetupState>(
        listener: (context, state) {
          if (state is ProfileSetupLoaded) {
            _nameController.text = state.userInfo.name;
            _emailController.text = state.userInfo.email;
          } else if (state is ProfileSetupSuccess) {
            Navigator.pushReplacementNamed(
              context,
              CurrencySetupScreen.routeName,
            );
          } else if (state is ProfileSetupError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Не вдалося оновити профіль: ${state.message}'),
              ),
            );
          }
        },
        child: Scaffold(
          body: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                OnboardingHeader(
                  child: Column(
                    children: [
                      const SizedBox(height: 50),
                      Icon(
                        Icons.person_outline,
                        size: 42,
                        color: Theme.of(context).colorScheme.surface,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        S.of(context).addDataAboutYourself,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 50),

                /// Ім'я користувача
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextFormField(
                    controller: _nameController,
                    onChanged: (value) {},
                    validator: _validateName,
                    decoration: InputDecoration(
                      labelText: S.of(context).yourName,
                      errorMaxLines: 1,
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                /// Електронна пошта користувача
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextFormField(
                    controller: _emailController,
                    onChanged: (value) {},
                    validator: _validateEmail,
                    decoration: InputDecoration(
                      labelText: S.of(context).email,
                      errorMaxLines: 1,
                    ),
                  ),
                ),
                Spacer(),

                /// Далі
                BlocBuilder<ProfileSetupBloc, ProfileSetupState>(
                  builder: (context, state) {
                    return Padding(
                      padding: const EdgeInsets.all(16),
                      child: CustomButton(
                        title: S.of(context).further,
                        onPressed:
                            state is ProfileSetupLoading ? null : _onSubmit,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String? _validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Обов\'язково поле';
    }
    if (value.length < 2) {
      return 'Ім\'я повинно містити не менше 2 символів';
    }
    return null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Обов\'язково поле';
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Невірний формат електронної пошти';
    }
    return null;
  }

  void _onSubmit() {
    if (_formKey.currentState?.validate() ?? false) {
      bloc.add(
        ProfileSetupSubmitted(
          name: _nameController.text,
          email: _emailController.text,
        ),
      );
    }
  }
}

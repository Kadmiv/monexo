import 'package:flutter/material.dart';
import 'package:monexo/shared/wave_clipper.dart';

/// Віджет для відображення заголовка на сторінці створення даних нового користувача в додатку
final class OnboardingHeader extends StatelessWidget {
  const OnboardingHeader({
    super.key,
    required this.child,
  });

 final Widget child;

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: const WaveClipper(),
      child: Container(
        width: double.infinity,
        height: 200,
        color: Theme.of(context).colorScheme.primary,
        child: child,
      ),
    );
  }
}

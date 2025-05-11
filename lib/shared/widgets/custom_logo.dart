import 'package:flutter/material.dart';

/// Віджет для відображення логотипу додатку
final class CustomLogo extends StatelessWidget {
  final double size;
  final Color color;

  const CustomLogo({
    super.key,
    required this.size,
    this.color = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: ColorFiltered(
        colorFilter: ColorFilter.mode(color, BlendMode.modulate),
        child: const Image(
          image: AssetImage('assets/icons/app_icon.png'),
        ),
      ),
    );
  }
}

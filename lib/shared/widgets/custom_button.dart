import 'package:flutter/material.dart';

/// Кастомна кнопка для використання в UI
final class CustomButton extends StatefulWidget {
  final String title;
  final VoidCallback? onPressed;

  const CustomButton({
    super.key,
    required this.title,
    this.onPressed,
  });

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: TextButton(
        onPressed: widget.onPressed,
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          backgroundColor: Theme.of(context).colorScheme.primary,
          disabledBackgroundColor:
              Theme.of(context).colorScheme.primary.withOpacity(0.5),
          foregroundColor: Colors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              widget.title,
              style: const TextStyle(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(
              width: 28,
              height: 28,
              child: Image(
                image: AssetImage('assets/images/double_arrow.png'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

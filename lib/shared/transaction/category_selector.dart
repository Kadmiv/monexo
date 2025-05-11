import 'package:flutter/material.dart';
import 'package:monexo/config/config.dart';
import 'package:monexo/models/models.dart';

/// Віджет для вибору категорії транзакції - використовується в списку транзакцій
final class CategorySelector extends StatelessWidget {
  final CategoryModel category;
  final bool isSelected;
  final VoidCallback? onPressed;

  const CategorySelector({
    super.key,
    required this.category,
    this.isSelected = false,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Stack(
        children: <Widget>[
          if (isSelected)
            Align(
              alignment: Alignment.center,
              child: Container(
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.15),
              ),
            ),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  SizedBox(
                    width: 30,
                    height: 30,
                    child: Image.asset(
                      'assets/categories/${category.icon}.png',
                    ),
                  ),
                  Text(
                    transformCategoryToKey(category),
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

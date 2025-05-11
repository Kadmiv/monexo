import 'package:flutter/material.dart';
import 'package:monexo/generated/l10n.dart';
import 'package:monexo/models/category.dart';

/// Діалог для створення нової категорії типу доходів або витрат
final class AddCategoryDialog extends StatefulWidget {
  const AddCategoryDialog(this.type, {super.key});

  final CategoryType type;

  @override
  State<AddCategoryDialog> createState() => _AddCategoryDialogState();
}

class _AddCategoryDialogState extends State<AddCategoryDialog> {
  String? _selectedIcon;
  final _nameController = TextEditingController();

  static const List<String> _icons = [
    'custom/custom_blue',
    'custom/custom_brown',
    'custom/custom_green',
    'custom/custom_indigo',
    'custom/custom_orange',
    'custom/custom_purple',
    'custom/custom_red',
    'custom/custom_teal',
    'custom/custom_yellow',
    'expense/automobile',
    'expense/baby',
    'expense/books',
    'expense/charity',
    'expense/clothing',
    'expense/drinks',
    'expense/education',
    'expense/electronics',
    'expense/entertainment',
    'expense/food',
    'expense/friends',
    'expense/gifts',
    'expense/groceries',
    'expense/health',
    'expense/hobbies',
    'expense/insurance',
    'expense/investments',
    'expense/laundry',
    'expense/mobile',
    'expense/office',
    'expense/others',
    'expense/pets',
    'expense/rent',
    'expense/salon',
    'expense/shopping',
    'expense/tax',
    'expense/transportation',
    'expense/travel',
    'expense/utilities',
    'income/awards',
    'income/bonus',
    'income/freelance',
    'income/grants',
    'income/interest',
    'income/lottery',
    'income/refunds',
    'income/salary',
    'income/sale',
  ];

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final categoryProvider = Provider.of<CategoryProvider>(context);
    final type = widget.type == CategoryType.income
        ? S.of(context).revenue
        : S.of(context).costs;

    return Container(
      margin: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      padding: const EdgeInsets.all(20),
      child: ListView(
        shrinkWrap: true,
        children: <Widget>[
          Text(
            S.of(context).addANewTypeTypeCategory(type),
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: <Widget>[
              if (_selectedIcon != null) ...[
                Container(
                  decoration: BoxDecoration(
                    border: Border(
                      right: BorderSide(
                        width: 1,
                        color: Colors.grey.withOpacity(0.5),
                      ),
                    ),
                  ),
                  child: CategoryIcon(
                    icon: _selectedIcon!,
                  ),
                ),
                const SizedBox(width: 10),
              ],
              Expanded(
                child: SizedBox(
                  height: 80,
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: _icons.length,
                    itemBuilder: (context, index) {
                      return CategoryIcon(
                        onTap: () {
                          setState(() => _selectedIcon = _icons[index]);
                        },
                        isSelected: _selectedIcon == _icons[index],
                        icon: _icons[index],
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          TextField(
            controller: _nameController,
            decoration: InputDecoration(
              labelText: S.of(context).categoryTitle,
            ),
          ),
          const SizedBox(height: 15),
          Wrap(
            alignment: WrapAlignment.center,
            children: <Widget>[
              TextButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: TextButton.styleFrom(
                  foregroundColor: Colors.red[600],
                ),
                icon: const Icon(Icons.clear),
                label: Text(
                  S.of(context).cancel,
                ),
              ),
              TextButton.icon(
                onPressed: () {
                  if (_nameController.text.isEmpty || _selectedIcon == null) {
                    return;
                  }
                  Navigator.pop(context, [
                    CategoryModel(
                      id: 'custom_${UniqueKey().toString()}',
                      icon: _selectedIcon!,
                      name: _nameController.text,
                      type: widget.type,
                      isCustom: true,
                    ),
                  ]);
                },
                style: TextButton.styleFrom(
                  foregroundColor: Theme.of(context).colorScheme.primary,
                ),
                icon: const Icon(Icons.check),
                label: Text(
                  'ДОДАТИ',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

final class CategoryIcon extends StatelessWidget {
  final VoidCallback? onTap;
  final bool isSelected;
  final String icon;

  const CategoryIcon({
    super.key,
    this.onTap,
    this.isSelected = false,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        width: 80,
        height: 80,
        child: Stack(
          children: <Widget>[
            if (isSelected)
              Center(
                child: Container(
                  width: 80,
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
                ),
              ),
            Center(
              child: Container(
                width: 60,
                height: 60,
                padding: const EdgeInsets.all(8),
                child: Image.asset('assets/categories/$icon.png'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

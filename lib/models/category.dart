/// Клас сутності  категорії - описує дані про категорію транзакції
final class CategoryModel {
  final String id;
  final String icon;
  final String name;
  final CategoryType? type;
  final bool isCustom;

  const CategoryModel({
    required this.id,
    required this.icon,
    required this.name,
    required this.type,
    this.isCustom = false,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'],
      icon: json['icon'],
      name: json['name'],
      type: CategoryType.findByValue(json['type']),
      isCustom: json['isCustom'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'icon': icon,
      'name': name,
      'type': type?.value,
      'isCustom': isCustom,
    };
  }
}

enum CategoryType {
  income('income'),
  expense('expense'),
  ;

  const CategoryType(this.value);

  final String value;

  static CategoryType? findByValue(String value) {
    for (final type in CategoryType.values) {
      if (type.value == value) {
        return type;
      }
    }
    return null;
  }
}

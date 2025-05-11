import 'package:monexo/models/models.dart';

// Events
abstract class CategoriesEvent {}

class LoadCategories extends CategoriesEvent {}

class CreateCategory extends CategoriesEvent {
  CreateCategory(this.category);

  final CategoryModel category;
}

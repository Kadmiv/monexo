import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:monexo/models/models.dart';

/// Provider для роботи з категоріями транзакцій
///
/// Для кожного нового користувача створються нові категорії транзакцій
/// на стороні бази даних Firebase - тому їх можна додавати і видаляти
final class CategoryProvider {
  static final CategoryProvider _instance = CategoryProvider._internal();

  factory CategoryProvider() {
    return _instance;
  }

  CategoryProvider._internal();


  final FirebaseFirestore _db = FirebaseFirestore.instance;
  late CollectionReference<Map<String, dynamic>> _categoriesCollection;

  init(AppUser user) {
    _categoriesCollection =
        _db.collection('users').doc(user.uid).collection('categories');
  }

  Future<void> setupCategories() async {
    for (final category in baseIncomeCategories) {
      add(category);
    }
    for (final category in baseExpenseCategories) {
      add(category);
    }
  }

  Future<List<CategoryModel>> getCategories(String accountId) async {
    final snapshot = await _categoriesCollection
        .get();

    return snapshot.docs.map((doc) {
      return CategoryModel.fromJson(doc.data());
    }).toList();
  }

  Future<void> add(CategoryModel category) async {
    var doc = await _categoriesCollection.add(category.toJson());
    return doc.update({'id': doc.id});
  }

  Future<void> update(CategoryModel category) {
    return _categoriesCollection.doc(category.id).update(category.toJson());
  }

  Future<void> delete(CategoryModel category) async {
    await _categoriesCollection.doc(category.id).delete();
  }
}

final List<CategoryModel> baseIncomeCategories = [
  CategoryModel(
    id: 'awards',
    name: 'Нагороди',
    icon: 'income/awards',
    type: CategoryType.income,
  ),
  CategoryModel(
    id: 'bonus',
    name: 'Бонуси',
    icon: 'income/bonus',
    type: CategoryType.income,
  ),
  CategoryModel(
    id: 'freelance',
    name: 'Фриланс',
    icon: 'income/freelance',
    type: CategoryType.income,
  ),
  CategoryModel(
    id: 'friends_and_family',
    name: 'Друзі та сім’я',
    icon: 'income/friends',
    type: CategoryType.income,
  ),
  CategoryModel(
    id: 'grants',
    name: 'Гранти',
    icon: 'income/grants',
    type: CategoryType.income,
  ),
  CategoryModel(
    id: 'interest',
    name: 'Відсотки',
    icon: 'income/interest',
    type: CategoryType.income,
  ),
  CategoryModel(
    id: 'investments',
    name: 'Інвестиції',
    icon: 'income/investments',
    type: CategoryType.income,
  ),
  CategoryModel(
    id: 'lottery',
    name: 'Лотерея',
    icon: 'income/lottery',
    type: CategoryType.income,
  ),
  CategoryModel(
    id: 'others',
    name: 'Інше',
    icon: 'income/others',
    type: CategoryType.income,
  ),
  CategoryModel(
    id: 'refunds',
    name: 'Повернення коштів',
    icon: 'income/refunds',
    type: CategoryType.income,
  ),
  CategoryModel(
    id: 'rent',
    name: 'Оренда',
    icon: 'income/rent',
    type: CategoryType.income,
  ),
  CategoryModel(
    id: 'salary',
    name: 'Зарплата',
    icon: 'income/salary',
    type: CategoryType.income,
  ),
  CategoryModel(
    id: 'sale',
    name: 'Продаж',
    icon: 'income/sale',
    type: CategoryType.income,
  ),
];

final List<CategoryModel> baseExpenseCategories = [
  CategoryModel(
    id: 'automobile',
    name: 'Автомобіль',
    icon: 'expense/automobile',
    type: CategoryType.expense,
  ),
  CategoryModel(
    id: 'baby_care',
    name: 'Догляд за дитиною',
    icon: 'expense/baby',
    type: CategoryType.expense,
  ),
  CategoryModel(
    id: 'books',
    name: 'Книги',
    icon: 'expense/books',
    type: CategoryType.expense,
  ),
  CategoryModel(
    id: 'charity',
    name: 'Благодійність',
    icon: 'expense/charity',
    type: CategoryType.expense,
  ),
  CategoryModel(
    id: 'clothing',
    name: 'Одяг',
    icon: 'expense/clothing',
    type: CategoryType.expense,
  ),
  CategoryModel(
    id: 'drinks',
    name: 'Напої',
    icon: 'expense/drinks',
    type: CategoryType.expense,
  ),
  CategoryModel(
    id: 'education',
    name: 'Освіта',
    icon: 'expense/education',
    type: CategoryType.expense,
  ),
  CategoryModel(
    id: 'electronics',
    name: 'Електроніка',
    icon: 'expense/electronics',
    type: CategoryType.expense,
  ),
  CategoryModel(
    id: 'entertainment',
    name: 'Розваги',
    icon: 'expense/entertainment',
    type: CategoryType.expense,
  ),
  CategoryModel(
    id: 'food',
    name: 'Їжа',
    icon: 'expense/food',
    type: CategoryType.expense,
  ),
  CategoryModel(
    id: 'friends_and_family',
    name: 'Друзі та сім’я',
    icon: 'expense/friends',
    type: CategoryType.expense,
  ),
  CategoryModel(
    id: 'gifts',
    name: 'Подарунки',
    icon: 'expense/gifts',
    type: CategoryType.expense,
  ),
  CategoryModel(
    id: 'groceries',
    name: 'Продукти',
    icon: 'expense/groceries',
    type: CategoryType.expense,
  ),
  CategoryModel(
    id: 'health',
    name: 'Здоров’я',
    icon: 'expense/health',
    type: CategoryType.expense,
  ),
  CategoryModel(
    id: 'hobbies',
    name: 'Хобі',
    icon: 'expense/hobbies',
    type: CategoryType.expense,
  ),
  CategoryModel(
    id: 'insurance',
    name: 'Страхування',
    icon: 'expense/insurance',
    type: CategoryType.expense,
  ),
  CategoryModel(
    id: 'investments',
    name: 'Інвестиції',
    icon: 'expense/investments',
    type: CategoryType.expense,
  ),
  CategoryModel(
    id: 'laundry',
    name: 'Прання',
    icon: 'expense/laundry',
    type: CategoryType.expense,
  ),
  CategoryModel(
    id: 'mobile',
    name: 'Мобільний зв’язок',
    icon: 'expense/mobile',
    type: CategoryType.expense,
  ),
  CategoryModel(
    id: 'office',
    name: 'Офіс',
    icon: 'expense/office',
    type: CategoryType.expense,
  ),
  CategoryModel(
    id: 'others',
    name: 'Інше',
    icon: 'expense/others',
    type: CategoryType.expense,
  ),
  CategoryModel(
    id: 'pets',
    name: 'Домашні улюбленці',
    icon: 'expense/pets',
    type: CategoryType.expense,
  ),
  CategoryModel(
    id: 'rent',
    name: 'Оренда',
    icon: 'expense/rent',
    type: CategoryType.expense,
  ),
  CategoryModel(
    id: 'salon_and_spa',
    name: 'Салон та спа',
    icon: 'expense/salon',
    type: CategoryType.expense,
  ),
  CategoryModel(
    id: 'shopping',
    name: 'Покупки',
    icon: 'expense/shopping',
    type: CategoryType.expense,
  ),
  CategoryModel(
    id: 'tax',
    name: 'Податки',
    icon: 'expense/tax',
    type: CategoryType.expense,
  ),
  CategoryModel(
    id: 'transportation',
    name: 'Транспорт',
    icon: 'expense/transportation',
    type: CategoryType.expense,
  ),
  CategoryModel(
    id: 'travel',
    name: 'Подорожі',
    icon: 'expense/travel',
    type: CategoryType.expense,
  ),
  CategoryModel(
    id: 'utilities',
    name: 'Комунальні послуги',
    icon: 'expense/utilities',
    type: CategoryType.expense,
  ),
];

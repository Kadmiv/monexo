// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a uk locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'uk';

  static String m0(type) => "Додати нову категорію типу ${type}";

  static String m1(type) => "Додати нову категорію типу ${type}";

  static String m2(category) =>
      "${Intl.select(category, {'Automobile': 'Автомобіль', 'Awards': 'Нагороди', 'BabyCare': 'Догляд за дитиною', 'Bonus': 'Бонус', 'Books': 'Книги', 'Charity': 'Благодійність', 'Clothing': 'Одяг', 'Drinks': 'Напої', 'Education': 'Освіта', 'Electronics': 'Електроніка', 'Entertainment': 'Розваги', 'Food': 'Їжа', 'Freelance': 'Фриланс', 'FriendsFamily': 'Друзі та родина', 'Gifts': 'Подарунки', 'Grants': 'Гранти', 'Groceries': 'Продукти', 'Health': 'Здоров’я', 'Hobbies': 'Хобі', 'Insurance': 'Страхування', 'Interest': 'Відсотки', 'Investments': 'Інвестиції', 'Laundry': 'Прання', 'Lottery': 'Лотерея', 'Mobile': 'Мобільний зв’язок', 'Office': 'Офіс', 'Others': 'Інше', 'Pets': 'Домашні улюбленці', 'Refunds': 'Повернення', 'Rent': 'Оренда', 'Salary': 'Зарплата', 'Sale': 'Продаж', 'SalonSpa': 'Салон і спа', 'Shopping': 'Покупки', 'Tax': 'Податки', 'Transportation': 'Транспорт', 'Travel': 'Подорожі', 'Utilities': 'Комунальні послуги', 'other': '${category}'})}";

  static String m3(howMany) => "${howMany} транзакції приховані";

  static String m4(howMany) => "${howMany} транзакцій приховано";

  static String m5(symbol, spendAmount, budgetAmount, monthYear) =>
      "Ви витратили ${symbol} ${spendAmount} з вашого бюджету ${symbol} ${budgetAmount} у місяці ${monthYear}.";

  static String m6(howMany) =>
      "${Intl.plural(howMany, one: '1 транзакція прихована', few: '${howMany} транзакції приховані', many: '${howMany} транзакцій приховано', other: '${howMany} транзакції приховано')}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "aSumMayHaveAMaximumOf2ComaSigns": MessageLookupByLibrary.simpleMessage(
      "Сума може мати максимум 2 знаки після коми",
    ),
    "abolition": MessageLookupByLibrary.simpleMessage("ВІДМІНА"),
    "accountName": MessageLookupByLibrary.simpleMessage("Назва рахунку"),
    "add": MessageLookupByLibrary.simpleMessage("ДОДАТИ"),
    "addANewOne": MessageLookupByLibrary.simpleMessage("Додати нову"),
    "addANewTransaction": MessageLookupByLibrary.simpleMessage(
      "Додати нову транзакцію",
    ),
    "addANewTypeTypeCategory": m0,
    "addCategoryBottomSheetButtonTextAdd": MessageLookupByLibrary.simpleMessage(
      "ДОДАТИ",
    ),
    "addCategoryBottomSheetButtonTextCancel":
        MessageLookupByLibrary.simpleMessage("СКАСУВАТИ"),
    "addCategoryBottomSheetHeadingText": m1,
    "addCategoryBottomSheetLabelTextCategoryName":
        MessageLookupByLibrary.simpleMessage("Назва категорії"),
    "addDataAboutYourself": MessageLookupByLibrary.simpleMessage(
      "Додайте дані про себе",
    ),
    "appName": MessageLookupByLibrary.simpleMessage("Monexo"),
    "appPromoDescription": MessageLookupByLibrary.simpleMessage(
      "Monexo — це проста та безпечна програма для керування фінансами, яка допомагає відстежувати доходи та витрати.",
    ),
    "balanceOnTheAccount": MessageLookupByLibrary.simpleMessage(
      "Баланс на рахунку",
    ),
    "basic": MessageLookupByLibrary.simpleMessage("Основне"),
    "budget": MessageLookupByLibrary.simpleMessage("Бюджет"),
    "cancel": MessageLookupByLibrary.simpleMessage("СКАСУВАТИ"),
    "categories": MessageLookupByLibrary.simpleMessage("Категорії"),
    "categoriesScreenAppBarTitle": MessageLookupByLibrary.simpleMessage(
      "Категорії",
    ),
    "categoriesScreenButtonTextAddNew": MessageLookupByLibrary.simpleMessage(
      "Додати нову",
    ),
    "categoriesScreenSnackbarTextDeleteMessage":
        MessageLookupByLibrary.simpleMessage("Категорію успішно видалено"),
    "categoriesScreenSnackbarTextResetCategoriesAction":
        MessageLookupByLibrary.simpleMessage("Так"),
    "categoriesScreenSnackbarTextResetCategoriesConfirmation":
        MessageLookupByLibrary.simpleMessage(
          "Ви впевнені, що хочете скинути всі категорії до початкових?",
        ),
    "categoriesScreenSnackbarTextResetCategoriesSuccess":
        MessageLookupByLibrary.simpleMessage("Всі категорії успішно скинуто"),
    "categoriesScreenTabBarTextExpense": MessageLookupByLibrary.simpleMessage(
      "Витрати",
    ),
    "categoriesScreenTabBarTextIncome": MessageLookupByLibrary.simpleMessage(
      "Доходи",
    ),
    "categoryName": m2,
    "categoryTitle": MessageLookupByLibrary.simpleMessage("Назва категорії"),
    "clickHereToSetTheMonthlyBudgetAndBetterManage":
        MessageLookupByLibrary.simpleMessage(
          "Натисніть тут, щоб встановити місячний бюджет і краще керувати витратами.",
        ),
    "clickTheButtonBelowToAddANewCostincome":
        MessageLookupByLibrary.simpleMessage(
          "Натисніть на кнопку + нижче, щоб додати нову витрату/дохід.",
        ),
    "cost": MessageLookupByLibrary.simpleMessage("Витрата"),
    "costs": MessageLookupByLibrary.simpleMessage("Витрати"),
    "createYourMainAccount": MessageLookupByLibrary.simpleMessage(
      "Створіть свій основний рахунок",
    ),
    "currenciesScreenAppBarTitle": MessageLookupByLibrary.simpleMessage(
      "Валюти",
    ),
    "currenciesScreenSnackbarTextResetCurrenciesAction":
        MessageLookupByLibrary.simpleMessage("Так"),
    "currenciesScreenSnackbarTextResetCurrenciesConfirmation":
        MessageLookupByLibrary.simpleMessage(
          "Ви впевнені, що хочете скинути всі валюти до початкових?",
        ),
    "currenciesScreenSnackbarTextResetCurrenciesSuccess":
        MessageLookupByLibrary.simpleMessage("Всі валюти успішно скинуто"),
    "currency": MessageLookupByLibrary.simpleMessage("Валюта"),
    "currencySetupTextHeadline": MessageLookupByLibrary.simpleMessage(
      "Яка ваша валюта?",
    ),
    "date": MessageLookupByLibrary.simpleMessage("Дата"),
    "day": MessageLookupByLibrary.simpleMessage("День"),
    "deleteAccountDialogButtonTextCancel": MessageLookupByLibrary.simpleMessage(
      "Ні, я не хочу йти!",
    ),
    "deleteAccountDialogButtonTextDelete": MessageLookupByLibrary.simpleMessage(
      "Так, видалити мої дані!",
    ),
    "deleteAccountDialogContent": MessageLookupByLibrary.simpleMessage(
      "Після видалення облікового запису ви втратите всі дані (включаючи профіль та історію транзакцій). Це незворотній процес. Ви впевнені, що хочете продовжити?",
    ),
    "deleteAccountDialogTitle": MessageLookupByLibrary.simpleMessage(
      "Ви справді хочете видалити свій обліковий запис?",
    ),
    "descriptionNot": MessageLookupByLibrary.simpleMessage(
      "Опис (необов\'язково)",
    ),
    "email": MessageLookupByLibrary.simpleMessage("Електронна пошта"),
    "enterAsAGuest": MessageLookupByLibrary.simpleMessage("Увійти як гість"),
    "enterTheAccountName": MessageLookupByLibrary.simpleMessage(
      "Введіть назву рахунку",
    ),
    "enterTheCorrectAmount": MessageLookupByLibrary.simpleMessage(
      "Введіть коректну суму",
    ),
    "enterTheMonthlyBudget": MessageLookupByLibrary.simpleMessage(
      "Введіть місячний бюджет",
    ),
    "enterTheMonthlyBudgetThatYouConsiderToBeModerate":
        MessageLookupByLibrary.simpleMessage(
          "Введіть місячний бюджет, який вважаєте помірним згідно з вашими витратами.",
        ),
    "exportBottomSheetButtonTextDownload": MessageLookupByLibrary.simpleMessage(
      "ЗАВАНТАЖИТИ",
    ),
    "exportBottomSheetButtonTextExport": MessageLookupByLibrary.simpleMessage(
      "ЕКСПОРТ",
    ),
    "exportBottomSheetHeadingText": MessageLookupByLibrary.simpleMessage(
      "Експортувати у CSV/JSON",
    ),
    "exportBottomSheetLabelTextEndDate": MessageLookupByLibrary.simpleMessage(
      "Дата завершення",
    ),
    "exportBottomSheetLabelTextStartDate": MessageLookupByLibrary.simpleMessage(
      "Дата початку",
    ),
    "exportBottomSheetTextDateValidationError":
        MessageLookupByLibrary.simpleMessage(
          "Дата початку має бути раніше за дату завершення",
        ),
    "further": MessageLookupByLibrary.simpleMessage("ДАЛІ"),
    "goOut": MessageLookupByLibrary.simpleMessage("Вийти"),
    "home": MessageLookupByLibrary.simpleMessage("Головна"),
    "homeDailyNoTransactionsTextSubtitle": MessageLookupByLibrary.simpleMessage(
      "Натисніть на кнопку + нижче, щоб додати нову витрату/дохід.",
    ),
    "homeDailyNoTransactionsTextTitle": MessageLookupByLibrary.simpleMessage(
      "Список виглядає порожнім...",
    ),
    "howmanyTransactionsAreHidden": m3,
    "income": MessageLookupByLibrary.simpleMessage("Дохід"),
    "incorrectNumberFormat": MessageLookupByLibrary.simpleMessage(
      "Невірний формат числа",
    ),
    "loginButtonTextGoogle": MessageLookupByLibrary.simpleMessage(
      "Увійти через Google",
    ),
    "loginButtonTextGuest": MessageLookupByLibrary.simpleMessage(
      "Увійти як гість",
    ),
    "loginTextTagline": MessageLookupByLibrary.simpleMessage(
      "Monexo — це проста та безпечна програма для керування фінансами, яка допомагає відстежувати доходи та витрати.",
    ),
    "loginThroughGoogle": MessageLookupByLibrary.simpleMessage(
      "Увійти через Google",
    ),
    "mandatoryField": MessageLookupByLibrary.simpleMessage("Обов\'язково поле"),
    "manyTransactionsAreHidden": m4,
    "monexoDrawerMessageShare": MessageLookupByLibrary.simpleMessage(
      "Спробуй цей додаток для безпечного керування доходами та витратами: https://pillai.xyz/monexo",
    ),
    "monexoDrawerTextAbout": MessageLookupByLibrary.simpleMessage(
      "Про додаток",
    ),
    "monexoDrawerTextAboutAppLegalese": MessageLookupByLibrary.simpleMessage(
      "Цей додаток є з відкритим кодом і безкоштовний у використанні, під ліцензією Apache 2.0. Якщо ви розробник — долучайтесь до проєкту на GitHub.",
    ),
    "monexoDrawerTextAboutFooter": MessageLookupByLibrary.simpleMessage(
      "Якщо додаток вам подобається і ви ним часто користуєтесь — підтримайте його існування донатом. Реквізити — на сайті або GitHub. Щиро дякуємо!",
    ),
    "monexoDrawerTextCategories": MessageLookupByLibrary.simpleMessage(
      "Категорії",
    ),
    "monexoDrawerTextCurrencies": MessageLookupByLibrary.simpleMessage(
      "Валюти",
    ),
    "monexoDrawerTextExport": MessageLookupByLibrary.simpleMessage(
      "Експортувати у JSON/CSV",
    ),
    "monexoDrawerTextLogout": MessageLookupByLibrary.simpleMessage("Вийти"),
    "monexoDrawerTextRate": MessageLookupByLibrary.simpleMessage(
      "Оцініть додаток",
    ),
    "monexoDrawerTextSettings": MessageLookupByLibrary.simpleMessage(
      "Налаштування",
    ),
    "monexoDrawerTextShare": MessageLookupByLibrary.simpleMessage("Поділитися"),
    "monexoOverviewTextBalanceHeading": MessageLookupByLibrary.simpleMessage(
      "ВАШ БАЛАНС",
    ),
    "monexoOverviewTextBudgetSet": m5,
    "monexoOverviewTextBudgetUnset": MessageLookupByLibrary.simpleMessage(
      "Натисніть тут, щоб встановити місячний бюджет і краще керувати витратами.",
    ),
    "month": MessageLookupByLibrary.simpleMessage("Місяць"),
    "noCategory": MessageLookupByLibrary.simpleMessage("Без категорії"),
    "oneTransactionIsHidden": MessageLookupByLibrary.simpleMessage(
      "1 транзакція прихована",
    ),
    "pleaseEnterTheAmount": MessageLookupByLibrary.simpleMessage(
      "Будь ласка, введіть суму",
    ),
    "pleaseEnterTheCorrectNumber": MessageLookupByLibrary.simpleMessage(
      "Будь ласка, введіть коректне число",
    ),
    "profileSetupButtonTextNext": MessageLookupByLibrary.simpleMessage("ДАЛІ"),
    "profileSetupLabelTextFullName": MessageLookupByLibrary.simpleMessage(
      "Повне ім’я",
    ),
    "profileSetupTextHeadline": MessageLookupByLibrary.simpleMessage("Хто ви?"),
    "revenue": MessageLookupByLibrary.simpleMessage("Доходи"),
    "save": MessageLookupByLibrary.simpleMessage("ЗБЕРЕГТИ"),
    "settingUp": MessageLookupByLibrary.simpleMessage("Налаштування"),
    "settingsScreenHeaderTitleAccount": MessageLookupByLibrary.simpleMessage(
      "Обліковий запис",
    ),
    "settingsScreenHeaderTitleDangerZone": MessageLookupByLibrary.simpleMessage(
      "Небезпечна зона",
    ),
    "settingsScreenHeaderTitlePreferences":
        MessageLookupByLibrary.simpleMessage("Налаштування"),
    "settingsScreenSettingTitleAccentColor":
        MessageLookupByLibrary.simpleMessage("Акцентний колір"),
    "settingsScreenSettingTitleBiometric": MessageLookupByLibrary.simpleMessage(
      "Біометрична безпека",
    ),
    "settingsScreenSettingTitleBiometricDescription":
        MessageLookupByLibrary.simpleMessage(
          "Запитує ваш відбиток пальця при кожному відкритті додатку.",
        ),
    "settingsScreenSettingTitleCurrency": MessageLookupByLibrary.simpleMessage(
      "Валюта",
    ),
    "settingsScreenSettingTitleDeleteAccount":
        MessageLookupByLibrary.simpleMessage("Видалити обліковий запис"),
    "settingsScreenSettingTitleLanguage": MessageLookupByLibrary.simpleMessage(
      "Мова",
    ),
    "settingsScreenSettingTitleName": MessageLookupByLibrary.simpleMessage(
      "Повне ім’я",
    ),
    "settingsScreenSettingTitleTheme": MessageLookupByLibrary.simpleMessage(
      "Тема",
    ),
    "settingsScreenSettingTitleThemeAMOLED":
        MessageLookupByLibrary.simpleMessage("AMOLED"),
    "settingsScreenSettingTitleThemeDark": MessageLookupByLibrary.simpleMessage(
      "Темна",
    ),
    "settingsScreenSettingTitleThemeLight":
        MessageLookupByLibrary.simpleMessage("Світла"),
    "statistics": MessageLookupByLibrary.simpleMessage("Статистика"),
    "suma": MessageLookupByLibrary.simpleMessage("Сума"),
    "theAmountShouldBeMoreThan0": MessageLookupByLibrary.simpleMessage(
      "Сума повинна бути більше 0",
    ),
    "theListLooksEmpty": MessageLookupByLibrary.simpleMessage(
      "Список виглядає порожнім...",
    ),
    "theNameMustContainAtLeast3Characters":
        MessageLookupByLibrary.simpleMessage(
          "Назва повинна містити не менше 3 символів",
        ),
    "transactionBottomSheetButtonTextAdd": MessageLookupByLibrary.simpleMessage(
      "ДОДАТИ",
    ),
    "transactionBottomSheetButtonTextExpense":
        MessageLookupByLibrary.simpleMessage("Витрата"),
    "transactionBottomSheetButtonTextIncome":
        MessageLookupByLibrary.simpleMessage("Дохід"),
    "transactionBottomSheetButtonTextUpdate":
        MessageLookupByLibrary.simpleMessage("ОНОВИТИ"),
    "transactionBottomSheetLabelTextAmount":
        MessageLookupByLibrary.simpleMessage("Сума"),
    "transactionBottomSheetLabelTextDate": MessageLookupByLibrary.simpleMessage(
      "Дата",
    ),
    "transactionBottomSheetLabelTextDescription":
        MessageLookupByLibrary.simpleMessage("Опис (необов\'язково)"),
    "transactionBottomSheetTextHeadingAdd":
        MessageLookupByLibrary.simpleMessage("Додати нову транзакцію"),
    "transactionBottomSheetTextHeadingUpdate":
        MessageLookupByLibrary.simpleMessage("Оновити транзакцію"),
    "transactionListHiddenTransactionText": m6,
    "update": MessageLookupByLibrary.simpleMessage("ОНОВИТИ"),
    "updateBudgetBottomSheetButtonTextClear":
        MessageLookupByLibrary.simpleMessage("ОЧИСТИТИ"),
    "updateBudgetBottomSheetButtonTextSetBudget":
        MessageLookupByLibrary.simpleMessage("ВСТАНОВИТИ БЮДЖЕТ"),
    "updateBudgetBottomSheetHeadingText": MessageLookupByLibrary.simpleMessage(
      "Введіть місячний бюджет, який вважаєте помірним згідно з вашими витратами.",
    ),
    "updateBudgetBottomSheetLabelTextBudget":
        MessageLookupByLibrary.simpleMessage("Бюджет"),
    "updateTheTransaction": MessageLookupByLibrary.simpleMessage(
      "Оновити транзакцію",
    ),
    "week": MessageLookupByLibrary.simpleMessage("Тиждень"),
    "yourName": MessageLookupByLibrary.simpleMessage("Ваше ім\'я"),
  };
}

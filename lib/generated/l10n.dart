// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name =
        (locale.countryCode?.isEmpty ?? false)
            ? locale.languageCode
            : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `ДОДАТИ`
  String get addCategoryBottomSheetButtonTextAdd {
    return Intl.message(
      'ДОДАТИ',
      name: 'addCategoryBottomSheetButtonTextAdd',
      desc: '',
      args: [],
    );
  }

  /// `СКАСУВАТИ`
  String get addCategoryBottomSheetButtonTextCancel {
    return Intl.message(
      'СКАСУВАТИ',
      name: 'addCategoryBottomSheetButtonTextCancel',
      desc: '',
      args: [],
    );
  }

  /// `Додати нову категорію типу {type}`
  String addCategoryBottomSheetHeadingText(Object type) {
    return Intl.message(
      'Додати нову категорію типу $type',
      name: 'addCategoryBottomSheetHeadingText',
      desc: '',
      args: [type],
    );
  }

  /// `Назва категорії`
  String get addCategoryBottomSheetLabelTextCategoryName {
    return Intl.message(
      'Назва категорії',
      name: 'addCategoryBottomSheetLabelTextCategoryName',
      desc: '',
      args: [],
    );
  }

  /// `Monexo`
  String get appName {
    return Intl.message('Monexo', name: 'appName', desc: '', args: []);
  }

  /// `Категорії`
  String get categoriesScreenAppBarTitle {
    return Intl.message(
      'Категорії',
      name: 'categoriesScreenAppBarTitle',
      desc: '',
      args: [],
    );
  }

  /// `Додати нову`
  String get categoriesScreenButtonTextAddNew {
    return Intl.message(
      'Додати нову',
      name: 'categoriesScreenButtonTextAddNew',
      desc: '',
      args: [],
    );
  }

  /// `Категорію успішно видалено`
  String get categoriesScreenSnackbarTextDeleteMessage {
    return Intl.message(
      'Категорію успішно видалено',
      name: 'categoriesScreenSnackbarTextDeleteMessage',
      desc: '',
      args: [],
    );
  }

  /// `Так`
  String get categoriesScreenSnackbarTextResetCategoriesAction {
    return Intl.message(
      'Так',
      name: 'categoriesScreenSnackbarTextResetCategoriesAction',
      desc: '',
      args: [],
    );
  }

  /// `Ви впевнені, що хочете скинути всі категорії до початкових?`
  String get categoriesScreenSnackbarTextResetCategoriesConfirmation {
    return Intl.message(
      'Ви впевнені, що хочете скинути всі категорії до початкових?',
      name: 'categoriesScreenSnackbarTextResetCategoriesConfirmation',
      desc: '',
      args: [],
    );
  }

  /// `Всі категорії успішно скинуто`
  String get categoriesScreenSnackbarTextResetCategoriesSuccess {
    return Intl.message(
      'Всі категорії успішно скинуто',
      name: 'categoriesScreenSnackbarTextResetCategoriesSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Витрати`
  String get categoriesScreenTabBarTextExpense {
    return Intl.message(
      'Витрати',
      name: 'categoriesScreenTabBarTextExpense',
      desc: '',
      args: [],
    );
  }

  /// `Доходи`
  String get categoriesScreenTabBarTextIncome {
    return Intl.message(
      'Доходи',
      name: 'categoriesScreenTabBarTextIncome',
      desc: '',
      args: [],
    );
  }

  /// `{category, select, Automobile {Автомобіль} Awards {Нагороди} BabyCare {Догляд за дитиною} Bonus {Бонус} Books {Книги} Charity {Благодійність} Clothing {Одяг} Drinks {Напої} Education {Освіта} Electronics {Електроніка} Entertainment {Розваги} Food {Їжа} Freelance {Фриланс} FriendsFamily {Друзі та родина} Gifts {Подарунки} Grants {Гранти} Groceries {Продукти} Health {Здоров’я} Hobbies {Хобі} Insurance {Страхування} Interest {Відсотки} Investments {Інвестиції} Laundry {Прання} Lottery {Лотерея} Mobile {Мобільний зв’язок} Office {Офіс} Others {Інше} Pets {Домашні улюбленці} Refunds {Повернення} Rent {Оренда} Salary {Зарплата} Sale {Продаж} SalonSpa {Салон і спа} Shopping {Покупки} Tax {Податки} Transportation {Транспорт} Travel {Подорожі} Utilities {Комунальні послуги} other {{category}}}`
  String categoryName(Object category) {
    return Intl.select(
      category,
      {
        'Automobile': 'Автомобіль',
        'Awards': 'Нагороди',
        'BabyCare': 'Догляд за дитиною',
        'Bonus': 'Бонус',
        'Books': 'Книги',
        'Charity': 'Благодійність',
        'Clothing': 'Одяг',
        'Drinks': 'Напої',
        'Education': 'Освіта',
        'Electronics': 'Електроніка',
        'Entertainment': 'Розваги',
        'Food': 'Їжа',
        'Freelance': 'Фриланс',
        'FriendsFamily': 'Друзі та родина',
        'Gifts': 'Подарунки',
        'Grants': 'Гранти',
        'Groceries': 'Продукти',
        'Health': 'Здоров’я',
        'Hobbies': 'Хобі',
        'Insurance': 'Страхування',
        'Interest': 'Відсотки',
        'Investments': 'Інвестиції',
        'Laundry': 'Прання',
        'Lottery': 'Лотерея',
        'Mobile': 'Мобільний зв’язок',
        'Office': 'Офіс',
        'Others': 'Інше',
        'Pets': 'Домашні улюбленці',
        'Refunds': 'Повернення',
        'Rent': 'Оренда',
        'Salary': 'Зарплата',
        'Sale': 'Продаж',
        'SalonSpa': 'Салон і спа',
        'Shopping': 'Покупки',
        'Tax': 'Податки',
        'Transportation': 'Транспорт',
        'Travel': 'Подорожі',
        'Utilities': 'Комунальні послуги',
        'other': '$category',
      },
      name: 'categoryName',
      desc: '',
      args: [category],
    );
  }

  /// `Валюти`
  String get currenciesScreenAppBarTitle {
    return Intl.message(
      'Валюти',
      name: 'currenciesScreenAppBarTitle',
      desc: '',
      args: [],
    );
  }

  /// `Так`
  String get currenciesScreenSnackbarTextResetCurrenciesAction {
    return Intl.message(
      'Так',
      name: 'currenciesScreenSnackbarTextResetCurrenciesAction',
      desc: '',
      args: [],
    );
  }

  /// `Ви впевнені, що хочете скинути всі валюти до початкових?`
  String get currenciesScreenSnackbarTextResetCurrenciesConfirmation {
    return Intl.message(
      'Ви впевнені, що хочете скинути всі валюти до початкових?',
      name: 'currenciesScreenSnackbarTextResetCurrenciesConfirmation',
      desc: '',
      args: [],
    );
  }

  /// `Всі валюти успішно скинуто`
  String get currenciesScreenSnackbarTextResetCurrenciesSuccess {
    return Intl.message(
      'Всі валюти успішно скинуто',
      name: 'currenciesScreenSnackbarTextResetCurrenciesSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Яка ваша валюта?`
  String get currencySetupTextHeadline {
    return Intl.message(
      'Яка ваша валюта?',
      name: 'currencySetupTextHeadline',
      desc: '',
      args: [],
    );
  }

  /// `Ні, я не хочу йти!`
  String get deleteAccountDialogButtonTextCancel {
    return Intl.message(
      'Ні, я не хочу йти!',
      name: 'deleteAccountDialogButtonTextCancel',
      desc: '',
      args: [],
    );
  }

  /// `Так, видалити мої дані!`
  String get deleteAccountDialogButtonTextDelete {
    return Intl.message(
      'Так, видалити мої дані!',
      name: 'deleteAccountDialogButtonTextDelete',
      desc: '',
      args: [],
    );
  }

  /// `Після видалення облікового запису ви втратите всі дані (включаючи профіль та історію транзакцій). Це незворотній процес. Ви впевнені, що хочете продовжити?`
  String get deleteAccountDialogContent {
    return Intl.message(
      'Після видалення облікового запису ви втратите всі дані (включаючи профіль та історію транзакцій). Це незворотній процес. Ви впевнені, що хочете продовжити?',
      name: 'deleteAccountDialogContent',
      desc: '',
      args: [],
    );
  }

  /// `Ви справді хочете видалити свій обліковий запис?`
  String get deleteAccountDialogTitle {
    return Intl.message(
      'Ви справді хочете видалити свій обліковий запис?',
      name: 'deleteAccountDialogTitle',
      desc: '',
      args: [],
    );
  }

  /// `ЗАВАНТАЖИТИ`
  String get exportBottomSheetButtonTextDownload {
    return Intl.message(
      'ЗАВАНТАЖИТИ',
      name: 'exportBottomSheetButtonTextDownload',
      desc: '',
      args: [],
    );
  }

  /// `ЕКСПОРТ`
  String get exportBottomSheetButtonTextExport {
    return Intl.message(
      'ЕКСПОРТ',
      name: 'exportBottomSheetButtonTextExport',
      desc: '',
      args: [],
    );
  }

  /// `Експортувати у CSV/JSON`
  String get exportBottomSheetHeadingText {
    return Intl.message(
      'Експортувати у CSV/JSON',
      name: 'exportBottomSheetHeadingText',
      desc: '',
      args: [],
    );
  }

  /// `Дата завершення`
  String get exportBottomSheetLabelTextEndDate {
    return Intl.message(
      'Дата завершення',
      name: 'exportBottomSheetLabelTextEndDate',
      desc: '',
      args: [],
    );
  }

  /// `Дата початку`
  String get exportBottomSheetLabelTextStartDate {
    return Intl.message(
      'Дата початку',
      name: 'exportBottomSheetLabelTextStartDate',
      desc: '',
      args: [],
    );
  }

  /// `Дата початку має бути раніше за дату завершення`
  String get exportBottomSheetTextDateValidationError {
    return Intl.message(
      'Дата початку має бути раніше за дату завершення',
      name: 'exportBottomSheetTextDateValidationError',
      desc: '',
      args: [],
    );
  }

  /// `Натисніть на кнопку + нижче, щоб додати нову витрату/дохід.`
  String get homeDailyNoTransactionsTextSubtitle {
    return Intl.message(
      'Натисніть на кнопку + нижче, щоб додати нову витрату/дохід.',
      name: 'homeDailyNoTransactionsTextSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Список виглядає порожнім...`
  String get homeDailyNoTransactionsTextTitle {
    return Intl.message(
      'Список виглядає порожнім...',
      name: 'homeDailyNoTransactionsTextTitle',
      desc: '',
      args: [],
    );
  }

  /// `Увійти через Google`
  String get loginButtonTextGoogle {
    return Intl.message(
      'Увійти через Google',
      name: 'loginButtonTextGoogle',
      desc: '',
      args: [],
    );
  }

  /// `Увійти як гість`
  String get loginButtonTextGuest {
    return Intl.message(
      'Увійти як гість',
      name: 'loginButtonTextGuest',
      desc: '',
      args: [],
    );
  }

  /// `Monexo — це проста та безпечна програма для керування фінансами, яка допомагає відстежувати доходи та витрати.`
  String get loginTextTagline {
    return Intl.message(
      'Monexo — це проста та безпечна програма для керування фінансами, яка допомагає відстежувати доходи та витрати.',
      name: 'loginTextTagline',
      desc: '',
      args: [],
    );
  }

  /// `ДАЛІ`
  String get profileSetupButtonTextNext {
    return Intl.message(
      'ДАЛІ',
      name: 'profileSetupButtonTextNext',
      desc: '',
      args: [],
    );
  }

  /// `Повне ім’я`
  String get profileSetupLabelTextFullName {
    return Intl.message(
      'Повне ім’я',
      name: 'profileSetupLabelTextFullName',
      desc: '',
      args: [],
    );
  }

  /// `Хто ви?`
  String get profileSetupTextHeadline {
    return Intl.message(
      'Хто ви?',
      name: 'profileSetupTextHeadline',
      desc: '',
      args: [],
    );
  }

  /// `Обліковий запис`
  String get settingsScreenHeaderTitleAccount {
    return Intl.message(
      'Обліковий запис',
      name: 'settingsScreenHeaderTitleAccount',
      desc: '',
      args: [],
    );
  }

  /// `Небезпечна зона`
  String get settingsScreenHeaderTitleDangerZone {
    return Intl.message(
      'Небезпечна зона',
      name: 'settingsScreenHeaderTitleDangerZone',
      desc: '',
      args: [],
    );
  }

  /// `Налаштування`
  String get settingsScreenHeaderTitlePreferences {
    return Intl.message(
      'Налаштування',
      name: 'settingsScreenHeaderTitlePreferences',
      desc: '',
      args: [],
    );
  }

  /// `Акцентний колір`
  String get settingsScreenSettingTitleAccentColor {
    return Intl.message(
      'Акцентний колір',
      name: 'settingsScreenSettingTitleAccentColor',
      desc: '',
      args: [],
    );
  }

  /// `Біометрична безпека`
  String get settingsScreenSettingTitleBiometric {
    return Intl.message(
      'Біометрична безпека',
      name: 'settingsScreenSettingTitleBiometric',
      desc: '',
      args: [],
    );
  }

  /// `Запитує ваш відбиток пальця при кожному відкритті додатку.`
  String get settingsScreenSettingTitleBiometricDescription {
    return Intl.message(
      'Запитує ваш відбиток пальця при кожному відкритті додатку.',
      name: 'settingsScreenSettingTitleBiometricDescription',
      desc: '',
      args: [],
    );
  }

  /// `Валюта`
  String get settingsScreenSettingTitleCurrency {
    return Intl.message(
      'Валюта',
      name: 'settingsScreenSettingTitleCurrency',
      desc: '',
      args: [],
    );
  }

  /// `Видалити обліковий запис`
  String get settingsScreenSettingTitleDeleteAccount {
    return Intl.message(
      'Видалити обліковий запис',
      name: 'settingsScreenSettingTitleDeleteAccount',
      desc: '',
      args: [],
    );
  }

  /// `Мова`
  String get settingsScreenSettingTitleLanguage {
    return Intl.message(
      'Мова',
      name: 'settingsScreenSettingTitleLanguage',
      desc: '',
      args: [],
    );
  }

  /// `Повне ім’я`
  String get settingsScreenSettingTitleName {
    return Intl.message(
      'Повне ім’я',
      name: 'settingsScreenSettingTitleName',
      desc: '',
      args: [],
    );
  }

  /// `Тема`
  String get settingsScreenSettingTitleTheme {
    return Intl.message(
      'Тема',
      name: 'settingsScreenSettingTitleTheme',
      desc: '',
      args: [],
    );
  }

  /// `AMOLED`
  String get settingsScreenSettingTitleThemeAMOLED {
    return Intl.message(
      'AMOLED',
      name: 'settingsScreenSettingTitleThemeAMOLED',
      desc: '',
      args: [],
    );
  }

  /// `Темна`
  String get settingsScreenSettingTitleThemeDark {
    return Intl.message(
      'Темна',
      name: 'settingsScreenSettingTitleThemeDark',
      desc: '',
      args: [],
    );
  }

  /// `Світла`
  String get settingsScreenSettingTitleThemeLight {
    return Intl.message(
      'Світла',
      name: 'settingsScreenSettingTitleThemeLight',
      desc: '',
      args: [],
    );
  }

  /// `Спробуй цей додаток для безпечного керування доходами та витратами: https://pillai.xyz/monexo`
  String get monexoDrawerMessageShare {
    return Intl.message(
      'Спробуй цей додаток для безпечного керування доходами та витратами: https://pillai.xyz/monexo',
      name: 'monexoDrawerMessageShare',
      desc: '',
      args: [],
    );
  }

  /// `Про додаток`
  String get monexoDrawerTextAbout {
    return Intl.message(
      'Про додаток',
      name: 'monexoDrawerTextAbout',
      desc: '',
      args: [],
    );
  }

  /// `Цей додаток є з відкритим кодом і безкоштовний у використанні, під ліцензією Apache 2.0. Якщо ви розробник — долучайтесь до проєкту на GitHub.`
  String get monexoDrawerTextAboutAppLegalese {
    return Intl.message(
      'Цей додаток є з відкритим кодом і безкоштовний у використанні, під ліцензією Apache 2.0. Якщо ви розробник — долучайтесь до проєкту на GitHub.',
      name: 'monexoDrawerTextAboutAppLegalese',
      desc: '',
      args: [],
    );
  }

  /// `Якщо додаток вам подобається і ви ним часто користуєтесь — підтримайте його існування донатом. Реквізити — на сайті або GitHub. Щиро дякуємо!`
  String get monexoDrawerTextAboutFooter {
    return Intl.message(
      'Якщо додаток вам подобається і ви ним часто користуєтесь — підтримайте його існування донатом. Реквізити — на сайті або GitHub. Щиро дякуємо!',
      name: 'monexoDrawerTextAboutFooter',
      desc: '',
      args: [],
    );
  }

  /// `Категорії`
  String get monexoDrawerTextCategories {
    return Intl.message(
      'Категорії',
      name: 'monexoDrawerTextCategories',
      desc: '',
      args: [],
    );
  }

  /// `Валюти`
  String get monexoDrawerTextCurrencies {
    return Intl.message(
      'Валюти',
      name: 'monexoDrawerTextCurrencies',
      desc: '',
      args: [],
    );
  }

  /// `Експортувати у JSON/CSV`
  String get monexoDrawerTextExport {
    return Intl.message(
      'Експортувати у JSON/CSV',
      name: 'monexoDrawerTextExport',
      desc: '',
      args: [],
    );
  }

  /// `Вийти`
  String get monexoDrawerTextLogout {
    return Intl.message(
      'Вийти',
      name: 'monexoDrawerTextLogout',
      desc: '',
      args: [],
    );
  }

  /// `Оцініть додаток`
  String get monexoDrawerTextRate {
    return Intl.message(
      'Оцініть додаток',
      name: 'monexoDrawerTextRate',
      desc: '',
      args: [],
    );
  }

  /// `Налаштування`
  String get monexoDrawerTextSettings {
    return Intl.message(
      'Налаштування',
      name: 'monexoDrawerTextSettings',
      desc: '',
      args: [],
    );
  }

  /// `Поділитися`
  String get monexoDrawerTextShare {
    return Intl.message(
      'Поділитися',
      name: 'monexoDrawerTextShare',
      desc: '',
      args: [],
    );
  }

  /// `ВАШ БАЛАНС`
  String get monexoOverviewTextBalanceHeading {
    return Intl.message(
      'ВАШ БАЛАНС',
      name: 'monexoOverviewTextBalanceHeading',
      desc: '',
      args: [],
    );
  }

  /// `Ви витратили {symbol} {spendAmount} з вашого бюджету {symbol} {budgetAmount} у місяці {monthYear}.`
  String monexoOverviewTextBudgetSet(
    Object symbol,
    Object spendAmount,
    Object budgetAmount,
    Object monthYear,
  ) {
    return Intl.message(
      'Ви витратили $symbol $spendAmount з вашого бюджету $symbol $budgetAmount у місяці $monthYear.',
      name: 'monexoOverviewTextBudgetSet',
      desc: '',
      args: [symbol, spendAmount, budgetAmount, monthYear],
    );
  }

  /// `Натисніть тут, щоб встановити місячний бюджет і краще керувати витратами.`
  String get monexoOverviewTextBudgetUnset {
    return Intl.message(
      'Натисніть тут, щоб встановити місячний бюджет і краще керувати витратами.',
      name: 'monexoOverviewTextBudgetUnset',
      desc: '',
      args: [],
    );
  }

  /// `ДОДАТИ`
  String get transactionBottomSheetButtonTextAdd {
    return Intl.message(
      'ДОДАТИ',
      name: 'transactionBottomSheetButtonTextAdd',
      desc: '',
      args: [],
    );
  }

  /// `Витрата`
  String get transactionBottomSheetButtonTextExpense {
    return Intl.message(
      'Витрата',
      name: 'transactionBottomSheetButtonTextExpense',
      desc: '',
      args: [],
    );
  }

  /// `Дохід`
  String get transactionBottomSheetButtonTextIncome {
    return Intl.message(
      'Дохід',
      name: 'transactionBottomSheetButtonTextIncome',
      desc: '',
      args: [],
    );
  }

  /// `ОНОВИТИ`
  String get transactionBottomSheetButtonTextUpdate {
    return Intl.message(
      'ОНОВИТИ',
      name: 'transactionBottomSheetButtonTextUpdate',
      desc: '',
      args: [],
    );
  }

  /// `Сума`
  String get transactionBottomSheetLabelTextAmount {
    return Intl.message(
      'Сума',
      name: 'transactionBottomSheetLabelTextAmount',
      desc: '',
      args: [],
    );
  }

  /// `Дата`
  String get transactionBottomSheetLabelTextDate {
    return Intl.message(
      'Дата',
      name: 'transactionBottomSheetLabelTextDate',
      desc: '',
      args: [],
    );
  }

  /// `Опис (необов'язково)`
  String get transactionBottomSheetLabelTextDescription {
    return Intl.message(
      'Опис (необов\'язково)',
      name: 'transactionBottomSheetLabelTextDescription',
      desc: '',
      args: [],
    );
  }

  /// `Додати нову транзакцію`
  String get transactionBottomSheetTextHeadingAdd {
    return Intl.message(
      'Додати нову транзакцію',
      name: 'transactionBottomSheetTextHeadingAdd',
      desc: '',
      args: [],
    );
  }

  /// `Оновити транзакцію`
  String get transactionBottomSheetTextHeadingUpdate {
    return Intl.message(
      'Оновити транзакцію',
      name: 'transactionBottomSheetTextHeadingUpdate',
      desc: '',
      args: [],
    );
  }

  /// `{howMany, plural, one {1 транзакція прихована} few {{howMany} транзакції приховані} many {{howMany} транзакцій приховано} other {{howMany} транзакції приховано}}`
  String transactionListHiddenTransactionText(num howMany) {
    return Intl.plural(
      howMany,
      one: '1 транзакція прихована',
      few: '$howMany транзакції приховані',
      many: '$howMany транзакцій приховано',
      other: '$howMany транзакції приховано',
      name: 'transactionListHiddenTransactionText',
      desc: '',
      args: [howMany],
    );
  }

  /// `ОЧИСТИТИ`
  String get updateBudgetBottomSheetButtonTextClear {
    return Intl.message(
      'ОЧИСТИТИ',
      name: 'updateBudgetBottomSheetButtonTextClear',
      desc: '',
      args: [],
    );
  }

  /// `ВСТАНОВИТИ БЮДЖЕТ`
  String get updateBudgetBottomSheetButtonTextSetBudget {
    return Intl.message(
      'ВСТАНОВИТИ БЮДЖЕТ',
      name: 'updateBudgetBottomSheetButtonTextSetBudget',
      desc: '',
      args: [],
    );
  }

  /// `Введіть місячний бюджет, який вважаєте помірним згідно з вашими витратами.`
  String get updateBudgetBottomSheetHeadingText {
    return Intl.message(
      'Введіть місячний бюджет, який вважаєте помірним згідно з вашими витратами.',
      name: 'updateBudgetBottomSheetHeadingText',
      desc: '',
      args: [],
    );
  }

  /// `Бюджет`
  String get updateBudgetBottomSheetLabelTextBudget {
    return Intl.message(
      'Бюджет',
      name: 'updateBudgetBottomSheetLabelTextBudget',
      desc: '',
      args: [],
    );
  }

  /// `Без категорії`
  String get noCategory {
    return Intl.message(
      'Без категорії',
      name: 'noCategory',
      desc: '',
      args: [],
    );
  }

  /// `Баланс на рахунку`
  String get balanceOnTheAccount {
    return Intl.message(
      'Баланс на рахунку',
      name: 'balanceOnTheAccount',
      desc: '',
      args: [],
    );
  }

  /// `Доходи`
  String get revenue {
    return Intl.message('Доходи', name: 'revenue', desc: '', args: []);
  }

  /// `Витрати`
  String get costs {
    return Intl.message('Витрати', name: 'costs', desc: '', args: []);
  }

  /// `Додати нову категорію типу {type}`
  String addANewTypeTypeCategory(Object type) {
    return Intl.message(
      'Додати нову категорію типу $type',
      name: 'addANewTypeTypeCategory',
      desc: '',
      args: [type],
    );
  }

  /// `Назва категорії`
  String get categoryTitle {
    return Intl.message(
      'Назва категорії',
      name: 'categoryTitle',
      desc: '',
      args: [],
    );
  }

  /// `СКАСУВАТИ`
  String get cancel {
    return Intl.message('СКАСУВАТИ', name: 'cancel', desc: '', args: []);
  }

  /// `Натисніть тут, щоб встановити місячний бюджет і краще керувати витратами.`
  String get clickHereToSetTheMonthlyBudgetAndBetterManage {
    return Intl.message(
      'Натисніть тут, щоб встановити місячний бюджет і краще керувати витратами.',
      name: 'clickHereToSetTheMonthlyBudgetAndBetterManage',
      desc: '',
      args: [],
    );
  }

  /// `Категорії`
  String get categories {
    return Intl.message('Категорії', name: 'categories', desc: '', args: []);
  }

  /// `Додати нову`
  String get addANewOne {
    return Intl.message('Додати нову', name: 'addANewOne', desc: '', args: []);
  }

  /// `Додати нову транзакцію`
  String get addANewTransaction {
    return Intl.message(
      'Додати нову транзакцію',
      name: 'addANewTransaction',
      desc: '',
      args: [],
    );
  }

  /// `Оновити транзакцію`
  String get updateTheTransaction {
    return Intl.message(
      'Оновити транзакцію',
      name: 'updateTheTransaction',
      desc: '',
      args: [],
    );
  }

  /// `Витрата`
  String get cost {
    return Intl.message('Витрата', name: 'cost', desc: '', args: []);
  }

  /// `Дохід`
  String get income {
    return Intl.message('Дохід', name: 'income', desc: '', args: []);
  }

  /// `Сума`
  String get suma {
    return Intl.message('Сума', name: 'suma', desc: '', args: []);
  }

  /// `Дата`
  String get date {
    return Intl.message('Дата', name: 'date', desc: '', args: []);
  }

  /// `Опис (необов'язково)`
  String get descriptionNot {
    return Intl.message(
      'Опис (необов\'язково)',
      name: 'descriptionNot',
      desc: '',
      args: [],
    );
  }

  /// `ДОДАТИ`
  String get add {
    return Intl.message('ДОДАТИ', name: 'add', desc: '', args: []);
  }

  /// `ОНОВИТИ`
  String get update {
    return Intl.message('ОНОВИТИ', name: 'update', desc: '', args: []);
  }

  /// `Будь ласка, введіть суму`
  String get pleaseEnterTheAmount {
    return Intl.message(
      'Будь ласка, введіть суму',
      name: 'pleaseEnterTheAmount',
      desc: '',
      args: [],
    );
  }

  /// `Невірний формат числа`
  String get incorrectNumberFormat {
    return Intl.message(
      'Невірний формат числа',
      name: 'incorrectNumberFormat',
      desc: '',
      args: [],
    );
  }

  /// `Будь ласка, введіть коректне число`
  String get pleaseEnterTheCorrectNumber {
    return Intl.message(
      'Будь ласка, введіть коректне число',
      name: 'pleaseEnterTheCorrectNumber',
      desc: '',
      args: [],
    );
  }

  /// `Сума повинна бути більше 0`
  String get theAmountShouldBeMoreThan0 {
    return Intl.message(
      'Сума повинна бути більше 0',
      name: 'theAmountShouldBeMoreThan0',
      desc: '',
      args: [],
    );
  }

  /// `Сума може мати максимум 2 знаки після коми`
  String get aSumMayHaveAMaximumOf2ComaSigns {
    return Intl.message(
      'Сума може мати максимум 2 знаки після коми',
      name: 'aSumMayHaveAMaximumOf2ComaSigns',
      desc: '',
      args: [],
    );
  }

  /// `Список виглядає порожнім...`
  String get theListLooksEmpty {
    return Intl.message(
      'Список виглядає порожнім...',
      name: 'theListLooksEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Натисніть на кнопку + нижче, щоб додати нову витрату/дохід.`
  String get clickTheButtonBelowToAddANewCostincome {
    return Intl.message(
      'Натисніть на кнопку + нижче, щоб додати нову витрату/дохід.',
      name: 'clickTheButtonBelowToAddANewCostincome',
      desc: '',
      args: [],
    );
  }

  /// `1 транзакція прихована`
  String get oneTransactionIsHidden {
    return Intl.message(
      '1 транзакція прихована',
      name: 'oneTransactionIsHidden',
      desc: '',
      args: [],
    );
  }

  /// `{howMany} транзакції приховані`
  String howmanyTransactionsAreHidden(Object howMany) {
    return Intl.message(
      '$howMany транзакції приховані',
      name: 'howmanyTransactionsAreHidden',
      desc: '',
      args: [howMany],
    );
  }

  /// `{howMany} транзакцій приховано`
  String manyTransactionsAreHidden(Object howMany) {
    return Intl.message(
      '$howMany транзакцій приховано',
      name: 'manyTransactionsAreHidden',
      desc: '',
      args: [howMany],
    );
  }

  /// `Monexo — це проста та безпечна програма для керування фінансами, яка допомагає відстежувати доходи та витрати.`
  String get appPromoDescription {
    return Intl.message(
      'Monexo — це проста та безпечна програма для керування фінансами, яка допомагає відстежувати доходи та витрати.',
      name: 'appPromoDescription',
      desc: '',
      args: [],
    );
  }

  /// `Увійти через Google`
  String get loginThroughGoogle {
    return Intl.message(
      'Увійти через Google',
      name: 'loginThroughGoogle',
      desc: '',
      args: [],
    );
  }

  /// `Увійти як гість`
  String get enterAsAGuest {
    return Intl.message(
      'Увійти як гість',
      name: 'enterAsAGuest',
      desc: '',
      args: [],
    );
  }

  /// `Головна`
  String get home {
    return Intl.message('Головна', name: 'home', desc: '', args: []);
  }

  /// `Статистика`
  String get statistics {
    return Intl.message('Статистика', name: 'statistics', desc: '', args: []);
  }

  /// `Налаштування`
  String get settingUp {
    return Intl.message('Налаштування', name: 'settingUp', desc: '', args: []);
  }

  /// `Створіть свій основний рахунок`
  String get createYourMainAccount {
    return Intl.message(
      'Створіть свій основний рахунок',
      name: 'createYourMainAccount',
      desc: '',
      args: [],
    );
  }

  /// `Назва рахунку`
  String get accountName {
    return Intl.message(
      'Назва рахунку',
      name: 'accountName',
      desc: '',
      args: [],
    );
  }

  /// `Введіть назву рахунку`
  String get enterTheAccountName {
    return Intl.message(
      'Введіть назву рахунку',
      name: 'enterTheAccountName',
      desc: '',
      args: [],
    );
  }

  /// `Обов'язково поле`
  String get mandatoryField {
    return Intl.message(
      'Обов\'язково поле',
      name: 'mandatoryField',
      desc: '',
      args: [],
    );
  }

  /// `Назва повинна містити не менше 3 символів`
  String get theNameMustContainAtLeast3Characters {
    return Intl.message(
      'Назва повинна містити не менше 3 символів',
      name: 'theNameMustContainAtLeast3Characters',
      desc: '',
      args: [],
    );
  }

  /// `Валюта`
  String get currency {
    return Intl.message('Валюта', name: 'currency', desc: '', args: []);
  }

  /// `Бюджет`
  String get budget {
    return Intl.message('Бюджет', name: 'budget', desc: '', args: []);
  }

  /// `Введіть місячний бюджет`
  String get enterTheMonthlyBudget {
    return Intl.message(
      'Введіть місячний бюджет',
      name: 'enterTheMonthlyBudget',
      desc: '',
      args: [],
    );
  }

  /// `Введіть коректну суму`
  String get enterTheCorrectAmount {
    return Intl.message(
      'Введіть коректну суму',
      name: 'enterTheCorrectAmount',
      desc: '',
      args: [],
    );
  }

  /// `ДАЛІ`
  String get further {
    return Intl.message('ДАЛІ', name: 'further', desc: '', args: []);
  }

  /// `Додайте дані про себе`
  String get addDataAboutYourself {
    return Intl.message(
      'Додайте дані про себе',
      name: 'addDataAboutYourself',
      desc: '',
      args: [],
    );
  }

  /// `Ваше ім'я`
  String get yourName {
    return Intl.message('Ваше ім\'я', name: 'yourName', desc: '', args: []);
  }

  /// `Електронна пошта`
  String get email {
    return Intl.message('Електронна пошта', name: 'email', desc: '', args: []);
  }

  /// `Вийти`
  String get goOut {
    return Intl.message('Вийти', name: 'goOut', desc: '', args: []);
  }

  /// `Основне`
  String get basic {
    return Intl.message('Основне', name: 'basic', desc: '', args: []);
  }

  /// `День`
  String get day {
    return Intl.message('День', name: 'day', desc: '', args: []);
  }

  /// `Тиждень`
  String get week {
    return Intl.message('Тиждень', name: 'week', desc: '', args: []);
  }

  /// `Місяць`
  String get month {
    return Intl.message('Місяць', name: 'month', desc: '', args: []);
  }

  /// `Введіть місячний бюджет, який вважаєте помірним згідно з вашими витратами.`
  String get enterTheMonthlyBudgetThatYouConsiderToBeModerate {
    return Intl.message(
      'Введіть місячний бюджет, який вважаєте помірним згідно з вашими витратами.',
      name: 'enterTheMonthlyBudgetThatYouConsiderToBeModerate',
      desc: '',
      args: [],
    );
  }

  /// `ВІДМІНА`
  String get abolition {
    return Intl.message('ВІДМІНА', name: 'abolition', desc: '', args: []);
  }

  /// `ЗБЕРЕГТИ`
  String get save {
    return Intl.message('ЗБЕРЕГТИ', name: 'save', desc: '', args: []);
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[Locale.fromSubtags(languageCode: 'uk')];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}

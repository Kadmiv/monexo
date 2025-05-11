import 'package:monexo/models/models.dart';
import 'package:monexo/services/currency_provider.dart';
import 'package:package_info/package_info.dart';

String formatAmount(Currency currency, double amount) {
  return '${amount >= 0 ? '' : '- '}${currency.symbol} ${amount.abs().toStringAsFixed(2)}'
      .replaceAllMapped(
    new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
    (Match m) => '${m[1]},',
  );
}

double calculateAbsoluteSum(List<TransactionModel> transactions) {
  return transactions.fold<double>(0, (value, txn) => value + txn.amount).abs();
}

String transformCategoryToKey(CategoryModel? category) {
  return category == null ? 'Без категорії' : (category.name);
}

Future<String> getVersionCode() async {
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  String version = packageInfo.version;
  String buildNumber = packageInfo.buildNumber;

  return '$version ($buildNumber)';
}

Currency get currency => CurrencyProvider().getAllCurrencies().first;

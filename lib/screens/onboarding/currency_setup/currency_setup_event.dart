import 'package:monexo/models/currency.dart';

abstract class CurrencySetupEvent {
  const CurrencySetupEvent();
}

class LoadCurrenciesEvent extends CurrencySetupEvent {
  const LoadCurrenciesEvent();
}

class CreateAccountEvent extends CurrencySetupEvent {
  final String accountName;
  final double budget;
  final Currency currency;

  const CreateAccountEvent({
    required this.accountName,
    required this.budget,
    required this.currency,
  });
} 
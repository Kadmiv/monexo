import 'package:monexo/models/currency.dart';

abstract class CurrencySetupState {
  const CurrencySetupState();
}

class CurrencySetupInitial extends CurrencySetupState {
  const CurrencySetupInitial();
}

class CurrencySetupLoading extends CurrencySetupState {
  const CurrencySetupLoading();
}

class CurrencySetupLoaded extends CurrencySetupState {
  final List<Currency> currencies;

  const CurrencySetupLoaded(this.currencies);
}

class CurrencySetupError extends CurrencySetupState {
  final String message;

  const CurrencySetupError(this.message);
}

class CurrencySetupSuccess extends CurrencySetupState {
  const CurrencySetupSuccess();
} 
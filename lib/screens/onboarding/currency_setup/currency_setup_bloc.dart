import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:monexo/models/account.dart';
import 'package:monexo/models/currency.dart';
import 'package:monexo/services/category_provider.dart';
import 'package:monexo/services/currency_provider.dart';
import 'package:monexo/services/account_provider.dart';
import 'package:monexo/services/services.dart';

import 'currency_setup_event.dart';
import 'currency_setup_state.dart';

class CurrencySetupBloc extends Bloc<CurrencySetupEvent, CurrencySetupState> {
  CurrencySetupBloc() : super(const CurrencySetupInitial()) {
    on<LoadCurrenciesEvent>(_onLoadCurrencies);
    on<CreateAccountEvent>(_onCreateAccount);
  }

  final CurrencyProvider _currencyProvider = CurrencyProvider();
  final AccountProvider _accountService = AccountProvider();
  final CategoryProvider _categoryProvider = CategoryProvider();

  final AuthService _authService = AuthService();

  Future<void> _onLoadCurrencies(
    LoadCurrenciesEvent event,
    Emitter<CurrencySetupState> emit,
  ) async {
    try {
      emit(const CurrencySetupLoading());
      final currencies = _currencyProvider.getAllCurrencies();
      emit(CurrencySetupLoaded(currencies));
    } catch (e) {
      emit(CurrencySetupError(e.toString()));
    }
  }

  Future<void> _onCreateAccount(
    CreateAccountEvent event,
    Emitter<CurrencySetupState> emit,
  ) async {
    try {
      emit(const CurrencySetupLoading());
      
      final user = await _authService.getUser;
      if (user == null) {
        throw Exception('User not authenticated');
      }

      final defaultAccount = Account(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: event.accountName,
        currency: event.currency.id,
        budget: event.budget,
        userId: user.uid,
      );

      await _categoryProvider.setupCategories();
      await _accountService.createAccount(defaultAccount);
      emit(const CurrencySetupSuccess());
    } catch (e) {
      emit(CurrencySetupError(e.toString()));
    }
  }
} 
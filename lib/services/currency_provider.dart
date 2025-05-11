import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:monexo/models/models.dart';

/// Provider для роботи з валютами - вони зберігаються в файлі assets/data/currency.json
class CurrencyProvider {
  static final CurrencyProvider _instance = CurrencyProvider._internal();

  factory CurrencyProvider() {
    return _instance;
  }

  CurrencyProvider._internal();

  List<Currency> _currencies = [];


  init() async {
    await _loadCurrencies();
  }

  Future<void> _loadCurrencies() async {
    final String jsonString =
        await rootBundle.loadString('assets/data/currency.json');
    final List<dynamic> jsonList = json.decode(jsonString);
    _currencies = jsonList.map((json) => Currency.fromJson(json)).toList();
  }

  List<Currency> getAllCurrencies() {
    return _currencies;
  }
}

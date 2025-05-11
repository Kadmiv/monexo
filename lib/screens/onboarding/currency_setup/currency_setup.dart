import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:monexo/generated/l10n.dart';
import 'package:monexo/models/currency.dart';
import 'package:monexo/screens/main/main.dart';
import 'package:monexo/shared/onboarding_header.dart';
import 'package:monexo/shared/widgets/custom_button.dart';

import 'currency_setup_bloc.dart';
import 'currency_setup_event.dart';
import 'currency_setup_state.dart';

/// Сторінка для створення основного рахунку - вибір валюти та назви рахунку
final class CurrencySetupScreen extends StatefulWidget {
  static const String routeName = '/currency-setup';

  const CurrencySetupScreen({super.key});

  @override
  State<CurrencySetupScreen> createState() => _CurrencySetupScreenState();
}

class _CurrencySetupScreenState extends State<CurrencySetupScreen> {
  final _bloc = CurrencySetupBloc();
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final budgetController = TextEditingController();
  Currency? selectedCurrency;
  var currencies = <Currency>[];

  @override
  void initState() {
    super.initState();
    _bloc.add(const LoadCurrenciesEvent());
  }

  @override
  void dispose() {
    _bloc.close();
    nameController.dispose();
    budgetController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _bloc,
      child: BlocListener<CurrencySetupBloc, CurrencySetupState>(
        listener: (context, state) {
          if (state is CurrencySetupSuccess) {
            Navigator.pushReplacementNamed(context, MainScreen.routeName);
          } else if (state is CurrencySetupError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          } else if (state is CurrencySetupLoaded) {
            currencies = state.currencies;
          }
        },
        child: Scaffold(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              OnboardingHeader(
                child: Column(
                  children: [
                    const SizedBox(height: 50),
                    Icon(
                      Icons.currency_exchange,
                      size: 42,
                      color: Theme.of(context).colorScheme.surface,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      S.of(context).createYourMainAccount,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 50),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        /// Назва рахунку
                        TextFormField(
                          controller: nameController,
                          decoration: InputDecoration(
                            labelText: S.of(context).accountName,
                            errorMaxLines: 1,
                            hintText: S.of(context).enterTheAccountName,
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return S.of(context).mandatoryField;
                            }
                            if (value.length < 3) {
                              return S
                                  .of(context)
                                  .theNameMustContainAtLeast3Characters;
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 24),

                        /// Валюта
                        DropdownButtonFormField<Currency>(
                          value: selectedCurrency,
                          decoration: InputDecoration(
                            labelText: S.of(context).currency,
                          ),
                          dropdownColor:
                              Theme.of(context).colorScheme.outlineVariant,
                          items: currencies.map((Currency currency) {
                            return DropdownMenuItem<Currency>(
                              value: currency,
                              child:
                                  Text('${currency.name} (${currency.symbol})'),
                            );
                          }).toList(),
                          onChanged: (Currency? newValue) {
                            setState(() {
                              selectedCurrency = newValue;
                            });
                          },
                          validator: (value) {
                            if (value == null) {
                              return S.of(context).mandatoryField;
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 24),

                        /// Бюджет
                        TextFormField(
                          controller: budgetController,
                          decoration: InputDecoration(
                            labelText: S.of(context).budget,
                            hintText: S.of(context).enterTheMonthlyBudget,
                            errorMaxLines: 1,
                            suffixText: selectedCurrency?.symbol ?? '',
                          ),
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return S.of(context).mandatoryField;
                            }
                            final budget = double.tryParse(value);
                            if (budget == null || budget < 0) {
                              return S.of(context).enterTheCorrectAmount;
                            }
                            return null;
                          },
                        ),
                        Spacer(),

                        /// Далі
                        BlocBuilder<CurrencySetupBloc, CurrencySetupState>(
                          builder: (context, state) {
                            return CustomButton(
                              title: S.of(context).further,
                              onPressed: state is CurrencySetupLoading
                                  ? null
                                  : _onSubmit,
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onSubmit() {
    if (formKey.currentState!.validate() && selectedCurrency != null) {
      _bloc.add(
        CreateAccountEvent(
          accountName: nameController.text.trim(),
          budget: double.parse(budgetController.text.trim()),
          currency: selectedCurrency!,
        ),
      );
    }
  }
}

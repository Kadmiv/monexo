import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:monexo/generated/l10n.dart';
import 'package:monexo/models/account.dart';
import 'package:monexo/models/currency.dart';
import 'package:monexo/screens/onboarding/currency_setup/currency_setup_bloc.dart';
import 'package:monexo/screens/onboarding/currency_setup/currency_setup_event.dart';
import 'package:monexo/screens/onboarding/currency_setup/currency_setup_state.dart';
import 'package:monexo/services/account_provider.dart';

/// Сторінка для оновлення інформації про рахунок - можна ввести новий бюджет
final class UpdateAccountDialog extends StatefulWidget {
  final Account account;

  const UpdateAccountDialog({
    super.key,
    required this.account,
  });

  @override
  State<UpdateAccountDialog> createState() => _UpdateAccountDialogState();
}

class _UpdateAccountDialogState extends State<UpdateAccountDialog> {
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
    nameController.text = widget.account.title;
    budgetController.text = widget.account.budget!.toStringAsFixed(0);
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
    return Container(
      margin: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            S.of(context).enterTheMonthlyBudgetThatYouConsiderToBeModerate,
            textAlign: TextAlign.center,
            style: const TextStyle(
              height: 1.5,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 20),
          BlocProvider(
            create: (context) => _bloc,
            child: BlocListener<CurrencySetupBloc, CurrencySetupState>(
              listener: (context, state) {
                if (state is CurrencySetupSuccess) {
                  Navigator.pop(context);
                } else if (state is CurrencySetupError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.message)),
                  );
                } else if (state is CurrencySetupLoaded) {
                  currencies = state.currencies;
                  setState(() {
                    selectedCurrency = currencies.first;
                  });
                }
              },
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      /// Назва рахунку
                      TextFormField(
                        controller: nameController,
                        decoration:  InputDecoration(
                          labelText: S.of(context).accountName,
                          errorMaxLines: 1,
                          hintText: S.of(context).enterTheAccountName,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return S.of(context).mandatoryField;
                          }
                          if (value.length < 3) {
                            return S.of(context).theNameMustContainAtLeast3Characters;
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 24),
                      
                      /// Валюта
                      Visibility(
                        visible: false,
                        child: DropdownButtonFormField<Currency>(
                          value: selectedCurrency,
                          decoration:  InputDecoration(
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
                      const SizedBox(height: 34),
                      
                      Wrap(
                        alignment: WrapAlignment.center,
                        children: <Widget>[
                          /// Відмінити зміни
                          TextButton.icon(
                            onPressed: () {
                              AccountProvider()
                                  .updateAccount(widget.account.copyWith(
                                budget: null,
                              ));
                              Navigator.pop(context);
                            },
                            style: TextButton.styleFrom(
                              foregroundColor: Colors.red,
                            ),
                            icon: const Icon(Icons.clear),
                            label: Text(
                              S.of(context).abolition,
                            ),
                          ),
                          /// Зберегти
                          TextButton.icon(
                            onPressed: _onSubmit,
                            style: TextButton.styleFrom(
                              foregroundColor:
                                  Theme.of(context).colorScheme.primary,
                            ),
                            icon: const Icon(Icons.check),
                            label: Text(
                              S.of(context).save,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  void _onSubmit() {
    if (formKey.currentState!.validate() && selectedCurrency != null) {
      try {
        final budget = double.parse(budgetController.text);
        AccountProvider().updateAccount(widget.account.copyWith(
          budget: budget,
          title: nameController.text,
          currency: selectedCurrency!.id,
        ));
        Navigator.pop(context);
      } catch (e) {
        debugPrint('Error parsing budget: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Будь ласка, введіть коректне число'),
          ),
        );
      }
    }
  }
}

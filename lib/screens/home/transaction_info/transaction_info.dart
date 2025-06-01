import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:monexo/generated/l10n.dart';
import 'package:monexo/models/account.dart';
import 'package:monexo/models/models.dart';
import 'package:monexo/shared/transaction/category_selector.dart';
import 'package:monexo/shared/widgets/custom_button.dart';

import 'transaction_info_bloc.dart';
import 'transaction_info_event.dart';
import 'transaction_info_state.dart';

/// Сторінка для створення/зміни інформації про транзакцію
class TransactionInfoScreen extends StatefulWidget {
  const TransactionInfoScreen({
    super.key,
    this.transaction,
    this.account,
  });

  final TransactionModel? transaction;
  final Account? account;

  @override
  _TransactionInfoScreenState createState() => _TransactionInfoScreenState();
}

class _TransactionInfoScreenState extends State<TransactionInfoScreen>
    with TickerProviderStateMixin {
  late TabController _tabController = TabController(length: 2, vsync: this);

  final _formKey = GlobalKey<FormState>();

  var _descriptionNode = FocusNode();
  var _amountNode = FocusNode();

  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

  late final TransactionInfoBloc _bloc = TransactionInfoBloc();
  TransactionModel? transaction;
  List<CategoryModel>? categories;

  bool get isIncome => _tabController.index == 1;

  @override
  void initState() {
    super.initState();

    _bloc.add(TransactionInfoInitialized(transaction: widget.transaction));
    _tabController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    _amountController.dispose();
    _dateController.dispose();
    _descriptionNode.dispose();
    _amountNode.dispose();
    _bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _bloc,
      child: BlocListener<TransactionInfoBloc, TransactionInfoState>(
        listener: (context, state) {
          if (state is TransactionCreationSuccess) {
            Navigator.pop(context);
          } else if (state is TransactionInfoError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          } else if (state is TransactionInfoLoaded) {
            transaction = state.transaction;
            categories = state.categories;
            final isIncome = state.transaction?.isIncome ?? false;
            _tabController.index = isIncome ? 1 : 0;

            final amount = state.transaction?.amount ?? 0;
            _amountController.text = amount != 0 ? amount.abs().toString() : '';
            setDate(transaction?.timestamp ?? DateTime.now());
            _descriptionController.text = state.transaction?.description ?? '';
          }
        },
        child: BlocBuilder<TransactionInfoBloc, TransactionInfoState>(
          builder: (context, state) {
            return Container(
              // height: MediaQuery.of(context).size.height * 0.85,
              padding: const EdgeInsets.symmetric(
                vertical: 20,
                horizontal: 20,
              ),
              child: SafeArea(
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      /// Відображення заголовка - створення або оновлення транзакції
                      Text(
                        (widget.transaction == null)
                            ? S.of(context).addANewTransaction
                            : S.of(context).updateTheTransaction,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 20),

                      /// Відображення вкладок для вибору типу транзакції
                      TabBar(
                        controller: _tabController,
                        indicator: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        indicatorSize: TabBarIndicatorSize.tab,
                        dividerColor: Colors.transparent,
                        labelColor: Colors.white,
                        unselectedLabelColor: Colors.white,
                        tabs: [
                          Tab(text: S.of(context).cost),
                          Tab(text: S.of(context).income),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Column(
                        children: <Widget>[
                          /// Відображення вибору категорії транзакції
                          buildCategorySelector(getFilteredCategories(isIncome),
                              transaction?.category),
                          const SizedBox(height: 20),

                          /// Відображення поля для введення суми
                          TextFormField(
                            focusNode: _amountNode,
                            controller: _amountController,
                            keyboardType: const TextInputType.numberWithOptions(
                              decimal: true,
                              signed: false,
                            ),
                            onChanged: (v) {
                              final amount = double.tryParse(v);
                              setState(() {
                                transaction =
                                    transaction?.copyWith(amount: amount);
                              });
                            },
                            validator: validateAmount,
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                isIncome ?? false ? Icons.add : Icons.remove,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                              labelText: S.of(context).suma,
                            ),
                          ),
                          const SizedBox(height: 20),

                          /// Відображення поля для введення дати
                          TextFormField(
                            onTap: () async {
                              final date = await showDatePicker(
                                context: context,
                                initialDate:
                                    transaction?.timestamp ?? DateTime.now(),
                                firstDate: DateTime(1990),
                                lastDate: DateTime.now(),
                              );

                              if (date != null) {
                                setDate(date);
                              }
                            },
                            controller: _dateController,
                            readOnly: true,
                            decoration: InputDecoration(
                              labelText: S.of(context).date,
                            ),
                          ),
                          const SizedBox(height: 20),

                          /// Відображення поля для введення опису
                          TextFormField(
                            focusNode: _descriptionNode,
                            controller: _descriptionController,
                            textCapitalization: TextCapitalization.words,
                            onChanged: (v) => setState(() {
                              transaction =
                                  transaction?.copyWith(description: v);
                            }),
                            onEditingComplete: () => FocusScope.of(context)
                                .requestFocus(_amountNode),
                            decoration: InputDecoration(
                              labelText: S.of(context).descriptionNot,
                            ),
                          ),
                          const SizedBox(height: 20),

                          /// Відображення кнопки для створення або оновлення транзакції
                          state is TransactionCreationLoading
                              ? CircularProgressIndicator()
                              : CustomButton(
                                  title: (widget.transaction == null)
                                      ? S.of(context).add
                                      : S.of(context).update,
                                  onPressed: state is TransactionInfoLoading
                                      ? null
                                      : _validateAndSubmit,
                                ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void setDate(DateTime date) {
    _dateController.text = DateFormat().add_yMMMMd().format(date);
    transaction = transaction?.copyWith(timestamp: date);
  }

  /// Перевірка введеного значення суми
  String? validateAmount(String? value) {
    if (value == null || value.isEmpty) {
      return S.of(context).pleaseEnterTheAmount;
    }

    // Remove any whitespace
    value = value.trim();

    // Handle comma as decimal separator
    value = value.replaceAll(',', '.');

    // Remove any currency symbols or spaces
    value = value.replaceAll(RegExp(r'[^\d.]'), '');

    // Check if there are multiple decimal points
    if (value.split('.').length > 2) {
      return S.of(context).incorrectNumberFormat;
    }

    final amount = double.tryParse(value);
    if (amount == null) {
      return S.of(context).pleaseEnterTheCorrectNumber;
    }

    if (amount <= 0) {
      return S.of(context).theAmountShouldBeMoreThan0;
    }

    // Check if amount has more than 2 decimal places
    if (value.contains('.') && value.split('.')[1].length > 2) {
      return S.of(context).aSumMayHaveAMaximumOf2ComaSigns;
    }

    return null;
  }

  /// Відображення вибору категорії транзакції
  Widget buildCategorySelector(
    List<CategoryModel> categories,
    CategoryModel? selectedCategory,
  ) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        /// Відображення обраної категорії
        if (selectedCategory != null)
          Row(
            children: <Widget>[
              Container(
                width: 80,
                height: 80,
                child: CategorySelector(
                  isSelected: false,
                  category: selectedCategory!,
                ),
                decoration: BoxDecoration(
                  border: Border(
                    right: BorderSide(
                      width: 1,
                      color: Colors.grey.withOpacity(0.5),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
            ],
          ),

        /// Відображення списку категорій
        Expanded(
          child: Container(
            width: double.infinity,
            height: 80,
            child: ListView.builder(
              itemExtent: 90,
              shrinkWrap: true,
              itemCount: categories.length,
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                final category = categories[index];
                return CategorySelector(
                  category: category,
                  isSelected: category.name == selectedCategory?.name,
                  onPressed: () => setState(() {
                    transaction = transaction?.copyWith(category: category);
                  }),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  List<CategoryModel> getFilteredCategories(bool isIncome) {
    return (categories ?? [])
        .where((x) =>
            x.type == (isIncome ? CategoryType.income : CategoryType.expense))
        .toList();
  }

  void _validateAndSubmit() {
    final hasCategory = transaction?.category != null;
    if (_formKey.currentState!.validate() && hasCategory) {
      _bloc.add(TransactionSubmitted(transaction, widget.account));
    }
  }
}

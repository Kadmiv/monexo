import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:monexo/config/config.dart';
import 'package:monexo/generated/l10n.dart';
import 'package:monexo/models/account.dart';
import 'package:monexo/models/transaction.dart';
import 'package:monexo/shared/dialogs/update_budget.dart';

/// Віджет для перегляду загальної інформації про рахунок та витрати
final class TransactionsOverview extends StatelessWidget {
  const TransactionsOverview({
    required this.account,
    required this.balance,
    required this.expenses,
    required this.onEditBudgetTap,
    super.key,
  });

  final Account account;
  final double balance;
  final List<TransactionModel> expenses;
  final void Function() onEditBudgetTap;

  @override
  Widget build(BuildContext context) {
    final isNegativeBalance = balance < 0;
    return InkWell(
      onTap: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          builder: (context) => UpdateAccountDialog(
            account: account,
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(12),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    /// Назва рахунку
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                '${account.title ?? ''}',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Theme.of(context).colorScheme.surface,
                                  fontWeight: FontWeight.w700,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 12),

                    /// Кнопка налаштування рахунку
                    InkWell(
                      onTap: onEditBudgetTap,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Theme.of(context).colorScheme.surface,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Icon(
                            Icons.edit,
                            size: 14,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        S.of(context).balanceOnTheAccount,
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),

                /// Відображення інформації про рахунок та витрати
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            formatAmount(currency, balance),
                            style: TextStyle(
                              fontSize: 30,
                              color: isNegativeBalance
                                  ? Colors.red.shade300
                                  : Colors.white,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          const SizedBox(height: 8),
                          if (account.budget != null)
                            Text(
                              'Ви витратили ${currency.symbol ?? ''} ${calculateAbsoluteSum(expenses).toStringAsFixed(2)} з вашого бюджету ${currency.symbol ?? ''} ${(account.budget ?? 0).toStringAsFixed(2)} у місяці ${DateFormat('MMMM y').format(DateTime.now())}.',
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            )
                          else
                            Text(
                              S
                                  .of(context)
                                  .clickHereToSetTheMonthlyBudgetAndBetterManage,
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),

                /// Відображення інформації про використання  буджету та процент витрат
                if (account.budget != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Builder(
                      builder: (context) {
                        final expensesSum = calculateAbsoluteSum(expenses);
                        final expensesPerc =
                            (expensesSum / (account.budget ?? 1)).toDouble();
                        return Stack(
                          children: [
                            Center(
                              child: LinearProgressIndicator(
                                value: expensesPerc,
                                color: Theme.of(context).colorScheme.surface,
                                backgroundColor: Colors.white,
                                minHeight: 28,
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            Positioned(
                              top: 0,
                              right: 0,
                              bottom: 0,
                              left: 0,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(6),
                                      color: (expensesPerc < 1)
                                          ? Colors.green
                                          : Colors.red,
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 6, vertical: 1),
                                    child: Text(
                                      '$expensesSum (${((expensesPerc * 100).toStringAsFixed(0))}%)',
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        );
                      },
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:monexo/config/config.dart';
import 'package:monexo/generated/l10n.dart';
import 'package:monexo/models/models.dart';


/// Виджет для отображения отдельной транзакции в списке
final class TransactionListTile extends StatelessWidget {
  /// Данные транзакции
  final TransactionModel transaction;

  const TransactionListTile(
    this.transaction, {
    required this.onTransactionTap,
    required this.onDeleteTransactionTap,
    super.key,
  });

  final void Function() onTransactionTap;
  final void Function() onDeleteTransactionTap;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(transaction.id),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        if (direction == DismissDirection.endToStart) {
          onDeleteTransactionTap();
        }
      },
      background: buildRightSwipeBackground(),
      child: InkWell(
        onTap: onTransactionTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Colors.grey.withOpacity(0.15),
              ),
            ),
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: <Widget>[
                buildCategoryIcon(),
                const SizedBox(width: 10),
                Expanded(child: buildMeta(context)),
                buildAmount(currency),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Создает фон для свайпа вправо (удаление)
  Container buildRightSwipeBackground() {
    return Container(
      color: Colors.red,
      child: const Align(
        alignment: Alignment.centerRight,
        child: Padding(
          padding: EdgeInsets.only(right: 20),
          child: Icon(
            Icons.delete,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  /// Создает иконку категории транзакции
  Container buildCategoryIcon() {
    return Container(
      width: 24,
      height: 24,
      margin: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 6,
      ),
      child: Image.asset('assets/categories/${transaction.category?.icon}.png'),
    );
  }

  /// Создает метаданные транзакции (название категории, время, описание)
  Column buildMeta(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          transformCategoryToKey(transaction.category),
          style: transactionTitleStyle,
        ),
        const SizedBox(height: 2),
        if (transaction.description != null)
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Text(
                  '${transaction.description}',
                  overflow: TextOverflow.ellipsis,
                  style: transactionSubtitleStyle,
                ),
              ),
            ],
          ),
        Text(
          DateFormat().add_jm().format(transaction.timestamp),
          style: transactionSubtitleStyle,
        ),
      ],
    );
  }

  /// Создает текст с суммой транзакции
  Text buildAmount(Currency currency) {
    return Text(
      formatAmount(currency, transaction.amount),
      style: transactionAmountStyle(
        (transaction.amount > 0) ? Colors.green : Colors.red,
      ),
    );
  }
}

/// Виджет для отображения даты в заголовке списка транзакций
final class DateLabel extends StatelessWidget {
  /// Дата в текстовом формате
  final String date;

  const DateLabel(this.date);

  @override
  Widget build(BuildContext context) {
    return Text(
      date.toUpperCase(),
      style: const TextStyle(
        fontSize: 13,
        color: Colors.grey,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}

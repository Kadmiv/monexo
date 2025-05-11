import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:monexo/generated/l10n.dart';
import 'package:monexo/models/models.dart';
import 'package:monexo/screens/home/transaction_list/transaction_list_tile.dart';

/// Віджет для відображення списку транзакцій згруппованих по датам
final class TransactionList extends StatefulWidget {
  /// Дата для группировки транзакцій
  final DateTime date;

  /// Згрупповані транзакції за датою
  final Map<DateTime, List<TransactionModel>> grouped;

  const TransactionList({
    super.key,
    required this.date,
    required this.grouped,
    required this.onTransactionTap,
    required this.onDeleteTransactionTap,
  });

  final void Function(TransactionModel transaction) onTransactionTap;
  final void Function(TransactionModel transaction) onDeleteTransactionTap;

  @override
  State<TransactionList> createState() => _TransactionListState();
}

class _TransactionListState extends State<TransactionList> {
  bool visible = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        buildListHeader(),
        ...visible
            ? (widget.grouped[widget.date] ?? []).map(
                (transaction) => TransactionListTile(
                  transaction,
                  onTransactionTap: () => widget.onTransactionTap(transaction),
                  onDeleteTransactionTap: () =>
                      widget.onDeleteTransactionTap(transaction),
                ),
              )
            : [],
      ],
    );
  }

  /// Заголовок списку транзакцій та кнопка показу/приховування прихованих транзакцій
  InkWell buildListHeader() {
    return InkWell(
      onTap: () {
        setState(() => visible = !visible);
      },
      child: Container(
        margin: const EdgeInsets.only(
          top: 30,
          bottom: 10,
          left: 20,
          right: 20,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            DateLabel(DateFormat('dd MMMM y').format(widget.date)),
            Row(
              children: <Widget>[
                visible
                    ? Container()
                    : Text(
                        getHiddenTransactionText(widget.grouped[widget.date]?.length ?? 0),
                        style:
                            const TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                const SizedBox(width: 5),
                Icon(
                  visible ? Icons.arrow_upward : Icons.arrow_downward,
                  size: 12,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String getHiddenTransactionText(int howMany) {
    if (howMany == 1) {
      return S.of(context).oneTransactionIsHidden;
    } else if (howMany > 1 && howMany < 5) {
      return S.of(context).howmanyTransactionsAreHidden(howMany);
    } else {
      return S.of(context).manyTransactionsAreHidden(howMany);
    }
  }
}

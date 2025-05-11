import 'package:flutter/material.dart' hide Key;
import 'package:monexo/generated/l10n.dart';

/// Віджет для відображення пустого списку транзакцій
final class NoTransactionsFound extends StatelessWidget {
  const NoTransactionsFound();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(30),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const SizedBox(height: 20),
          Image.asset(
            'assets/images/money_man.png',
            width: MediaQuery.of(context).size.width * 0.5,
          ),
          const SizedBox(height: 40),
          Text(
            S.of(context).theListLooksEmpty,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 15),
          Text(
            S.of(context).clickTheButtonBelowToAddANewCostincome,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}

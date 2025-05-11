import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:monexo/screens/statistics/statistics_bloc.dart';
import 'package:monexo/screens/statistics/statistics_event.dart';
import 'package:monexo/screens/statistics/statistics_state.dart';
import 'package:monexo/screens/statistics/widgets/category_period_chart.dart';
import 'package:monexo/screens/statistics/widgets/transaction_card.dart';

/// Відображає основну статистику рахунку за обраний період
/// Тут відображається статистика за обраний період і відображає данні в
/// розрізі транзакцій згрупованих  по Категоріях
///
/// Дана пейджа викристовується в розрізі транзакцій згрупованих по типу транзакції - Доходи або Витрати
class TransactionStatisticsPage extends StatelessWidget {
  const TransactionStatisticsPage({
    super.key,
    required this.isIncome,
  });

  final bool isIncome;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StatisticsBloc, StatisticsState>(
      builder: (context, state) {
        if (state.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state.error != null) {
          return Center(
            child: Text(
              'Error: ${state.error}',
              style: const TextStyle(color: Colors.red),
            ),
          );
        }

        return SingleChildScrollView(
          child: Column(
            children: [
              /// Графік загальної статистики по категоріях
              CategoryPeriodChart(
                [...state.periodData]
                  ..sort((a, b) => a.start.compareTo(b.start)),
                state.timePeriod,
                isIncome: isIncome,
              ),

              const SizedBox(height: 16),
              /// Список витрат згрупованих по категоріях
              ...state.periodData.map((entry) {
                final period = entry.start;
                final transactions = entry.transactions;

                if (transactions.isEmpty) {
                  return const SizedBox();
                }

                return Padding(
                  padding: const EdgeInsets.only(top: 6),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          getPeriodTitle(period, state.timePeriod),
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      ...transactions.map(
                        (transaction) => isIncome == transaction.isIncome
                            ? TransactionCard(transaction)
                            : SizedBox(),
                      ),
                    ],
                  ),
                );
              }),
            ],
          ),
        );
      },
    );
  }
}

String getPeriodTitle(
  DateTime date,
  TimePeriod timePeriod, {
  bool short = true,
}) {
  switch (timePeriod) {
    case TimePeriod.day:
      final dayFormat = DateFormat(short ? 'E' : 'EEEE');
      return dayFormat.format(date);
    case TimePeriod.week:
      final weekOfYear = _getWeekOfYear(date);
      return 'Тиждень $weekOfYear';
    case TimePeriod.month:
      final monthFormat = DateFormat(short ? 'MMM' : 'MMMM');
      return monthFormat.format(date);
  }
}

int _getWeekOfYear(DateTime date) {
  final firstDayOfYear = DateTime(date.year, 1, 1);
  final daysSinceFirstDay = date.difference(firstDayOfYear).inDays;
  return ((daysSinceFirstDay + firstDayOfYear.weekday - 1) ~/ 7) + 1;
}

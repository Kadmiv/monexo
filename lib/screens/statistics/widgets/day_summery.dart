import 'package:flutter/material.dart';
import 'package:monexo/screens/statistics/statistics_event.dart';
import 'package:monexo/screens/statistics/statistics_state.dart';
import 'package:monexo/screens/statistics/widgets/transaction_statistics_page.dart';

import '../../../shared/utils.dart';

class PeriodSummery extends StatelessWidget {
  const PeriodSummery(
    this.periodData,
    this.timePeriod, {
    Key? key,
  }) : super(key: key);

  final PeriodStatistics periodData;
  final TimePeriod timePeriod;

  @override
  Widget build(BuildContext context) {
    // Calculate category totals for income and expenses
    final Map<String, double> incomeByCategory = {};
    final Map<String, double> expensesByCategory = {};

    for (var transaction in periodData.transactions) {
      final category = transformCategoryToKey(transaction.category);
      final amount = transaction.amount.abs();

      if (transaction.isIncome) {
        incomeByCategory[category] = (incomeByCategory[category] ?? 0) + amount;
      } else {
        expensesByCategory[category] =
            (expensesByCategory[category] ?? 0) + amount;
      }
    }

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Row(
            children: [
              Text(
                getPeriodTitle(periodData.start, timePeriod,short: timePeriod != TimePeriod.day),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        // Income by Category Summary
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: Colors.grey,
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          margin: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Доходи',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Builder(builder: (context) {
                    if (incomeByCategory.isEmpty) {
                      return const SizedBox();
                    }
                    return Text(
                      '${(incomeByCategory.values.reduce((a, b) => a + b)).toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  }),
                ],
              ),
              const SizedBox(height: 16),
              _buildCategorySummaryList(incomeByCategory),
            ],
          ),
        ),
        // Expenses by Category Summary
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: Colors.grey,
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          margin: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Витрати',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Builder(builder: (context) {
                    if (expensesByCategory.isEmpty) {
                      return const SizedBox();
                    }
                    return Text(
                      '${(expensesByCategory.values.reduce((a, b) => a + b)).toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  }),
                ],
              ),
              const SizedBox(height: 16),
              _buildCategorySummaryList(expensesByCategory),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCategorySummaryList(Map<String, double> categoryData) {
    // Check if categoryData is empty
    if (categoryData.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 16.0),
          child: Text(
            'Немає даних',
            style: TextStyle(
              color: Colors.grey,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
      );
    }

    final total = categoryData.values.fold(0.0, (a, b) => a + b);

    // Sort categories by total amount in descending order
    final sortedCategories = categoryData.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: sortedCategories.map((entry) {
        final percentage = (entry.value / total) * 100;
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Text(
                  entry.key,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  entry.value.toStringAsFixed(2),
                  textAlign: TextAlign.right,
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  '${percentage.toStringAsFixed(1)}%',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: Colors.grey[600],
                  ),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:monexo/generated/l10n.dart';
import 'package:monexo/screens/statistics/statistics_event.dart';
import 'package:monexo/screens/statistics/statistics_state.dart';
import 'package:monexo/screens/statistics/widgets/transaction_statistics_page.dart';
import 'package:monexo/shared/colors_utils.dart';

/// Графік загальної статистики по категоріях
/// Відображає статистику за обраний період і визначає кольори для категорій
class CategoryPeriodChart extends StatelessWidget {
  const CategoryPeriodChart(
    this.allPeriods,
    this.timePeriod, {
    required this.isIncome,
    super.key,
  });

  final bool isIncome;

  final List<PeriodStatistics> allPeriods;
  final TimePeriod timePeriod;

  @override
  Widget build(BuildContext context) {
    final Map<DateTime, Map<String, double>> dailyCategoryTotals = {};

    // Populate category totals
    for (var periodData in allPeriods) {
      final categories = <String, double>{};

      // Group transactions by category for this period
      for (var transaction in periodData.transactions) {
        final category = transaction.category?.name ?? S.of(context).noCategory;
        if (isIncome == transaction.isIncome) {
          categories[category] =
              (categories[category] ?? 0) + transaction.amount.abs();
        }
      }

      dailyCategoryTotals[periodData.start] = categories;
    }

    // Get all unique categories
    final allCategories = dailyCategoryTotals.values
        .expand((categories) => categories.keys)
        .toSet()
        .toList();

    return Container(
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
          Builder(builder: (context) {
            /// Формирує групи для всіх періодів
            final barGroups = List.generate(
              allPeriods.length,
              (index) {
                final date = allPeriods[index].start;
                final categories = dailyCategoryTotals[date] ?? {};

                /// Сортує категорії
                final sortedCategories = allCategories
                    .where((category) => categories[category] != null)
                    .toList()
                  ..sort((a, b) {
                    if (a == S.of(context).noCategory) return 1;
                    if (b == S.of(context).noCategory) return -1;
                    return (categories[b] ?? 0).compareTo(categories[a] ?? 0);
                  });

                /// Визначає суму для цього періоду
                final total = categories.values
                    .fold<double>(0, (sum, amount) => sum + amount)
                    .abs();

                /// Створює стек елементів для відображення групи категорій
                double currentY = 0;
                final stackItems = sortedCategories.map((category) {
                  final amount = (categories[category] ?? 0).abs();
                  final fromY = currentY;
                  currentY += amount;

                  final color = getCategoryColor(category);
                  return BarChartRodStackItem(
                    fromY,
                    currentY,
                    color,
                  );
                }).toList();

                return BarChartGroupData(
                  x: index,
                  barRods: [
                    BarChartRodData(
                      toY: total,
                      width: 20,
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(3)),
                      rodStackItems: stackItems,
                    ),
                  ],
                );
              },
            );

            return SizedBox(
              height: 300,
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  maxY: _calculateMaxY(dailyCategoryTotals),
                  barTouchData: BarTouchData(
                    enabled: true,
                    touchTooltipData: BarTouchTooltipData(
                      getTooltipItem: (group, groupIndex, rod, rodIndex) {
                        final date = allPeriods[groupIndex];
                        final categories = dailyCategoryTotals[date] ?? {};

                        /// Сортує категорії
                        final sortedCategories = allCategories
                            .where(
                                (category) => (categories[category] ?? 0) > 0)
                            .toList()
                          ..sort((a, b) => (categories[b] ?? 0)
                              .compareTo(categories[a] ?? 0));

                        if (rodIndex >= sortedCategories.length) return null;

                        final category = sortedCategories[rodIndex];
                        final amount = categories[category] ?? 0;

                        if (amount == 0) return null;

                        /// Визначає процент загальної суми
                        final total = categories.values
                            .fold<double>(0, (sum, amount) => sum + amount);
                        final percentage =
                            (amount / total * 100).toStringAsFixed(1);

                        return BarTooltipItem(
                          '$category\n${amount.toStringAsFixed(2)} ($percentage%)',
                          const TextStyle(color: Colors.white),
                        );
                      },
                    ),
                  ),
                  gridData: const FlGridData(show: false),
                  titlesData: FlTitlesData(
                    show: true,
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          if (value.toInt() >= allPeriods.length) {
                            return const SizedBox.shrink();
                          }
                          final date = allPeriods[value.toInt()].start;
                          return Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(
                              getPeriodTitle(date, timePeriod),
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    topTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    rightTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                  ),
                  borderData: FlBorderData(
                    show: false,
                  ),
                  barGroups: barGroups,
                ),
              ),
            );
          }),
          const SizedBox(height: 16),
          /// Легенда - список категорій з кольором і назвою
          Wrap(
            spacing: 16,
            runSpacing: 8,
            children: allCategories.map((category) {
              return Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 12,
                    height: 12,
                    color: getCategoryColor(category),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    category,
                    style: const TextStyle(fontSize: 12),
                  ),
                ],
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  /// Визначає максимальну висоту діаграми - потрібно для нормалізації висоти графіка
  double _calculateMaxY(
      Map<DateTime, Map<String, double>> dailyCategoryTotals) {
    if (dailyCategoryTotals.isEmpty) return 1000;

    double maxTotal = 0;
    for (var categories in dailyCategoryTotals.values) {
      final dailyTotal =
          categories.values.fold<double>(0, (sum, amount) => sum + amount);
      maxTotal = maxTotal < dailyTotal ? dailyTotal : maxTotal;
    }
    return maxTotal * 1.2;
  }
}

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:monexo/generated/l10n.dart';
import 'package:monexo/screens/statistics/statistics_event.dart';
import 'package:monexo/screens/statistics/statistics_state.dart';
import 'package:monexo/screens/statistics/widgets/transaction_statistics_page.dart';

/// Графік загальної статистики по основним періодам
/// Відображає статистику за обраний період і визначає кольори для доходів та витрат
class GeneralPeriodChart extends StatelessWidget {
  const GeneralPeriodChart(this.allPeriods, this.timePeriod, {Key? key})
      : super(key: key);

  final List<PeriodStatistics> allPeriods;
  final TimePeriod timePeriod;

  @override
  Widget build(BuildContext context) {
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
          SizedBox(
            height: 300,
            child: BarChart(
              BarChartData(
                alignment: BarChartAlignment.spaceAround,
                maxY: _calculateMaxY(allPeriods),
                barTouchData: BarTouchData(
                  enabled: true,
                  touchTooltipData: BarTouchTooltipData(
                    getTooltipItem: (group, groupIndex, rod, rodIndex) {
                      final stats = allPeriods[groupIndex];
                      final value =
                          rodIndex == 0 ? stats.income : stats.expenses;
                      return BarTooltipItem(
                        value.toStringAsFixed(2),
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
                        final stats = allPeriods[value.toInt()];
                        return Text(getPeriodTitle(stats.start, timePeriod));
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
                barGroups: _createBarGroups(allPeriods),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              const SizedBox(width: 8),
              Text(S.of(context).revenue),
              const SizedBox(width: 20),
              Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              const SizedBox(width: 8),
              Text(S.of(context).costs),
            ],
          ),
        ],
      ),
    );
  }

  /// Визначає максимальну висоту діаграми - потрібно для нормалізації висоти графіка
  double _calculateMaxY(List<PeriodStatistics> stats) {
    if (stats.isEmpty) return 1000;
    double maxValue = 0;
    for (var stat in stats) {
      maxValue = maxValue < stat.income ? stat.income : maxValue;
      maxValue = maxValue < stat.expenses ? stat.expenses : maxValue;
    }
    return maxValue * 1.2;
  }

  List<BarChartGroupData> _createBarGroups(List<PeriodStatistics> stats) {
    return List.generate(
      stats.length,
      (index) {
        final stat = stats[index];
        return BarChartGroupData(
          x: index,
          barRods: [
            BarChartRodData(
              toY: stat.income,
              color: Colors.green,
              width: 20,
            ),
            BarChartRodData(
              toY: stat.expenses,
              color: Colors.red,
              width: 20,
            ),
          ],
        );
      },
    );
  }
}

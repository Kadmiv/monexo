import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:monexo/screens/statistics/statistics_bloc.dart';
import 'package:monexo/screens/statistics/statistics_state.dart';
import 'package:monexo/screens/statistics/widgets/day_summery.dart';

import 'general_period_chart.dart';

/// Відображає основну статистику рахунку за обраний період
/// Тут відображається статистика за обраний період і відображає данні лише в
/// розрізі транзакцій згрупованих  по типу транзакції - Доходи або Витрати
class GeneralStatisticsPage extends StatelessWidget {
  const GeneralStatisticsPage({super.key});

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
              'Помилка: ${state.error}',
              style: const TextStyle(color: Colors.red),
            ),
          );
        }

        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GeneralPeriodChart(
                [...state.periodData]
                  ..sort((a, b) => a.start.compareTo(b.start)),
                state.timePeriod,
              ),
              Column(
                children: [
                  ...List.generate(state.periodData.length, (index) {
                    final periodData = state.periodData[index];
                    if (periodData.transactions.isEmpty) {
                      return const SizedBox();
                    }
                    return PeriodSummery(periodData, state.timePeriod);
                  }),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

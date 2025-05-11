import 'package:equatable/equatable.dart';
import 'package:monexo/models/transaction.dart';

import 'statistics_event.dart';

class StatisticsState extends Equatable {
  final bool isLoading;
  final List<PeriodStatistics> periodData;
  final TimePeriod timePeriod;
  final String? error;

  const StatisticsState({
    this.isLoading = false,
    this.periodData = const [],
    this.timePeriod = TimePeriod.week,
    this.error,
  });

  StatisticsState copyWith({
    bool? isLoading,
    List<PeriodStatistics>? dailyStats,
    TimePeriod? timePeriod,
    String? error,
  }) {
    return StatisticsState(
      isLoading: isLoading ?? this.isLoading,
      periodData: dailyStats ?? this.periodData,
      timePeriod: timePeriod ?? this.timePeriod,
      error: error,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        periodData,
        timePeriod,
        error,
      ];
}

class PeriodStatistics {
  final DateTime start;
  final DateTime end;
  final List<TransactionModel> transactions;

  const PeriodStatistics({
    required this.start,
    required this.end,
    required this.transactions,
  });

  double get income => transactions
      .where((t) => t.isIncome)
      .fold<double>(0, (sum, transaction) => sum + transaction.amount.abs());

  double get expenses => transactions
      .where((t) => !t.isIncome)
      .fold<double>(0, (sum, transaction) => sum + transaction.amount.abs());
}

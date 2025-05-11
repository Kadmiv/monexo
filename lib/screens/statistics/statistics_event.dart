import 'package:equatable/equatable.dart';

enum TimePeriod {
  day,
  week,
  month,
}

abstract class StatisticsEvent extends Equatable {
  const StatisticsEvent();

  @override
  List<Object> get props => [];
}

class LoadStatistics extends StatisticsEvent {
  final TimePeriod timePeriod;

  const LoadStatistics({
    this.timePeriod = TimePeriod.day,
  });

  @override
  List<Object> get props => [timePeriod];
}

class UpdateTimePeriod extends StatisticsEvent {
  final TimePeriod timePeriod;

  const UpdateTimePeriod({
    required this.timePeriod,
  });

  @override
  List<Object> get props => [timePeriod];
}

class UpdateStatistics extends StatisticsEvent {
  final String accountId;
  final DateTime startDate;
  final DateTime endDate;

  const UpdateStatistics({
    required this.accountId,
    required this.startDate,
    required this.endDate,
  });

  @override
  List<Object> get props => [accountId, startDate, endDate];
} 
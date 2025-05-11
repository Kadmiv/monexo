import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:monexo/models/transaction.dart';
import 'package:monexo/services/account_provider.dart';
import 'package:monexo/services/transaction_provider.dart';

import 'statistics_event.dart';
import 'statistics_state.dart';

class StatisticsBloc extends Bloc<StatisticsEvent, StatisticsState> {
  StatisticsBloc() : super(const StatisticsState()) {
    on<LoadStatistics>(_onInitialized);
    on<UpdateTimePeriod>(_onUpdateTimePeriod);
  }

  final AccountProvider _accountService = AccountProvider();
  final TransactionProvider _transactionService =
      TransactionProvider();

  Future<void> _onInitialized(
      LoadStatistics event, Emitter<StatisticsState> emit) async {
    try {
      final account = await _accountService.getAccount();
      await emit.forEach<List<TransactionModel>>(
        _transactionService.accountTransactionsStream(account.id),
        onData: (transactions) {
          final now = DateTime.now();
          final dateRanges = _getDateRangesForPeriod(event.timePeriod, now);

          final stats = _getStatisticsForPeriod(
            dateRanges,
            transactions,
          );

          return state.copyWith(
            isLoading: false,
            dailyStats: stats,
            timePeriod: event.timePeriod,
          );
        },
        onError: (error, stackTrace) {
          return state.copyWith(
            isLoading: false,
            error: error.toString(),
          );
        },
      );
    } catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          error: e.toString(),
        ),
      );
    }
  }

  /// Оновлює статистику за вказаний період
  /// Період може бути день, тиждень або місяць
  Future<void> _onUpdateTimePeriod(
    UpdateTimePeriod event,
    Emitter<StatisticsState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    try {
      final account = await _accountService.getAccount();
      final transactions =
          await _transactionService.getAccountTransactions(account.id);
      final now = DateTime.now();
      final dateRanges = _getDateRangesForPeriod(event.timePeriod, now);

      final stats = _getStatisticsForPeriod(
        dateRanges,
        transactions,
      );

      emit(state.copyWith(
        isLoading: false,
        dailyStats: stats,
        timePeriod: event.timePeriod,
      ));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        error: e.toString(),
      ));
    }
  }

  /// Визначає діапазони для періоду - день, тиждень та місяць
  /// За цими діапазонами формуються статистики за кожний діапазон
  List<(DateTime, DateTime)> _getDateRangesForPeriod(
      TimePeriod period, DateTime now) {
    switch (period) {
      case TimePeriod.day:
        return List.generate(7, (index) {
          final start = DateTime(now.year, now.month, now.day - index);
          final end = start.add(const Duration(days: 1));
          return (start, end);
        });
      case TimePeriod.week:
        return List.generate(4, (index) {
          final start = DateTime(now.year, now.month, now.day - (index * 7));
          final end = start.add(const Duration(days: 7));
          return (start, end);
        });
      case TimePeriod.month:
        return List.generate(6, (index) {
          final start = DateTime(now.year, now.month - index, 1);
          final end = DateTime(now.year, now.month - index + 1, 1);
          return (start, end);
        });
    }
  }

  /// Підтягуються транзакції до статистики за обраний період
  List<PeriodStatistics> _getStatisticsForPeriod(
    List<(DateTime, DateTime)> dateRanges,
    List<TransactionModel> transactions,
  ) {
    final List<PeriodStatistics> stats = [];

    for (final range in dateRanges) {
      final start = range.$1;
      final end = range.$2;

      final filteredTransactions = transactions.where((transaction) {
        final date = transaction.timestamp;
        return (date.isAtSameMomentAs(start) ||
            (date.isAfter(start)) && date.isBefore(end));
      }).toList();

      stats.add(PeriodStatistics(
        start: start,
        end: end,
        transactions: filteredTransactions,
      ));
    }

    return stats;
  }
}

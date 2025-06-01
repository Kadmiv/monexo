import 'package:monexo/models/account.dart';
import 'package:monexo/models/models.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class OutOfBalanceLimitState extends HomeState {}

class HomeLoaded extends HomeState {
  final Account account;
  final List<TransactionModel> transactions;
  final Map<DateTime, List<TransactionModel>> groupedTransactions;
  final double balance;
  final List<TransactionModel> expenses;

  HomeLoaded({
    required this.account,
    required this.transactions,
    required this.groupedTransactions,
    required this.balance,
    required this.expenses,
  });
}

class HomeError extends HomeState {
  final String message;

  HomeError(this.message);
}

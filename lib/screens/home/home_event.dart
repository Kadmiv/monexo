import 'package:monexo/models/models.dart';

abstract class HomeEvent {}

class HomeInitialized extends HomeEvent {}

class HomeTransactionDeleted extends HomeEvent {
  final TransactionModel transaction;

  HomeTransactionDeleted(this.transaction);
}

import 'package:equatable/equatable.dart';
import 'package:monexo/models/account.dart';
import 'package:monexo/models/models.dart';

abstract class TransactionInfoEvent extends Equatable {
  const TransactionInfoEvent();

  @override
  List<Object?> get props => [];
}

class TransactionInfoInitialized extends TransactionInfoEvent {
  final TransactionModel? transaction;

  const TransactionInfoInitialized({this.transaction});

  @override
  List<Object?> get props => [transaction];
}

class TransactionSubmitted extends TransactionInfoEvent {
  const TransactionSubmitted(this.transaction,this.account);

  final TransactionModel? transaction;
  final Account? account;
}

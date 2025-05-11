import 'package:equatable/equatable.dart';
import 'package:monexo/models/models.dart';

abstract class TransactionInfoState extends Equatable {
  const TransactionInfoState();

  @override
  List<Object?> get props => [];
}

class TransactionInfoInitial extends TransactionInfoState {
  const TransactionInfoInitial();
}

class TransactionInfoLoading extends TransactionInfoState {
  const TransactionInfoLoading();
}

class TransactionInfoLoaded extends TransactionInfoState {
  final TransactionModel? transaction;
  final String? errorMessage;
  final List<CategoryModel> categories;

  const TransactionInfoLoaded({
    required this.transaction,
    required this.categories,
    this.errorMessage,
    required bool isIncome,
  });

  @override
  List<Object?> get props => [
        transaction,
        errorMessage,
        categories,
      ];
}

class TransactionCreationLoading extends TransactionInfoState {
  const TransactionCreationLoading();
}

class TransactionCreationSuccess extends TransactionInfoState {
  const TransactionCreationSuccess();
}

class TransactionInfoError extends TransactionInfoState {
  final String message;

  const TransactionInfoError(this.message);

  @override
  List<Object> get props => [message];
}

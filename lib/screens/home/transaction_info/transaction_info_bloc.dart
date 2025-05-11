import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:monexo/models/models.dart';
import 'package:monexo/services/category_provider.dart';
import 'package:monexo/services/account_provider.dart';
import 'package:monexo/services/services.dart';

import 'transaction_info_event.dart';
import 'transaction_info_state.dart';

class TransactionInfoBloc
    extends Bloc<TransactionInfoEvent, TransactionInfoState> {
  TransactionInfoBloc() : super(const TransactionInfoInitial()) {
    on<TransactionInfoInitialized>(_onInitialized);
    on<TransactionSubmitted>(_onTransactionSubmitted);
  }

  final TransactionProvider _transactionService =
      TransactionProvider();
  final CategoryProvider _categoryProvider = CategoryProvider();
  final AccountProvider _accountService = AccountProvider();

  Future<void> _onInitialized(
    TransactionInfoInitialized event,
    Emitter<TransactionInfoState> emit,
  ) async {
    var transaction = event.transaction ?? TransactionModel.empty();
    transaction = transaction.copyWith(
      category: transaction.category,
    );

    final account = await _accountService.getAccount();
    final categories = await _categoryProvider.getCategories(account.id);

    emit(TransactionInfoLoaded(
      transaction: transaction.copyWith(),
      categories: categories,
      isIncome: transaction.isIncome,
    ));
  }

  Future<void> _onTransactionSubmitted(
    TransactionSubmitted event,
    Emitter<TransactionInfoState> emit,
  ) async {
    try {
      emit(const TransactionCreationLoading());

      var transaction = event.transaction ?? TransactionModel.empty();
      transaction = transaction.copyWith(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        accountId: transaction.accountId.isEmpty
            ? event.account?.id
            : transaction.accountId,
        amount: transaction.amount * (transaction.isIncome ? 1 : -1),
        description: transaction.description,
        timestamp: transaction.timestamp,
        category: transaction.category,
      );

      await _transactionService.addTransaction(transaction);
      emit(const TransactionCreationSuccess());
    } catch (e) {
      emit(TransactionInfoError(e.toString()));
    }
  }
}

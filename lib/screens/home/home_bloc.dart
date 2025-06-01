import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:monexo/services/services.dart';

import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeInitialized>(_onInitialized);
    on<HomeTransactionDeleted>(_onTransactionDeleted);

    _init();
  }

  final AccountProvider _accountService = AccountProvider();
  final TransactionProvider _transactionService = TransactionProvider();

  Future<void> _init() async {
    final account = await _accountService.getAccount();
    _accountService.listenAccount(account.id).listen((account) {
      add(HomeInitialized());
    });
    _transactionService
        .accountTransactionsStream(account.id)
        .listen((transactions) {
      add(HomeInitialized());
    });
  }

  Future<void> _onInitialized(
    HomeInitialized event,
    Emitter<HomeState> emit,
  ) async {
    emit(HomeLoading());
    try {
      final account = await _accountService.getAccount();
      final transactions =
          await _transactionService.getAccountTransactions(account.id);

      final balance = _transactionService.calculateAccountBalance(transactions);
      final grouped = _transactionService.groupTransactionsByDate(transactions);
      final expenses =
          transactions.where((item) => item.isIncome == false).toList();

      final isNegativeBalance = balance < 0;
      if (isNegativeBalance) {
        emit(OutOfBalanceLimitState());
      }

      emit(HomeLoaded(
        account: account,
        transactions: transactions,
        groupedTransactions: grouped,
        balance: balance,
        expenses: expenses,
      ));
    } catch (e) {
      emit(HomeError('Щось пішло не так...\n Спробуйте ще раз пізніше.'));
    }
  }

  void _onTransactionDeleted(
      HomeTransactionDeleted event, Emitter<HomeState> emit) {
    _transactionService.deleteTransaction(event.transaction);
  }
}

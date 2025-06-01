import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:monexo/models/account.dart';
import 'package:monexo/models/transaction.dart';
import 'package:monexo/screens/home/home_bloc.dart';
import 'package:monexo/screens/home/home_event.dart';
import 'package:monexo/screens/home/home_state.dart';
import 'package:monexo/screens/home/statistics_overview/statistics_overview.dart';
import 'package:monexo/screens/home/transaction_info/transaction_info.dart';
import 'package:monexo/screens/home/transaction_list/daily.dart';
import 'package:monexo/screens/home/transaction_list/transaction_list.dart';
import 'package:monexo/shared/dialogs/update_budget.dart';

/// Сторінка для перегляду рахунку та витрат
final class HomeScreen extends StatefulWidget {
  static const String routeName = '/home';

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  late final HomeBloc bloc = HomeBloc();
  late Account account;

  @override
  void initState() {
    super.initState();
    bloc.add(HomeInitialized());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => bloc,
      child: BlocConsumer<HomeBloc, HomeState>(
        listener: (context, state) {
          if (state is HomeLoaded) {
            account = state.account;
          } else if (state is OutOfBalanceLimitState) {
            _showOutOfBalanceLimitDialog();
          }
        },
        builder: (context, state) {
          return Scaffold(
            key: _scaffoldKey,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            backgroundColor: Theme.of(context).colorScheme.surface,

            /// Кнопка для створення нової транзакції
            floatingActionButton: FloatingActionButton(
              onPressed: _onCreateNewTransactionTap,
              elevation: 0,
              splashColor: Colors.white.withOpacity(0.5),
              backgroundColor: Theme.of(context).colorScheme.primary,
              foregroundColor: Colors.white,
              child: const Icon(
                Icons.add,
                size: 32,
              ),
            ),
            body: SafeArea(
              bottom: false,
              child: _buildBody(state),
            ),
          );
        },
      ),
    );
  }

  Widget _buildBody(HomeState state) {
    if (state is HomeLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state is HomeError) {
      return Padding(
        padding: const EdgeInsets.only(top: 40),
        child: Center(
          child: Text(state.message),
        ),
      );
    }

    if (state is HomeLoaded) {
      Widget transactions = Center(child: const NoTransactionsFound());

      /// Відображення списку транзакцій
      if (state.transactions.isNotEmpty) {
        transactions = ListView.builder(
          shrinkWrap: true,
          itemCount: state.groupedTransactions.keys.length,
          padding: const EdgeInsets.only(bottom: 90),
          itemBuilder: (context, index) {
            return TransactionList(
              date: state.groupedTransactions.keys.elementAt(index),
              grouped: state.groupedTransactions,
              onDeleteTransactionTap: (transaction) {
                bloc.add(HomeTransactionDeleted(transaction));
              },
              onTransactionTap: _onTransactionTap,
            );
          },
        );
      }

      /// Відображення інформації про рахунок та витрати
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: TransactionsOverview(
              account: state.account,
              balance: state.balance,
              expenses: state.expenses,
              onEditBudgetTap: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (context) => UpdateAccountDialog(
                    account: account,
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: transactions,
          ),
        ],
      );
    }

    return Container();
  }

  /// Відображення діалогу для створення транзакції
  Future<void> _onCreateNewTransactionTap() async {
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => TransactionInfoScreen(
        account: account,
      ),
    );
  }

  /// Відображення діалогу для оновлення транзакції
  Future<void> _onTransactionTap(TransactionModel transaction) async {
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => TransactionInfoScreen(
        transaction: transaction,
        account: account,
      ),
    );
  }

  bool alertOutOfBalanceAlertIsShown = false;

  Future<void> _showOutOfBalanceLimitDialog() async {
    if (alertOutOfBalanceAlertIsShown) {
      return;
    }

    setState(() {
      alertOutOfBalanceAlertIsShown = true;
    });
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Увага!'),
        content: const Text(
            'Ваш місячний ліміт перевищено 😱\n\nБудь ласка, перестанье витрачати грощі або збільшіть місячний ліміт рахунку 😜'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Зрозуміло'),
          ),
        ],
      ),
    );
    setState(() {
      alertOutOfBalanceAlertIsShown = false;
    });
  }
}

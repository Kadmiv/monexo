import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:monexo/services/category_provider.dart';
import 'package:monexo/services/account_provider.dart';
import 'package:monexo/services/services.dart';

import 'splash_event.dart';
import 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(const SplashInitial()) {
    on<CheckAuthentication>(_onCheckAuthentication);
  }

  final AuthService _auth = AuthService();
  final AccountProvider _accountDb = AccountProvider();
  final UserProvider _userDatabase = UserProvider();
  final TransactionProvider _transactionDb =
      TransactionProvider();
  final AccountProvider _accountDatabaseService =
      AccountProvider();
  final CategoryProvider _categoryProvider = CategoryProvider();

  Future<void> _onCheckAuthentication(
    CheckAuthentication event,
    Emitter<SplashState> emit,
  ) async {
    try {
      emit(const SplashLoading());
      final user = await _auth.getUser;

      if (user != null) {
        await _accountDb.init(user);
        await _userDatabase.init(user);
        await _categoryProvider.init(user);
        await _transactionDb.init(user);
        final hasAnyAccounts = await _accountDatabaseService.hasAnyAccounts;

        final isNewUser = !hasAnyAccounts;

        emit(SplashAuthenticated(isNewUser));
      } else {
        emit(const SplashUnauthenticated());
      }
    } catch (e) {
      emit(SplashError(e.toString()));
    }
  }
}

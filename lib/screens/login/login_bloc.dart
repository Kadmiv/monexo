import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:monexo/screens/login/login_event.dart';
import 'package:monexo/screens/login/login_state.dart';
import 'package:monexo/services/auth_provider.dart';
import 'package:monexo/services/account_provider.dart';
import 'package:monexo/services/transaction_provider.dart';
import 'package:monexo/services/user_provider.dart';

import '../../services/category_provider.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<SignInAnonymously>(_onSignInAnonymously);
    on<SignInWithGoogle>(_onSignInWithGoogle);
  }

  final AuthService _authService = AuthService();
  final UserProvider _userDatabaseService = UserProvider();
  final AccountProvider _accountDatabaseService = AccountProvider();
  final TransactionProvider _transactionService = TransactionProvider();
  final CategoryProvider _categoryProvider = CategoryProvider();

  Future<void> _onSignInAnonymously(
    SignInAnonymously event,
    Emitter<LoginState> emit,
  ) async {
    try {
      emit(LoginLoading());
      final user = await _authService.signInAnonymously();
      await _userDatabaseService.init(user);
      await _accountDatabaseService.init(user);
      await _categoryProvider.init(user);

      final hasAnyAccounts = await _accountDatabaseService.hasAnyAccounts;

      final isNewUser = !hasAnyAccounts;
      emit(LoginSuccess(isNewUser: isNewUser));
    } catch (e,stack) {
      print(stack);
      emit(LoginFailure(e.toString()));
    }
  }

  Future<void> _onSignInWithGoogle(
    SignInWithGoogle event,
    Emitter<LoginState> emit,
  ) async {
    try {
      emit(LoginLoading());
      final user = await _authService.signInWithGoogle();

      await _userDatabaseService.init(user);
      await _accountDatabaseService.init(user);
      await _categoryProvider.init(user);
      await _transactionService.init(user);

      final hasAnyAccounts = await _accountDatabaseService.hasAnyAccounts;

      final isNewUser = !hasAnyAccounts;
      emit(LoginSuccess(isNewUser: isNewUser));
    } catch (e) {
      emit(LoginFailure(e.toString()));
    }
  }
}

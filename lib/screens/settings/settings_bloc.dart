import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:monexo/services/auth_provider.dart';
import 'package:monexo/services/user_provider.dart';

import 'settings_event.dart';
import 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final AuthService _authService = AuthService();
  final UserProvider _userDatabaseService = UserProvider();

  SettingsBloc() : super(const SettingsInitial()) {
    on<LoadUser>(_onLoadUser);
    on<Logout>(_onLogout);
  }

  Future<void> _onLoadUser(
    LoadUser event,
    Emitter<SettingsState> emit,
  ) async {
    try {
      emit(const SettingsLoading());
      final user = await _userDatabaseService.getUserInfo();
      emit(SettingsLoaded(user));
    } catch (e) {
      emit(SettingsError(e.toString()));
    }
  }

  Future<void> _onLogout(
    Logout event,
    Emitter<SettingsState> emit,
  ) async {
    try {
      emit(const SettingsLoading());
      await _authService.signOut();
      emit(const SettingsInitial());
    } catch (e) {
      emit(SettingsError(e.toString()));
    }
  }
}

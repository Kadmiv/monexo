import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:monexo/models/models.dart';
import 'package:monexo/services/services.dart';

import 'profile_setup_event.dart';
import 'profile_setup_state.dart';

class ProfileSetupBloc extends Bloc<ProfileSetupEvent, ProfileSetupState> {
  ProfileSetupBloc() : super(const ProfileSetupInitial()) {
    on<ProfileSetupInitialized>(_onInitialized);
    on<ProfileSetupSubmitted>(_onSubmitted);
  }

  final UserProvider _userDatabaseService = UserProvider();

  Future<void> _onInitialized(
    ProfileSetupInitialized event,
    Emitter<ProfileSetupState> emit,
  ) async {
    AppUser user = _userDatabaseService.getCurrentUser();
    final userInfo = await _userDatabaseService.getUserInfo();

    emit(ProfileSetupLoaded(user.email.isNotEmpty ? user : userInfo));
  }

  Future<void> _onSubmitted(
    ProfileSetupSubmitted event,
    Emitter<ProfileSetupState> emit,
  ) async {
    try {
      emit(const ProfileSetupLoading());
      final user = await _userDatabaseService.getCurrentUser();
      final userInfo = await _userDatabaseService.getUserInfo();

      if (userInfo.name.isNotEmpty && event.email.isNotEmpty) {
        await _userDatabaseService.updateUser(user.copyWith(
          email: event.email,
        ));
      } else {
        await _userDatabaseService.createUser(user.copyWith(
          name: event.name,
          email: event.email,
        ));
      }
      emit(const ProfileSetupSuccess());
    } catch (e) {
      emit(ProfileSetupError(e.toString()));
    }
  }
}

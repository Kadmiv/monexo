import 'package:equatable/equatable.dart';
import 'package:monexo/models/user.dart';

abstract class ProfileSetupState extends Equatable {
  const ProfileSetupState();

  @override
  List<Object> get props => [];
}

class ProfileSetupInitial extends ProfileSetupState {
  const ProfileSetupInitial();
}

class ProfileSetupLoading extends ProfileSetupState {
  const ProfileSetupLoading();
}

class ProfileSetupLoaded extends ProfileSetupState {
  const ProfileSetupLoaded(this.userInfo);

  final AppUser userInfo;

  @override
  List<Object> get props => [userInfo];
}

class ProfileSetupSuccess extends ProfileSetupState {
  const ProfileSetupSuccess();
}

class ProfileSetupError extends ProfileSetupState {
  final String message;

  const ProfileSetupError(this.message);

  @override
  List<Object> get props => [message];
}

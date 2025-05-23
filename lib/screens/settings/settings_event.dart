import 'package:equatable/equatable.dart';

abstract class SettingsEvent extends Equatable {
  const SettingsEvent();

  @override
  List<Object?> get props => [];
}

class LoadUser extends SettingsEvent {
  const LoadUser();
}

class Logout extends SettingsEvent {
  const Logout();
} 
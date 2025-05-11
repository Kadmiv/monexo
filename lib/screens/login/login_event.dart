import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class SignInAnonymously extends LoginEvent {}

class SignInWithGoogle extends LoginEvent {} 
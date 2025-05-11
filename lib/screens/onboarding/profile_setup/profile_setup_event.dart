import 'package:equatable/equatable.dart';

abstract class ProfileSetupEvent extends Equatable {
  const ProfileSetupEvent();

  @override
  List<Object> get props => [];
}

class ProfileSetupInitialized extends ProfileSetupEvent {
  const ProfileSetupInitialized();
}

class ProfileSetupSubmitted extends ProfileSetupEvent {
  const ProfileSetupSubmitted({
    required this.name,
    required this.email,
  });

  final String name;
  final String email;

  @override
  List<Object> get props => [name, email];
}

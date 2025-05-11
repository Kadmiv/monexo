abstract class SplashState {
  const SplashState();

  @override
  List<Object?> get props => [];
}

class SplashInitial extends SplashState {
  const SplashInitial();
}

class SplashLoading extends SplashState {
  const SplashLoading();
}

class SplashAuthenticated extends SplashState {
  const SplashAuthenticated(this.isNewUser);

  final bool isNewUser;

  @override
  List<Object?> get props => [isNewUser];
}

class SplashUnauthenticated extends SplashState {
  const SplashUnauthenticated();
}

class SplashError extends SplashState {
  final String message;

  const SplashError(this.message);

  @override
  List<Object?> get props => [message];
}

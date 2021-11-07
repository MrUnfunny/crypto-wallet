part of 'auth_bloc.dart';

class AuthState extends Equatable {
  final bool loading;
  const AuthState(this.loading);

  @override
  List<Object> get props => [];

  AuthState copyWith({
    bool? loading,
  }) {
    return AuthState(
      loading ?? this.loading,
    );
  }
}

class AuthUnknownState extends AuthState {
  const AuthUnknownState() : super(false);
}

class AuthUserExistsState extends AuthState {
  const AuthUserExistsState() : super(false);
}

class AuthStartState extends AuthState {
  const AuthStartState() : super(true);
}

class AuthLoggedOutState extends AuthState {
  const AuthLoggedOutState() : super(false);
}

class AuthRegisteredState extends AuthState {
  const AuthRegisteredState() : super(false);
}

class AuthLoggedInState extends AuthState {
  const AuthLoggedInState() : super(false);
}

class AuthFailedState extends AuthState {
  final String errorMsg;

  const AuthFailedState(this.errorMsg) : super(false);
}

class AuthUpdateUsernameState extends AuthState {
  const AuthUpdateUsernameState() : super(false);
}

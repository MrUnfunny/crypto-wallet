part of 'auth_bloc.dart';

abstract class AuthEvent {}

class AuthStartedEvent extends AuthEvent {}

class AuthRegisterEvent extends AuthEvent {
  final String email;
  final String password;
  final String username;

  AuthRegisterEvent(this.email, this.password, this.username);
}

class AuthIsLoggedInEvent extends AuthEvent {
  final bool isloggedIn;
  final String userName = '';

  AuthIsLoggedInEvent(this.isloggedIn);
}

class AuthLoginEvent extends AuthEvent {
  final String email;
  final String password;

  AuthLoginEvent(this.email, this.password);
}

class AuthLogOutEvent extends AuthEvent {}

class AuthUpdateUserNameEvent extends AuthEvent {
  final String username;

  AuthUpdateUserNameEvent(this.username);
}

import 'package:bloc/bloc.dart';
import 'package:cryptowallet/repository/user_repository.dart';
import 'package:equatable/equatable.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  Stream<AuthState> _mapAuthLoginToState(AuthLoginEvent event) async* {
    try {
      yield const AuthStartState();
      await _userRepository.signInWithCredentials(event.email, event.password);
      yield const AuthLoggedInState();
    } catch (e) {
      yield AuthFailedState(e.toString());
    }
  }

  Stream<AuthState> _mapAuthRegisterToState(AuthRegisterEvent event) async* {
    try {
      yield const AuthStartState();
      await _userRepository.signUp(event.email, event.password, event.username);
      yield const AuthLoggedInState();
    } catch (e) {
      yield AuthFailedState(e.toString());
    }
  }

  Stream<AuthState> _mapAuthLogoutToState(AuthLogOutEvent event) async* {
    try {
      yield const AuthStartState();
      await _userRepository.signOut();
      yield const AuthLoggedOutState();
    } catch (e) {
      yield AuthFailedState(e.toString());
    }
  }

  Stream<AuthState> _mapAuthIsLoggedInToState(
      AuthIsLoggedInEvent event) async* {
    try {
      yield const AuthStartState();
      if (_userRepository.isSignedIn()) {
        yield const AuthUserExistsState();
      } else {
        yield const AuthUnknownState();
      }
    } catch (e) {
      yield AuthFailedState(e.toString());
    }
  }

  Stream<AuthState> _mapAuthUpdateUsernameToState(
      AuthUpdateUserNameEvent event) async* {
    try {
      yield const AuthStartState();
      _userRepository.updateUsername(event.username);
      yield const AuthUpdateUsernameState();
    } catch (e) {
      yield AuthFailedState(e.toString());
    }
  }

  final UserRepository _userRepository = UserRepository();
  AuthBloc() : super(const AuthUnknownState());

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    yield state.copyWith(loading: true);
    switch (event.runtimeType) {
      case AuthStartedEvent:
        break;

      case AuthRegisterEvent:
        yield* _mapAuthRegisterToState(event as AuthRegisterEvent);

        break;

      case AuthLoginEvent:
        yield* _mapAuthLoginToState(event as AuthLoginEvent);

        break;

      case AuthLogOutEvent:
        yield* _mapAuthLogoutToState(event as AuthLogOutEvent);
        break;

      case AuthIsLoggedInEvent:
        yield* _mapAuthIsLoggedInToState(event as AuthIsLoggedInEvent);
        break;

      case AuthUpdateUserNameEvent:
        yield* _mapAuthUpdateUsernameToState(event as AuthUpdateUserNameEvent);
        break;

      default:
    }
  }
}

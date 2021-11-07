import 'package:cryptowallet/repository/firestore_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserRepository {
  final FirebaseAuth _auth;

  UserRepository() : _auth = FirebaseAuth.instance;

  Future<void> signUp(
    String email,
    String password,
    String username,
  ) async {
    await _auth
        .createUserWithEmailAndPassword(
          email: email,
          password: password,
        )
        .then((value) => value.user?.updateDisplayName(username))
        .then((value) => FirestoreRepository().addUser());
  }

  Future<void> signInWithCredentials(
    String email,
    String password,
  ) {
    return _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> signOut() async {
    return _auth.signOut();
  }

  bool isSignedIn() {
    return _auth.currentUser != null;
  }

  User? getUser() {
    return _auth.currentUser;
  }

  Future<void> updateUsername(String name) async {
    await _auth.currentUser?.updateDisplayName(name);
  }
}

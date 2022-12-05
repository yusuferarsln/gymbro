import 'package:firebase_auth/firebase_auth.dart';

FirebaseAuthentication get auth => FirebaseAuthentication.instance;

class FirebaseAuthentication {
  FirebaseAuthentication._();
  static final FirebaseAuthentication instance = FirebaseAuthentication._();

  authLogin(String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  authSignOut() async {
    await FirebaseAuth.instance.signOut();
  }

  authRegister(String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      return userCredential.user!.uid;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  authCheck<bool>() async {
    var currentUserX = FirebaseAuth.instance.currentUser;

    if (currentUserX == null) {
      print('user not lign');
      return false;
    } else {
      print('user logged');
      return true;
    }
  }
}

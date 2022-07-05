import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthRepository {
  final auth = FirebaseAuth.instance;

  Future<void> signUp({required String email, required String password}) async {
    await auth.createUserWithEmailAndPassword(email: email, password: password);
  }

  Future<void> signIn({required String email, required String password}) async {
    print('signIn');
    await auth.signInWithEmailAndPassword(email: email, password: password);
  }

  Future<void> signOut() async {
    try {
      await auth.signOut();
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;
    final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);
    await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future<UserCredential> signInWithFacebook() async {
    final LoginResult loginResult = await FacebookAuth.instance.login();
    final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(loginResult.accessToken!.token);
    return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
  }


}

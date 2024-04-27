import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  //Google Sign In
  Future<UserCredential?> sigInWithGoogle() async {
    try {
      //begin interactive sign in process
      final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();
      // Check if user canceled the sign in
      if (gUser == null) {
        return null; // return null to indicate canceled sign in
      }
      //obtain auth details from request
      final GoogleSignInAuthentication gAuth = await gUser.authentication;

      //create a new credential for user
      final credential = GoogleAuthProvider.credential(
        accessToken: gAuth.accessToken,
        idToken: gAuth.idToken,
      );
      //finally, lets sign in
      return await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      return null;
    }
  }

  // Facebook Sign In
  Future<String?> signInWithFacebook() async {
    try {
      final LoginResult result = await FacebookAuth.instance.login();

      if (result.status == LoginStatus.success) {
        // Successfully logged in, return the access token
        return result.accessToken!.token;
      } else if (result.status == LoginStatus.cancelled) {
        //user cancelled the login
        return null;
      } else {
        // Login failed, handle the error
        print("Facebook login failed: ${result.message}");
        return null;
      }
    } catch (e) {
      // Handle any errors that occur during sign-in
      print("Error signing in with Facebook: $e");
      return null;
    }
  }

  //Sign Out
  signOut() {
    FirebaseAuth.instance.signOut();
  }
}

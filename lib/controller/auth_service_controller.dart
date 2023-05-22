import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthServiceController extends GetxController {
  static AuthServiceController get instance => Get.find();

  Future<User?> signInWithGoogle() async {
    // Begin interactive sign in process
    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();
    if (gUser == null) {
      // User canceled the sign-in flow or something went wrong
      return null;
    }
    // Obtain auth details from request
    final GoogleSignInAuthentication gAuth = await gUser.authentication;
    // Create a new credential for user
    final credential = GoogleAuthProvider.credential(
      accessToken: gAuth.accessToken,
      idToken: gAuth.idToken,
    );
    // Finally, let's sign in
    final userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);
    return userCredential.user;
  }
  
  // facebook privacy policy generator
  Future<UserCredential?> signInWithFacebook() async {
    // Trigger the sign-in flow
    final LoginResult loginResult = await FacebookAuth.instance.login();
    
    // Check if the user has signed in successfully
    if (loginResult.status == LoginStatus.success) {
      // Obtain the auth credential from the response
      final OAuthCredential facebookAuthCredential =
          FacebookAuthProvider.credential(loginResult.accessToken!.token);

      // Finally, let's authenticate with Firebase using that credential
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithCredential(facebookAuthCredential);

      return userCredential;
    } else {
      if (kDebugMode) {
        print('Failed to sign in with Facebook. ${loginResult.status}');
      }
      return null;
    }
  }
}

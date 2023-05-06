import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

// lấy mã băm SHA
/* -- keytool -list -v -keystore ~/.android/debug.keystore -alias androiddebugkey -storepass android -keypass android -- */
class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  //Varibales
  final _auth = FirebaseAuth.instance;
  late final Rx<User?> firebaseUser;
  var verificationId = ''.obs;
  // will be load when app launches this func will be colled and set the firebaseUser state
  // @override
  // void onReady() {
  //   Future.delayed(const Duration(seconds: 6));
  //   firebaseUser = Rx<User?>(_auth.currentUser);
  //   firebaseUser.bindStream(_auth.userChanges());
  // }

  // authentication phone
  Future<void> phoneAuthentication(String phoneNo) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNo,
      verificationCompleted: (credential) async {
        await _auth.signInWithCredential(credential);
      },
      codeSent: (verificationId, forceResendingToken) {
        this.verificationId.value = verificationId;
      },
      codeAutoRetrievalTimeout: (verificationId) {
        this.verificationId.value = verificationId;
      },
      verificationFailed: (e) {
        if (e.code == 'invalid-phone-number') {
          Get.snackbar('Error', 'The provided phone number is not valid.');
        } else {
          Get.snackbar('Error', 'Something went wrong. Try again');
        }
      },
    );
  }

  // otp
  Future<bool> verifyOTP(String otp) async {
    try {
      var credentials = await _auth.signInWithCredential(
          PhoneAuthProvider.credential(
              verificationId: verificationId.value, smsCode: otp));
      return credentials.user != null ? true : false;
    } catch (e) {
      if (kDebugMode) {
        print('Error verifying OTP: $e');
      }
      return false;
    }
  }

// Hàm sendEmailVerification để gửi email chứa mã xác thực đến địa chỉ email được cung cấp.
  Future<void> sendEmailVerification(String email) async {
    try {
      await _auth.sendSignInLinkToEmail(
        email: email,
        actionCodeSettings: ActionCodeSettings(
          url: 'https://meditate-app-e19c8.firebaseapp.com/__/auth/action?mode=action&oobCode=code',
          handleCodeInApp: true,
          iOSBundleId: 'com.example.meditationApp',
          androidPackageName: 'com.example.meditation_app',
          androidInstallApp: true,
          androidMinimumVersion: '16',
        ),
      );
    } catch (e) {
      if (kDebugMode) {
        print('Error sending email verification: $e');
      }
    }
  }

// Hàm verifyEmail để xác thực email với mã xác thực được cung cấp.
  Future<bool> verifyEmail(String email, String code) async {
    try {
      UserCredential credential = await _auth.signInWithEmailLink(
        email: email,
        emailLink: code,
      );
      return credential.user != null ? true : false;
    } catch (e) {
      if (kDebugMode) {
        print('Error verifying email: $e');
      }
      return false;
    }
  }
}

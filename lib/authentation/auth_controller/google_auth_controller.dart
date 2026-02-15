import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../Bottom_Navigationbar/bottom_navigationBar.dart';
import '../user_info_page.dart';

class GoogleAuthController extends GetxController {
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email', 'profile']);
  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool _isLoading = false;
  String _message = '';

  bool get isLoading => _isLoading;
  String get message => _message;

  /// The signed-in user's email (Gmail they selected)
  String? get userEmail => _auth.currentUser?.email;

  /// The signed-in user's display name from Google
  String? get userName => _auth.currentUser?.displayName;

  /// The signed-in user's profile photo URL
  String? get userPhotoUrl => _auth.currentUser?.photoURL;

  /// The current Firebase user
  User? get currentUser => _auth.currentUser;

  /// Whether the user is currently signed in
  bool get isSignedIn => _auth.currentUser != null;

  Future<void> signInWithGoogle(BuildContext context) async {
    try {
      _isLoading = true;
      update();

      // 1. Trigger the Google Authentication flow
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        _message = 'Google sign-in was cancelled';
        _isLoading = false;
        update();
        return;
      }

      // 2. Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // 3. Create a new credential
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // 4. Sign in with Firebase
      final UserCredential userCredential = await _auth.signInWithCredential(
        credential,
      );

      if (userCredential.user != null) {
        final email = userCredential.user!.email ?? 'unknown';
        _message = 'Signed in successfully with $email';

        // Check if this is a new user or a returning user
        final bool isNewUser =
            userCredential.additionalUserInfo?.isNewUser ?? true;

        if (isNewUser) {
          // New user → go to UserInfoPage to complete profile
          Get.offAll(() => const UserInfoPage());
        } else {
          // Returning user → go straight to home
          Get.offAll(() => const BottomNavBar());
        }
      }
    } catch (e) {
      _message = 'Error signing in with Google: $e';
      Get.snackbar(
        'Error',
        _message,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.shade400,
        colorText: Colors.white,
      );
    } finally {
      _isLoading = false;
      update();
    }
  }

  Future<void> signOut() async {
    try {
      await _googleSignIn.signOut();
      await _auth.signOut();
      _message = 'Signed out successfully';
      update();
    } catch (e) {
      _message = 'Error signing out: $e';
    }
  }
}

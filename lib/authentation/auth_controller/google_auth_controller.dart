import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../user_info_page.dart';

class GoogleAuthController extends GetxController {
  late GoogleSignIn _googleSignIn;
  bool _isLoading = false;
  String _message = '';

  bool get isLoading => _isLoading;
  String get message => _message;

  @override
  void onInit() {
    super.onInit();
    _googleSignIn = GoogleSignIn(scopes: ['email', 'profile']);
  }

  Future<void> signInWithGoogle(BuildContext context) async {
    try {
      _isLoading = true;
      update();

      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser != null) {
        _message = 'Signed in successfully with ${googleUser.email}';

        // Navigate to user info page after Google sign-in
        Get.to(() => const UserInfoPage());
      } else {
        _message = 'Google sign-in was cancelled';
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
      _message = 'Signed out successfully';
      update();
    } catch (e) {
      _message = 'Error signing out: $e';
    }
  }

  Future<GoogleSignInAccount?> get currentUser async {
    return _googleSignIn.currentUser;
  }
}

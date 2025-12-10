import 'package:get/get.dart';
import '../../core/network/network_Caller.dart';
import '../../core/network/network_response.dart';
import '../../core/utils/urals.dart';

class SignupController extends GetxController {
  bool _signupInProgress = false;
  String _message = '';

  bool get signupInProgress => _signupInProgress;
  String get message => _message;

  Future<bool> registerUser(
    String name,
    String email,
    String phone,
    String bloodGroup,
    String districts,
    String city,
  ) async {
    final body = {
      "name": name,
      "email": email,
      "phone": phone,
      "bloodGroup": bloodGroup,
      "districts": districts,
      "city": city,
    };

    final headers = {
      'Content-Type': 'application/json',
    };

    _signupInProgress = true;
    update();

    final Networkresponse response = await Networkcall.postRequest(
      Urls.register_users,
      body,
      header: headers,
    );

    _signupInProgress = false;
    update();

    if (response.issuccess) {
      _message = 'Registration successful! Please sign in.';
      return true;
    } else {
      _message = response.responseJson?['message'] ?? 'Registration failed. Please try again.';
      return false;
    }
  }
}

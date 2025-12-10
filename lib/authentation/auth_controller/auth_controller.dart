import 'package:get/get.dart';
import '../../core/network/network_Caller.dart';
import '../../core/network/network_response.dart';
import '../../core/utils/urals.dart';

class SigninController extends GetxController {
  bool _signinVerificationInprogress = false;
  String _message = '';

  bool get signinverificationInprogress => _signinVerificationInprogress;
  String get message => _message;

  Future<bool> verifySignin(String phone) async {
    final body = {
      "phone": phone,
    };

    final headers = {
      'Content-Type': 'application/json',
    };

    _signinVerificationInprogress = true;
    update();

    final Networkresponse response = await Networkcall.postRequest(
      Urls.authenticate_users,
      body,
      header: headers,
    );

    _signinVerificationInprogress = false;
    update();

    if (response.issuccess) {
      _message = response.responseJson?['message'] ?? 'Login successful';
      return true;
    } else {
      _message = response.responseJson?['message'] ?? 'Wrong credentials';
      return false;
    }
  }
}

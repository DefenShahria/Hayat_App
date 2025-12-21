import 'package:get/get.dart';
import '../../authentation/auth_controller/auth_controller.dart';
import '../../authentation/auth_controller/signup_controller.dart';
import '../../authentation/auth_controller/google_auth_controller.dart';

class ControllerBinder extends Bindings {
  @override
  void dependencies() {
    Get.put(SigninController());
    Get.put(SignupController());
    Get.put(GoogleAuthController());
  }
}

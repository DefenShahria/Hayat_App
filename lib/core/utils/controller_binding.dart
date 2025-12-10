import 'package:get/get.dart';
import '../../authentation/auth_controller/auth_controller.dart';


class ControllerBinder extends Bindings{
  @override
  void dependencies() {

    Get.put(SigninController());

  }
}
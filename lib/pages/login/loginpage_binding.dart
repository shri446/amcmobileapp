
import 'package:get/get.dart';

import 'login_controller.dart';

class LoginPageBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => LoginController());
    //Get.lazyPut(() => AuthenticatedApiService());
  }
}


import 'package:amcmobile/service/apiservice.dart';
import 'package:amcmobile/service/authenticated_apiservice.dart';
import 'package:get/get.dart';

import 'login_controller.dart';

class LoginPage_Binding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => LoginController());
    Get.lazyPut(() => ApiService1());
  }
}

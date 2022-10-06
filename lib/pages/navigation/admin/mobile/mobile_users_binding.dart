import 'package:amcmobile/pages/navigation/admin/mobile/mobile_users_controller.dart';
import 'package:get/get.dart';

class MobileUsersBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => MobileUsersController());
  }
}
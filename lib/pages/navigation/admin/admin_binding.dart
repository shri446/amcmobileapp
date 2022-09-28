import 'package:amcmobile/pages/navigation/admin/admin_controller.dart';
import 'package:amcmobile/pages/navigation/admin/mobile/manage_user_controller.dart';
import 'package:amcmobile/pages/navigation/admin/mobile/mobile_users_controller.dart';
import 'package:get/get.dart';

import 'login_history/user_controller.dart';

class AdminBinding extends Bindings{
  @override
  void dependencies() {
  Get.lazyPut(() => AdminController());
  Get.lazyPut(() => UsersController());
  Get.lazyPut(() => ManageUserController());
  Get.lazyPut(() => MobileUsersController());
  }
}
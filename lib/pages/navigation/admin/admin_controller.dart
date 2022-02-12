import 'package:amcmobile/service/authenticated_apiservice.dart';
import 'package:get/get.dart';

import 'login_history/user_controller.dart';

class AdminController extends GetxController{
  final UsersController usersController=Get.find<UsersController>();

  final String title = 'Admin';
  ApiService1 apiservice = Get.find();
  var loginhistory = [].obs;

  void onTabSelect(int index){
    usersController.loginhistory();

  }

  @override
  void onInit() {
    super.onInit();
  }
  @override
  void onReady() {
    print("Opened "+this.runtimeType.toString());
    super.onReady();
  }



}
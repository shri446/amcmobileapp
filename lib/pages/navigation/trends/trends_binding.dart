

import 'package:amcmobile/pages/navigation/trends/trends_controller.dart';
import 'package:amcmobile/service/authenticated_apiservice.dart';
import 'package:get/get.dart';
import 'package:get/get_instance/src/bindings_interface.dart';

class TrendsBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => TrendsController());
    Get.lazyPut(() => ApiService1());
  }

}

import 'package:amcmobile/pages/navigation/sld/sld_controller.dart';
import 'package:get/get.dart';
import 'package:get/get_instance/src/bindings_interface.dart';

class SldBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => SldController());
  }

}
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:get/get_instance/src/extension_instance.dart';

import 'daily_chart_controller.dart';

class DailyChartBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => DailyChartController());
  }
}
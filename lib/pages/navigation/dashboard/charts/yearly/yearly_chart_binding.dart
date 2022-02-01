import 'package:amcmobile/pages/navigation/dashboard/charts/yearly/yearly_chart_controller.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:get/get_instance/src/extension_instance.dart';



class MonthlyChartBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => YearlyChartController());
  }
}

import 'package:amcmobile/pages/navigation/events/events_controller.dart';
import 'package:amcmobile/service/authenticated_apiservice.dart';
import 'package:get/get.dart';
import 'package:get/get_instance/src/bindings_interface.dart';

class EventsBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => EventsController());
    Get.lazyPut(() => ApiService1());
  }
}

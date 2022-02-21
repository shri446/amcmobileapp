
import 'package:amcmobile/pages/navigation/events/events_controller.dart';
import 'package:get/get.dart';
import 'package:get/get_instance/src/bindings_interface.dart';

import '../../../service/authenticated_api_service.dart';

class EventsBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => EventsController());
    Get.lazyPut(() => AuthenticatedApiService());
  }
}

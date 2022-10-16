import 'package:amcmobile/domain/drawing_group.dart';
import 'package:get/get.dart';

import '../../../service/authenticated_api_service.dart';

class SldController extends GetxController {
  AuthenticatedApiService apiservice = Get.find<AuthenticatedApiService>();

  final String title = 'SLD';
  var timesatmp=0.obs;
  var timestamp2=''.obs;
  var drawings={}.obs;
  var selectedDrawing={}.obs;

  @override
  void onReady() {

    drawings.value=apiservice.storage.read("drawings");

    super.onReady();
  }

  onSelectMenuItem(Map map) {
    selectedDrawing.value = map;
    apiservice.postRequest("/oauth/sld", {'id':selectedDrawing.value.keys.first.value}).then((response) {
      if(response.statusCode==200){
         var drawing=response.data['drawing'];
         print(drawing);
      }

    }).onError((error, stackTrace) {
      print(error.toString());
    });

  }


}
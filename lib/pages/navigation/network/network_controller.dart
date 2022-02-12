
import 'package:amcmobile/service/authenticated_apiservice.dart';
import 'package:amcmobile/service/timer_service.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class NetworkController extends GetxController{
  final String title = 'Network';
  final ApiService1 apiService=Get.find<ApiService1>();

  ApiService1 apiservice = Get.find();
  final TimerService timerService = Get.find<TimerService>();
  final RefreshController refreshController=RefreshController(initialRefresh:false);


  final storage=GetStorage("permananent-db");
  final String currentRoute="/navigation/network";


  var device=[].obs;
  var timestamp=0.obs;
  var timestamp2='25-12-2021 11:15:31'.obs;


  @override
  void onReady() {
    getdata();
    timerService.setMethod(()=>getdata());
    super.onReady();
  }
  @override
  void onInit() {

    super.onInit();
  }
  getdata(){
    apiservice.getAllDevices().then((response) {
       print(response);
       print("data");
    device.value = response.data['device'];
    timestamp2.value=response.data['timestamp'];

    print(timestamp2);
     refreshController.refreshCompleted();
      // digitalPoints.value=response.data['Digital'];*/
    });
  }
}
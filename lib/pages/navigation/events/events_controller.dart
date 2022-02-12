
import 'package:amcmobile/service/authenticated_apiservice.dart';
import 'package:amcmobile/service/timer_service.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class EventsController extends GetxController {
 final ApiService1 apiservice = Get.find<ApiService1>();
 final TimerService timerService = Get.find<TimerService>();
 final RefreshController refreshController=RefreshController(initialRefresh: false,);
 final String title = 'Events';

 var selectedStation = {}.obs;
 var stations = [].obs;
 var events=[].obs;
var timestamp=0.obs;
var timestamp2='25-12-2021 11:15:31'.obs;

 @override
 void onReady(){
  getAllStations();
  //timerService.setMethod(()=>getAllStations());
  super.onReady();


 }
 onSelectMenuItem(Map map) {
  selectedStation.value = map;
 }

 getTime(){

 }

 getAllStations() {
  apiservice.getAllStations().then((response) {
   print(response);
   stations.value = response.data['stations'];

   selectedStation.value = response.data['stations'][0];
   apiservice.getAllEvents(selectedStation.value["id"], "Events").then((response) {
    events.value=response.data['events'];
   // timestamp2.value=response.data['timestamp'];
    print(response);
   }
   );
  }
  );
 }

 getdata(){
  apiservice.getAllEvents(selectedStation.value["id"], "Events").then((response) {
   events.value=response.data['events'];
    timestamp2.value=response.data['timestamp'];
   refreshController.refreshCompleted();
   print(response);
  });

 }



 onSelectStation(Map value){
  selectedStation.value=value;
  print(selectedStation.value);
  apiservice.getAllEvents(selectedStation.value["id"], "Events").then((response) {
   events.value=response.data["events"];
   print(events.value);
  }
  );
 }
}

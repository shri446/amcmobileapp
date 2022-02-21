import 'package:amcmobile/domain/time_value_object.dart';
import 'package:amcmobile/pages/navigation/dashboard/charts/daily/daily_chart_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../service/authenticated_api_service.dart';
import 'charts/daily/daily_chart_controller.dart';
import 'charts/monthly/monthly_chart_controller.dart';
import 'charts/monthly/monthly_chart_page.dart';
import 'charts/yearly/yearly_chart_controller.dart';
import 'charts/yearly/yearly_chart_page.dart';

class DashboardController extends GetxController{
  final AuthenticatedApiService apiService=Get.find<AuthenticatedApiService>();
  var statistics=<TimeValueObject>[].obs;
  var timstamp=0.obs;
  var cgs=[].obs;
  var seletedItem = ''.obs;
  var stations = [].obs; //
  var daily=[].obs;
  var tabIndex = 0.obs;


  late Map<String,IconData> tabs;
  onSelectMenuItem(index) {
    seletedItem.value = index;
  }
  final String title='Dashboard';

  @override
  void onInit() {

    tabs={'Dashboard':Icons.dashboard,'Menu':Icons.apps,};/*
    if(GetStorage().read("scope")=='ROLE_ADMIN'){
      tabs.putIfAbsent('Maps', ()=>Icons.map);
      tabs.putIfAbsent('Admin', ()=>Icons.group);
    }*/

    super.onInit();
  }



  getData(){

  }

  showDailyChartDialog() {
    Get.lazyPut(() => DailyChartController());
    Get.bottomSheet(DailyChartPage(),useRootNavigator: true,settings: RouteSettings(name: '/navigation/dashboard/daily_chart'));
  }
  showMonthlyChartDialog() {
    Get.lazyPut(() => MonthlyChartController());
    Get.bottomSheet(MonthlyChartPage(),useRootNavigator: true,settings: RouteSettings(name: '/navigation/dashboard/monthly_chart'));
  }
  showYearlyChartDialog() {
    Get.lazyPut(() => YearlyChartController());
    Get.bottomSheet(YearlyChartPage(),useRootNavigator: true,settings: RouteSettings(name: '/navigation/dashboard/yearly_chart'));
  }
  goToSelectedTab(int index,GetDelegate delegate,GetNavConfig navConfig) async {
    tabIndex.value = index;

    if(index==0) {
      delegate.offNamed("/navigation/dashboard");
    }else if(index==1) {
      delegate.offNamed("/navigation/navpage");
    }
  }

}

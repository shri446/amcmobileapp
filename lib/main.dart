
//@dart=2.9

import 'dart:convert';

import 'package:amcmobile/pages/login/login_page.dart';
import 'package:amcmobile/pages/login/loginpage_binding.dart';
import 'package:amcmobile/pages/navigation/admin/admin_binding.dart';
import 'package:amcmobile/pages/navigation/dashboard/dashboard_binding.dart';
import 'package:amcmobile/pages/navigation/dashboard/dashboard_page.dart';
import 'package:amcmobile/pages/navigation/sld/sld_binding.dart';
import 'package:amcmobile/pages/navigation/sld/sld_page.dart';
import 'package:amcmobile/pages/navigation/trends/trends.dart';
import 'package:amcmobile/pages/root/root_page.dart';
import 'package:amcmobile/pages/navigation/admin/admin.dart';
import 'package:amcmobile/pages/navigation/events/events_binding.dart';
import 'package:amcmobile/pages/navigation/events/events_page.dart';
import 'package:amcmobile/pages/navigation/network/network_binding.dart';
import 'package:amcmobile/pages/navigation/network/network_page.dart';
import 'package:amcmobile/pages/navigation/realtime/realtime_binding.dart';
import 'package:amcmobile/pages/navigation/realtime/realtime_page.dart';
import 'package:amcmobile/pages/navigation/reports/reports_binding.dart';
import 'package:amcmobile/pages/navigation/reports/reports_page.dart';
import 'package:amcmobile/pages/navigation/trends/trends_binding.dart';
import 'package:amcmobile/service/amctheme_service.dart';
import 'package:amcmobile/service/authenticated_apiservice.dart';
import 'package:amcmobile/service/timer_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
void main() {
SystemChrome.setSystemUIOverlayStyle(
  SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ),
);
  Get.lazyPut(() => ApiService1());
  Get.lazyPut(() => TimerService());
  Get.lazyPut(() => AmcThemeService());
  runApp(MyApp());
}
//testgithub

class MyApp extends StatelessWidget {
  AmcThemeService amcThemeService=Get.find<AmcThemeService>();
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "/rootpage",
      defaultTransition: Transition.leftToRight,
      getPages: [

       // GetPage(name: "/splash", page:()=> SplashPage(),binding: Splash_Binding()),
        GetPage(name: "/rootpage", page:()=> RootPage()),
        GetPage(name: "/loginpage", page:()=> LoginPage(),binding: LoginPage_Binding()),
        GetPage(name: "/realtime", page:()=> Realtime(),binding: RealTimeBinding()),
        GetPage(name: "/network", page:()=> Network(),binding: NetworkBinding()),
        GetPage(name: "/reports", page:()=> Reports(),binding: ReportsBinding()),
        GetPage(name: "/sld", page:()=> Sld(),binding: SldBinding()),
        GetPage(name: "/trends", page:()=> Trends2(),binding: TrendsBinding(),),
        GetPage(name: "/events", page:()=> Events(),binding: EventsBinding()),
        GetPage(name: "/dashboard", page:()=> DashboardPage(),binding:DashboardBinding()),
        GetPage(name: "/admin", page:()=> Admin(),binding:AdminBinding()),
      ],
      theme: amcThemeService.loadLightTheme(),
      darkTheme: amcThemeService.loadDarkTheme(),
      themeMode: amcThemeService.getThemeMode(),
    );
  }

}





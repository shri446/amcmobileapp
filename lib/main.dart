
//@dart=2.9

import 'dart:convert';
import 'dart:io';

import 'package:amcmobile/pages/login/login.dart';
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
import 'package:amcmobile/service/authenticated_api_service.dart';
import 'package:amcmobile/service/timer_service.dart';
import 'package:amcmobile/staticpage.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';
Future<void> main() async{
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ),
  );
  GetStorage.init();
  Get.lazyPut(() => AuthenticatedApiService());
  Get.lazyPut(() => TimerService());
  Get.lazyPut(() => AmcThemeService());

  AuthenticatedApiService authenticatedApiService=Get.find<AuthenticatedApiService>();
  await authenticatedApiService.checkNetworkAfterMain();
  runApp(MyApp());
}
//testgithub

class MyApp extends StatelessWidget {
  AmcThemeService amcThemeService=Get.find<AmcThemeService>();
  AuthenticatedApiService authenticatedApiService=Get.find<AuthenticatedApiService>();

  @override

  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: authenticatedApiService.initialRoute,
      defaultTransition: Transition.zoom,
      getPages: [
        GetPage(name: "/staticpage", page:()=> StaticPage()),
        GetPage(name: "/rootpage", page:()=> RootPage()),
        GetPage(name: "/loginpage", page:()=> LoginPage(),binding: LoginPageBinding()),
        GetPage(name: "/realtime", page:()=> Realtime(),binding: RealTimeBinding()),
        GetPage(name: "/network", page:()=> Network(),binding: NetworkBinding()),
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


getDeviceInfo() async{
  // final networkInfo = NetworkInfo();
  // String wifiName = await networkInfo.getWifiName() ?? 'Not found';
  // String wifiIp = await networkInfo.getWifiIP() ?? 'Not found';
  // String wifiGateway = await networkInfo.getWifiGatewayIP() ?? 'Nofound';

  if (Platform.isIOS) {
    return _readIosDeviceInfo(await DeviceInfoPlugin().iosInfo);
  } else if (Platform.isAndroid) {
    return _readAndroidBuildData(await DeviceInfoPlugin().androidInfo);
  }
}
Map<String, dynamic> _readAndroidBuildData(AndroidDeviceInfo info) {
  return <String, dynamic>{
    'Brand': info.brand,
    'Manufacturer': info.manufacturer,
    'Model': info.model,
    'Device': info.device,
    'Display': info.display,
    'Hardware': info.hardware,
    'Fingerprint': info.fingerprint,
    'Host': info.host,
    'Id': info.id,
    'Product': info.product,
    'AndroidId': info.androidId,
    'Version.securityPatch': info.version.securityPatch,
    'Version.sdk': info.version.sdkInt.toString()+'.'+info.version.release.toString()+'.'+info.version.previewSdkInt.toString(),
    'Version.incremental': info.version.incremental,
    'Version.codename': info.version.codename,

    // 'version.previewSdkInt': build.version.previewSdkInt,
    // 'version.release': build.version.release,
    // 'supportedAbis': build.supportedAbis,
    // 'Tags': build.tags,
    // 'Board': build.board,
    // 'version.baseOS': build.version.baseOS,
    // 'supported32BitAbis': build.supported32BitAbis,
    // 'supported64BitAbis': build.supported64BitAbis,
    // 'Bootloader': build.bootloader,
    // 'type': build.type,
    // 'isPhysicalDevice': build.isPhysicalDevice,
    // 'systemFeatures': build.systemFeatures,
  };
}

Map<String, dynamic> _readIosDeviceInfo(IosDeviceInfo info) {
  return <String, dynamic>{
    'Name': info.name,
    'Model': info.model,
    'SystemName': info.systemName,
    'systemVersion': info.systemVersion,
    'localizedModel': info.localizedModel,
    'identifierForVendor': info.identifierForVendor,
    'utsname.sysname:': info.utsname.sysname,
    'utsname.nodename:': info.utsname.nodename,
    'utsname.release:': info.utsname.release,
    'utsname.version:': info.utsname.version,
    'utsname.machine:': info.utsname.machine,
    // 'isPhysicalDevice': data.isPhysicalDevice,
  };
}



import 'package:amcmobile/pages/navigation/realtime/analog/analog_page.dart';
import 'package:amcmobile/pages/navigation/realtime/digital/digital_page.dart';
import 'package:amcmobile/pages/navigation/realtime/realtime_controller.dart';
import 'package:amcmobile/pages/navigation/widget/appbar_widgets.dart';
import 'package:amcmobile/pages/navigation/widget/stationDropdown/station.dart';
import 'package:amcmobile/themes/app_colors.dart';
import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:get/get.dart';


class Realtime extends GetView<RealTimeController > {
  @override
  Widget build(BuildContext context) {
    var _scaffoldKey = new GlobalKey<ScaffoldState>();
    context.theme;
    return  Obx(()=>Scaffold(
        key: _scaffoldKey,
        endDrawer: AppDrawer(),
      appBar: createAppbar(controller.title,controller.timestamp2.value,Get.find(),),
        body:Builder(
            builder: (BuildContext context) {
                   return SingleChildScrollView(
                     child: Column(
                       children: [
                         SizedBox(height: 1,),
                         station(),
                         SizedBox(height: 1,),
                         Expanded(
                           child: Container(
                             child: ContainedTabBarView(
                               tabBarProperties: TabBarProperties(
                                 background: Container(
                                   color: AppColors.getContainerColor(),
                                 ),
                                 labelColor: AppColors.getDynamicTextColor(),
                               ),
                               tabs:[
                                 Text('AnalogPoint',style:TextStyle(fontSize: 18,fontWeight: FontWeight.bold)),
                                 Text('DigitalPoint',style:TextStyle(fontSize: 18,fontWeight: FontWeight.bold)),
                               ],
                               views:[
                                 AnalogPage(),
                                 DigitalPage(),
                               ],
                               initialIndex:0,
                               onChange:(index)=>controller.onTabSelect(index),
                             ),
                           ),
                         )
                       ],
                     ),
                   );
            }
        )
    ));






  }
}



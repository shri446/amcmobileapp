import 'package:amcmobile/pages/navigation/dashboard/widget_dashboard.dart';
import 'package:amcmobile/pages/navigation/trends/station.dart';
import 'package:amcmobile/pages/navigation/widget/appbar_widgets.dart';
import 'package:amcmobile/pages/root/nav_page1.dart';
import 'package:amcmobile/pages/root/nav_page1.dart';
import 'package:amcmobile/pages/root/nav_page1.dart';
import 'package:amcmobile/pages/root/nav_page1.dart';
import 'package:amcmobile/themes/app_colors.dart';
import 'package:amcmobile/themes/app_theme.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:get/get_utils/src/extensions/context_extensions.dart';

import 'dashboard_controller.dart';

class DashboardPage extends GetView<DashboardController>{
  @override
  Widget build(BuildContext context) {
  context.theme;
  return  Scaffold(
    appBar: dashboardAppbar(controller.title),
    body:
       SingleChildScrollView(
        child: Container(
          padding:const EdgeInsets.all(5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
             station1(),
              GridDemandChartPage(),
              SizedBox(height: 10,),
              createSecondRow(controller),
              createThirdRow(controller),
            ],
          ),
        ),
       ),


  );

  }
}
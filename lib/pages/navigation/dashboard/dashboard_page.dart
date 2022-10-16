import 'package:amcmobile/pages/navigation/dashboard/widget_dashboard.dart';
import 'package:amcmobile/pages/navigation/widget/appbar_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:get/get_utils/src/extensions/context_extensions.dart';

import 'dashboard_controller.dart';

class DashboardPage extends GetView<DashboardController>{
  @override
  Widget build(BuildContext context) {
    var _scaffoldKey = new GlobalKey<ScaffoldState>();
    context.theme;
  return  Scaffold(
    key: _scaffoldKey,
    endDrawer: AppDrawer(),
    appBar: dashboardAppbar(controller.title),
    body: SingleChildScrollView(
        child: Container(
          padding:const EdgeInsets.all(5),
          child: Column(

            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Station1(),
              GridDemandChartPage(),
              SizedBox(height: 15,),
              createSecondRow(controller),
              createThirdRow(controller),
            ],
          ),
        ),
       ),


  );

  }
}
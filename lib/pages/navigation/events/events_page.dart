
import 'package:amcmobile/pages/navigation/events/selected_station.dart';
import 'package:amcmobile/pages/navigation/widget/appbar_widgets.dart';
import 'package:amcmobile/themes/app_colors.dart';
import 'package:amcmobile/themes/app_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:get/get.dart';
import 'events_controller.dart';
import 'events_widget.dart';

class Events extends GetView<EventsController>{
  DateTime selectedDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    var _scaffoldKey = new GlobalKey<ScaffoldState>();
    context.theme;
    return Obx(()=> Scaffold(
        key: _scaffoldKey,
        endDrawer: AppDrawer(),
      appBar: eventsAppbar(controller.title,controller.timestamp2.value,Get.find()),
        body: Builder(
          builder: (context) {
            return Column(
              children: [
                SizedBox(height: 1),
                SelectedStation(),
                SizedBox(height: 1),
                Table(
                border: TableBorder.all(color: AppColors.getDynamicTextColor(),width: 1,),
                  children: [
                    TableRow(
                      decoration: BoxDecoration(color: Colors.white,),
                      children: [
                        Text('Point Name',textAlign: TextAlign.center,style: TextStyle(color: Colors.black,height:2,fontSize: 16,fontWeight: FontWeight.bold) ),
                        Text('Timestamp',textAlign: TextAlign.center,style: TextStyle(color: Colors.black,height:2,fontSize: 16,fontWeight: FontWeight.bold),),
                        Text('Status',textAlign: TextAlign.center,style: TextStyle(color: Colors.black,height:2,fontSize: 16,fontWeight: FontWeight.bold),),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 1,),
                Expanded(
                  child: EventsListView(),
                ),
              ],
            );
          }
        )
    )
    );
}







  }


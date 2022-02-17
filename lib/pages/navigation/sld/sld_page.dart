import 'package:amcmobile/pages/navigation/sld/sld_controller.dart';
import 'package:amcmobile/pages/navigation/widget/appbar_widgets.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';


class Sld extends GetView<SldController>{
  DateTime selectedDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    var _scaffoldKey = new GlobalKey<ScaffoldState>();
    return Scaffold(
      key: _scaffoldKey,
      endDrawer: AppDrawer(),
      appBar: sldcAppbar(controller.title),



    );
  }
}
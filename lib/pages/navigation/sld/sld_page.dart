import 'package:amcmobile/pages/navigation/sld/sld_controller.dart';
import 'package:amcmobile/pages/navigation/widget/appbar_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

import '../../../themes/app_colors.dart';


class Sld extends GetView<SldController>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: AppDrawer(),
      appBar: sldcAppbar(controller.title),
      body: Column(
        children: [
          DropdownButton<Map>(
            hint:Text("Select SLD",style: TextStyle(color: AppColors.getDynamicTextColor()),),
            // value: controller.selectedStation.value,
            items: createDropdownMenuItems(controller),
            // onChanged:(item){controller.onSelectMenuItem(item!);},
            onChanged: (item)=> controller.onSelectMenuItem(item!),
          ),
        ],
      ),


    );
  }

  List<DropdownMenuItem<Map>> createDropdownMenuItems(SldController controller){
    List<DropdownMenuItem<Map>> list=[];
    controller.drawings.value.forEach((id,name) {
      DropdownMenuItem<Map> widget=DropdownMenuItem<Map>(
        value: id,
        child: Text(name),
      );
      list.add(widget);
    });
    return list;
  }
}
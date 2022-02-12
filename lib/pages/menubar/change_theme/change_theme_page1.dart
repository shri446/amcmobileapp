import 'package:amcmobile/pages/menubar/change_theme/changetheme_controller.dart';
import 'package:amcmobile/service/amctheme_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

import '/themes/app_colors.dart';

class ChangeThemePage1 extends GetView<ChangeTheme_Controller>{
  AmcThemeService amcThemeService=Get.find<AmcThemeService>();
  @override
  Widget build(BuildContext context) {
    context.theme;
    return Scaffold(
      endDrawer: Drawer(),

         // ListView(
         //    padding: EdgeInsets.zero,
         //    children: [
         //      SizedBox(height: 20,),
         //      Padding(padding: EdgeInsets.fromLTRB(20, 10, 10, 10),child: Text("Color Code",style: Get.textTheme.headline6),),
         //      GridView.builder(
         //        physics: NeverScrollableScrollPhysics(),
         //        shrinkWrap: true,
         //        itemCount:AppColors.themes.length,
         //        padding: EdgeInsets.symmetric(horizontal: 8),
         //        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
         //          crossAxisCount: 4,
         //          mainAxisSpacing: 15,
         //          crossAxisSpacing: 35,
         //          mainAxisExtent: 60,
         //        ),
         //        itemBuilder:(context,index){
         //          return InkWell(
         //              splashColor: Colors.white,
         //              onTap: ()=>amcThemeService.onSelectTheme(index),
         //              child: Obx(()=>Container(
         //                height: 35,
         //                width: 35,
         //                padding: EdgeInsets.all(amcThemeService.selectedThemeIndex.value==index ? 5 : 0),
         //                decoration: BoxDecoration(
         //                  border: Border.all(color: AppColors.themes[index],),
         //                  borderRadius: BorderRadius.circular(100),
         //
         //                ),
         //                child: Container(
         //                  //width: 40,
         //                  decoration: BoxDecoration(
         //                      borderRadius: BorderRadius.all(Radius.circular(100)),
         //                      color: AppColors.themes[index]),),
         //              ))
         //          );
         //        },
         //      )
         //    ]),
      );

  }

}

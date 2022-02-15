import 'package:amcmobile/service/amctheme_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

import '/themes/app_colors.dart';

class ChangeThemePage extends GetView{
  AmcThemeService amcThemeService=Get.find<AmcThemeService>();
  @override
  Widget build(BuildContext context) {
    context.theme;
    return Container(
        height: 270,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(0)),
          border: Border.all(color: AppColors.getDynamicTextColor()),
          color:Colors.white,//AppColors.backgroundColor()
        ),
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(padding: EdgeInsets.fromLTRB(20, 10, 10, 10),child: Text("Color code",style: Get.textTheme.headline6),),
            GridView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount:AppColors.themes.length,
              padding: EdgeInsets.symmetric(horizontal: 10),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 10,
                  mainAxisExtent: 50,
              ),
              itemBuilder:(context,index){
                return InkWell(
                    splashColor: Colors.white,
                    onTap: ()=>amcThemeService.onSelectTheme(index),
                    child: Obx(()=>Container(
                      height: 35,
                      width: 35,
                      padding: EdgeInsets.all(amcThemeService.selectedThemeIndex.value==index ? 5 : 0),
                      decoration: BoxDecoration(
                          border: Border.all(color: AppColors.themes[index],),
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: Container(
                        //width: 40,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(100)),
                            color: AppColors.themes[index]),),
                    ))
                );
              },
            )
          ],
        )
    );
  }

}
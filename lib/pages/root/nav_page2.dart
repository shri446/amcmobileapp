import 'package:amcmobile/pages/navigation/widget/appbar_widgets.dart';
import 'package:amcmobile/themes/app_colors.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class Navpage2 extends GetView{
  @override
  Widget build(BuildContext context) {
    context.theme;
    return Scaffold(
        appBar: navAppbar(),
        body: Container(
        padding: EdgeInsets.all(10),
    height: MediaQuery.of(context).size.height,
    width: double.infinity,
    child: Column(
    children: [
    SizedBox(
    height: 180,
    width: 380,
    child: Carousel(
    images: [
    AssetImage("assets/power3.jpg",),
    AssetImage("assets/wall1.jpg"),
    AssetImage("assets/wall2.jpg",),
    ],
    dotSize: 4.0,
    dotSpacing: 15.0,
    dotColor: Colors.lightGreenAccent,
    indicatorBgPadding: 5.0,
    dotBgColor: Colors.purple.withOpacity(0.5),
    borderRadius: true,
    )
    ),
      SizedBox(height:10),
      createPages()
      ]
    )
        )
    );
  }
}


Widget createPages(){
  return Container(
      child:StaggeredGridView.count(
        crossAxisCount: 2,
        shrinkWrap: true,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        padding: EdgeInsets.fromLTRB(3,3,3,3),
        physics: NeverScrollableScrollPhysics(),
        staggeredTiles: [StaggeredTile.fit(1),StaggeredTile.fit(1),StaggeredTile.fit(1),StaggeredTile.fit(1),StaggeredTile.fit(1),StaggeredTile.fit(1),StaggeredTile.fit(1),StaggeredTile.fit(1)],
        children:<Widget> [
          Navpages( "RealTime","realtime","assets/clock.svg",),
          Navpages( "Trends","trends","assets/trends.svg",),
          Navpages( "Network","network","assets/net.svg",),
          Navpages( "Reports","reports","assets/exc.svg"),
          Navpages( "Sldc","sldc","assets/net.svg"),
          Navpages( "Events","events","assets/events.svg"),
          Navpages( "Dashboard","dashboard","assets/dashboard.svg"),
          Navpages( "Admin","admin","assets/admin.svg"),

        ],
      )
  );

}

Widget Navpages(String textvalue,String page,String icon,){
  return Container(
      child: InkWell(
      onTap: (){
    Get.toNamed(page);
  },
    // onTap: ()=>controller.showGridDemandChartDialog(),
    child : Container(
        padding: EdgeInsets.fromLTRB(10,5,10,10),
          height: 100,
          // margin: EdgeInsets.fromLTRB(3, 3, 3, 3),
          decoration: BoxDecoration(color: Colors.white ,
            border: Border.all(color:AppColors.getBorderColor()),
            borderRadius: BorderRadius.circular(10),),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(textvalue,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold)),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                // crossAxisAlignment: CrossAxisAlignment.end,
                children: [

                  SvgPicture.asset(icon,width: 50,color: AppColors.getThemeColor(),),

                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      /*AnimatedFlipCounter(
                          value:controller.gridDemand.value.toDouble(),
                          textStyle: TextStyle(fontSize: 23, fontWeight: FontWeight.bold,letterSpacing: -2,color:AppColors.getDynamicTextColor())
                      ),*/

                    ],)
                ],
              )
            ],
          )
                )
      )

  );
}

import 'package:amcmobile/pages/navigation/widget/appbar_widgets.dart';
import 'package:amcmobile/themes/app_colors.dart';
import 'package:amcmobile/themes/app_theme.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
class RootPage extends GetView{
  @override Widget build(BuildContext context) {
    context.theme;
    return Scaffold(
        endDrawer: AppDrawer(),
        appBar: navAppbar(),
        body: SingleChildScrollView(
          child: Container(
          padding: EdgeInsets.all(10),
          // height: MediaQuery.of(context).size.height,
          //width: double.infinity,
          child: Column(
          children: [
            SizedBox(
              height: 190,
              // width: 370,
              child: Carousel(
              images: [
                AssetImage("assets/images/power3.jpg",),
                AssetImage("assets/images/wall1.jpg"),
                AssetImage("assets/images/wall2.jpg",),
              ],
              dotSize: 4.0,
              dotSpacing: 15.0,
              dotColor: Colors.lightGreenAccent,
              indicatorBgPadding: 5.0,
              dotBgColor: Colors.purple.withOpacity(0.5),
              borderRadius: true,
            )
          ),
            SizedBox(height:5),
            createPages(),
            Admin1()
          ]
      )
          ),
        ));
  }
}


Widget createPages(){
  return SingleChildScrollView(
    child: Container(
        child:StaggeredGridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          crossAxisSpacing:10,
          mainAxisSpacing: 2,
          padding: EdgeInsets.fromLTRB(0,0,0,0),
          physics: NeverScrollableScrollPhysics(),
          staggeredTiles: [StaggeredTile.fit(1),StaggeredTile.fit(1),StaggeredTile.fit(1),StaggeredTile.fit(1),StaggeredTile.fit(1),StaggeredTile.fit(1)],
          children:<Widget> [
            Navpages( "RealTime","realtime","assets/images/clock.svg",),
            Navpages( "Trends","trends","assets/images/trends.svg",),
            Navpages( "Network","network","assets/images/network.svg",),
           // Navpages( "Reports","reports","assets/images/excel.svg"),
            Navpages( "Sld","sld","assets/images/network.svg"),
            Navpages( "Events","events","assets/images/events.svg"),
            Navpages( "Dashboard","dashboard","assets/images/dashboard.svg"),

          ],
        )
    ),
  );
}

Widget Admin1(){
  return SingleChildScrollView(
    child: Container(
        child:StaggeredGridView.count(
          crossAxisCount: 1,
          shrinkWrap: true,
          padding: EdgeInsets.fromLTRB(0,0,0,0),
          physics: NeverScrollableScrollPhysics(),
          staggeredTiles: [StaggeredTile.fit(1)],
          children:<Widget> [
            Navpages1( "Admin","admin","assets/images/admin.svg"),
          ],
        )
    ),
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
        padding: EdgeInsets.fromLTRB(10,7,10,10),
          height: 105,
           margin: EdgeInsets.fromLTRB(0, 8, 0, 2),
          decoration: AppTheme.boxDecorationStyle(),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(textvalue,style: AppTheme.cardTitleStyle()),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                // crossAxisAlignment: CrossAxisAlignment.end,
                 children: [
                  SvgPicture.asset(icon,width: 50.00,color: AppColors.getThemeColor(),),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      ],)
                ],
              )
            ],
          )
                )
      )

  );
}

Widget Navpages1(String textvalue,String page,String icon,){
  return Container(
      child: InkWell(
          onTap: (){
            Get.toNamed(page);
          },
          // onTap: ()=>controller.showGridDemandChartDialog(),
          child : SingleChildScrollView(
            child: Container(
                padding: EdgeInsets.fromLTRB(10,5,10,10),
                height: 105,
                margin: EdgeInsets.fromLTRB(1, 8, 0, 5),
                decoration: AppTheme.boxDecorationStyle(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(textvalue,style: AppTheme.cardTitleStyle()),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      // crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        SvgPicture.asset(icon,width: 50.00,color: AppColors.getThemeColor(),),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                          ],)
                      ],
                    )
                  ],
                )
            ),
          )
      )

  );
}
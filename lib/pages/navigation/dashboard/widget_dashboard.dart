import 'package:amcmobile/domain/time_value_object.dart';
import 'package:amcmobile/themes/app_colors.dart';
import 'package:amcmobile/themes/app_theme.dart';
import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:get/get_utils/src/extensions/context_extensions.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'dashboard_controller.dart';

/*
Widget createInformation(DashboardController controller){
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(

        padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
        child: Text("Geographic Information", style: AppTheme.cardTitleStyle(),),

      ),
      Container(
          child:StaggeredGridView.count(
            crossAxisCount: 1,
            shrinkWrap: true,
            crossAxisSpacing: 5,
            mainAxisSpacing: 5,
            padding: EdgeInsets.fromLTRB(3,3,3,3),
            physics: NeverScrollableScrollPhysics(),
            staggeredTiles: [StaggeredTile.fit(1),],
            children: [
              createGeographicContainer(controller),

            ],
          )

      )

    ],
  );

}

Widget createGeographicContainer(DashboardController controller){
  return InkWell(
    // onTap: ()=>controller.showGridDemandChartDialog(),
      child:Container(
          padding: EdgeInsets.fromLTRB(10,5,10,10),
          height: 180,
          // margin: EdgeInsets.fromLTRB(3, 3, 3, 3),
          decoration: AppTheme.boxDecorationStyle(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text("Location",style: AppTheme.cardTitleStyle()),
              Row(
                children: [
                  Text("Capacity",style:AppTheme.cardTitleStyle()),
                  Text(":"),
                ],
              ),
              Row(
                children: [
                  Text("Surface",style:AppTheme.cardTitleStyle()),
                  Text(":"),
                ],

              )
            ],
          )
      )
  );
}*/

class station1 extends GetView<DashboardController>{
  @override
  Widget build(BuildContext context) {
    context.theme;
    return  Container(
      margin: EdgeInsets.all(0),
      color: Colors.transparent,
      child:Container(
        height: 40,
        child:Padding(
          padding: EdgeInsets.fromLTRB(15, 2, 8,2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              DropdownButton<Map>(
                hint:Text("Select item",style: TextStyle(color: AppColors.getDynamicTextColor()),),
               // value: controller.selectedStation.value,
                items: createDropdownMenuItems(controller),
                // onChanged:(item){controller.onSelectMenuItem(item!);},
                onChanged: (value)=> controller.apiService,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
List<DropdownMenuItem<Map>> createDropdownMenuItems(DashboardController controller){
  List<DropdownMenuItem<Map>> list=[];
  controller.stations.value.forEach((station) {
    DropdownMenuItem<Map> widget=DropdownMenuItem<Map>(
      value: station,
      child: Text(station['name']),
    );
    list.add(widget);
  });
  return list;
}


class GridDemandChartPage extends GetView<DashboardController>{

  @override
  Widget build(BuildContext context) {
    context.theme;
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
    Container(

    padding: const EdgeInsets.fromLTRB(3, 3, 3, 3),
    child: Text("Hourly Generation", style: AppTheme.cardTitleStyle(),),

    ),
      Container(
        height: 180,
        decoration: AppTheme.boxDecorationStyle(),
        child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                      padding: EdgeInsets.fromLTRB(10,6,10,6),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                             /* Text(controller.peakDemand.value['value'].toString(),style: AppTheme.dynamicTextStyle(),),
                              Text(DateFormat('dd MMMyy,HH:mm').format(DateTime.fromMillisecondsSinceEpoch(controller.peakDemand.value['timestamp'])),style: Get.textTheme.caption)*/
                            ],
                          )
                          // Text("28 Mar,21",style: Get.textTheme.caption,)
                        ],
                      )
                  ),
                  Divider(height: 2,color: AppColors.getBorderColor()),
                  Expanded(
                      child: SfCartesianChart(
                          primaryXAxis: CategoryAxis(majorGridLines: const MajorGridLines(width: 0),),
                          primaryYAxis: NumericAxis(isVisible: false,),
                          plotAreaBorderWidth: 0,
                          // palette: AppColors.circular_colors,
                          series: <ChartSeries<TimeValueObject, String>>[
                            ColumnSeries<TimeValueObject, String>(

                                dataSource: controller.statistics.value,
                                xValueMapper: (timevalueObject,index)=>DateFormat('MMM,dd').format(timevalueObject.timestamp),
                                yValueMapper: (timevalueObject,index)=> timevalueObject.value,
                                pointColorMapper: (data,index)=>AppColors.circular_colors[index],
                                name: 'Grid Demand',
                               // dataLabelSettings: DataLabelSettings(isVisible: true,angle: controller.selectedType.value=='Hourly' ? 270 : 0)
                            ),
                          ]
                      )
                  ),

                ]
            ),
      ) ]  );

  }

}
Widget createSecondRow(DashboardController controller){
  return Container(
      child:StaggeredGridView.count(
        crossAxisCount: 2,
        shrinkWrap: true,
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
        padding: EdgeInsets.fromLTRB(3,3,3,3),
        physics: NeverScrollableScrollPhysics(),
        staggeredTiles: [StaggeredTile.fit(1),StaggeredTile.fit(1),StaggeredTile.fit(1),StaggeredTile.fit(1)],
        children: [
          createGridDemandContainer(controller),
          createTotalUnitsContainer(controller),
          createTodayEnergyContainer(controller),
          createPrRatioContainer(controller)
        ],
      )
  );
}
Widget createGridDemandContainer(DashboardController controller){
  return InkWell(
     // onTap: ()=>controller.showGridDemandChartDialog(),
      child:Container(
          padding: EdgeInsets.fromLTRB(10,5,10,10),
          height: 120,
          // margin: EdgeInsets.fromLTRB(3, 3, 3, 3),
          decoration: AppTheme.boxDecorationStyle(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text("Generation",style: AppTheme.cardTitleStyle()),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                // crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SvgPicture.asset('assets/generation.svg',color: AppColors.getThemeColor(),width: 45.00),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      /*AnimatedFlipCounter(
                          value:controller.gridDemand.value.toDouble(),
                          textStyle: TextStyle(fontSize: 23, fontWeight: FontWeight.bold,letterSpacing: -2,color:AppColors.getDynamicTextColor())
                      ),*/
                      Text('MW',style: Get.textTheme.caption,)
                    ],)
                ],
              )
            ],
          )
      )
  );
}
Widget createTotalUnitsContainer(DashboardController controller){
  return InkWell(
    //  onTap: ()=>controller.showEnergyChartDialog(),
      child:Container(
          padding: EdgeInsets.fromLTRB(10,7,10,10),
          height: 120,
          // margin: EdgeInsets.fromLTRB(3, 3, 3, 3),
          decoration: AppTheme.boxDecorationStyle(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text("Total Units",style: AppTheme.cardTitleStyle()),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                // crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SvgPicture.asset('assets/totalunits.svg',color: AppColors.getThemeColor(),width: 45.00),
                  // Icon(Icons.lightbulb_outline,size: 80, ),
                  /*CircleAvatar(
                    backgroundColor:Colors.black12,
                    child: Icon(Icons.bar_chart,color: Colors.brown,),
                    radius: 30,
                  ),*/
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                    /*  AnimatedFlipCounter(
                        value:controller.energy.value.toDouble(),
                        textStyle: TextStyle(fontSize: 23, fontWeight: FontWeight.bold,letterSpacing: -2,color:AppColors.getDynamicTextColor()),
                        fractionDigits: 3,
                      ),*/
                      Text('KWH',style: Get.textTheme.caption,)
                    ],)
                ],
              )
            ],
          )
      )
  );
}
Widget createTodayEnergyContainer(DashboardController controller){
  return InkWell(
     // onTap: ()=>controller.showCityDemandChartDialog(),
      child:Container(
          padding: EdgeInsets.fromLTRB(10,5,10,10),
          height:120,
          // margin: EdgeInsets.fromLTRB(3, 3, 3, 3),
          decoration: AppTheme.boxDecorationStyle(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text("Bus Voltage",style: AppTheme.cardTitleStyle()),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                // crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SvgPicture.asset('assets/todayenergy.svg',color: AppColors.getThemeColor(),width: 45.00,),
                  // Icon(Icons.location_city_outlined,size: 75, ),
                  /*CircleAvatar(
                    backgroundColor:Colors.black12,
                    child: Icon(Icons.bar_chart,color: Colors.brown,),
                    radius: 30,
                  ),*/
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                     /* AnimatedFlipCounter(
                          value:controller.cityDemand.value.toDouble(),
                          textStyle: TextStyle(fontSize: 23, fontWeight: FontWeight.bold,letterSpacing: -2,color:AppColors.getDynamicTextColor())
                      ),*/
                      Text('KWH',style: Get.textTheme.caption,)
                    ],)
                ],
              )
            ],
          )
      )
  );
}
Widget createPrRatioContainer(DashboardController controller){
  return InkWell(
     // onTap: ()=>controller.showCityDemandChartDialog(),
      child:Container(
          padding: EdgeInsets.fromLTRB(10,5,10,10),
          height:120,
          // margin: EdgeInsets.fromLTRB(3, 3, 3, 3),
          decoration: AppTheme.boxDecorationStyle(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text("PR Ratio",style: AppTheme.cardTitleStyle()),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                // crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SvgPicture.asset('assets/images/line-chart.svg',color: AppColors.getThemeColor(),width: 45.00,),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                     /* AnimatedFlipCounter(
                          value:controller.cityDemand.value.toDouble(),
                          textStyle: TextStyle(fontSize: 23, fontWeight: FontWeight.bold,letterSpacing: -2,color:AppColors.getDynamicTextColor())
                      ),*/
                      Text('%',style: Get.textTheme.caption,)
                    ],)
                ],
              )
            ],
          )
      )
  );
}



Widget createThirdRow(DashboardController controller){
  return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
          Container(
            padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                child: Text("Genaration Statistics", style: AppTheme.cardTitleStyle(),),
          ),
        Container(
            child:StaggeredGridView.count(
              crossAxisCount: 3,
                shrinkWrap: true,
                crossAxisSpacing: 5,
                mainAxisSpacing: 5,
                padding: EdgeInsets.fromLTRB(3,3,3,3),
                physics: NeverScrollableScrollPhysics(),
                staggeredTiles: [StaggeredTile.fit(1),StaggeredTile.fit(1),StaggeredTile.fit(1),],
                children: [
                  createDailyContainer(controller,),
                  createMonthlyContainer(controller),
                  createYearlyContainer(controller),

        ],
      )
  )]
  );

}
Widget createDailyContainer(DashboardController controller){
  return InkWell(
     onTap: ()=>controller.showDailyChartDialog(),
      child:Container(
          padding: EdgeInsets.fromLTRB(10,5,10,10),
          height: 80,
          // margin: EdgeInsets.fromLTRB(3, 3, 3, 3),
          decoration: AppTheme.boxDecorationStyle(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text("Daily",style: AppTheme.cardTitleStyle()),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                // crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text('38',style:TextStyle(fontSize: 23, fontWeight: FontWeight.bold,letterSpacing: -2,color:AppColors.getDynamicTextColor()),),

                  // SvgPicture.asset('assets/generation.svg',color: AppColors.getThemeColor(),width: 40,height: 60,),
                  // Icon(Icons.grid_off_rounded,size: 75, ),
                  /*CircleAvatar(
                    backgroundColor:Colors.black12,
                    child: Icon(Icons.bar_chart,color: Colors.brown,),
                    radius: 30,
                  ),*/
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      /*AnimatedFlipCounter(
                          value:controller.gridDemand.value.toDouble(),
                          textStyle: TextStyle(fontSize: 23, fontWeight: FontWeight.bold,letterSpacing: -2,color:AppColors.getDynamicTextColor())
                      ),*/
                      Text('MW',style: Get.textTheme.caption,)
                    ],)
                ],
              )
            ],
          )
      )
  );
}
Widget createMonthlyContainer(DashboardController controller){
  return InkWell(
     onTap: ()=>controller.showMonthlyChartDialog(),
      child:Container(
          padding: EdgeInsets.fromLTRB(10,5,10,10),
          height: 80,
          // margin: EdgeInsets.fromLTRB(3, 3, 3, 3),
          decoration: AppTheme.boxDecorationStyle(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text("Monthly",style: AppTheme.cardTitleStyle()),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                // crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text('86',style:TextStyle(fontSize: 23, fontWeight: FontWeight.bold,letterSpacing: -2,color:AppColors.getDynamicTextColor()),),

                  // SvgPicture.asset('assets/generation.svg',color: AppColors.getThemeColor(),width: 40,height: 60,),
                  // Icon(Icons.grid_off_rounded,size: 75, ),
                  /*CircleAvatar(
                    backgroundColor:Colors.black12,
                    child: Icon(Icons.bar_chart,color: Colors.brown,),
                    radius: 30,
                  ),*/
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      /*AnimatedFlipCounter(
                          value:controller.gridDemand.value.toDouble(),
                          textStyle: TextStyle(fontSize: 23, fontWeight: FontWeight.bold,letterSpacing: -2,color:AppColors.getDynamicTextColor())
                      ),*/
                      Text('MW',style: Get.textTheme.caption,)
                    ],)
                ],
              )
            ],
          )
      )
  );
}
Widget createYearlyContainer(DashboardController controller){
  return InkWell(
     onTap: ()=>controller.showYearlyChartDialog(),
      child:Container(
          padding: EdgeInsets.fromLTRB(10,5,10,10),
          height: 80,
          // margin: EdgeInsets.fromLTRB(3, 3, 3, 3),
          decoration: AppTheme.boxDecorationStyle(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text("Yearly",style: AppTheme.cardTitleStyle()),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
               //  crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text('225',style:TextStyle(fontSize: 23, fontWeight: FontWeight.bold,letterSpacing: -2,color:AppColors.getDynamicTextColor()),),

                  //SvgPicture.asset('assets/generation.svg',color: AppColors.getThemeColor(),width: 40,height: 60,),
                  // Icon(Icons.grid_off_rounded,size: 75, ),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                   // crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      /*AnimatedFlipCounter(
                          value:controller.gridDemand.value.toDouble(),
                          textStyle: TextStyle(fontSize: 23, fontWeight: FontWeight.bold,letterSpacing: -2,color:AppColors.getDynamicTextColor())
                      ),*/
                      Text('MW',style: Get.textTheme.caption,)
                    ],)
                ],
              )
            ],
          )
      )
  );
}

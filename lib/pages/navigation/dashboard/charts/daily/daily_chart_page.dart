import 'package:amcmobile/domain/time_value_object.dart';
import 'package:amcmobile/themes/app_colors.dart';
import 'package:amcmobile/themes/app_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_notifier.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:get/get_utils/src/extensions/context_extensions.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'daily_chart_controller.dart';

class DailyChartPage extends GetView<DailyChartController>{
  @override
  Widget build(BuildContext context) {
    context.theme;
    return Container(
      height: 300,
      decoration: AppTheme.boxDecorationStyle(),
      child: controller.obx(
            (state) =>Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.all(15),
              child: Text('Text',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
            ),
            Divider(height: 5,color: AppColors.getBorderColor()),
            Expanded(
              child: SfCartesianChart(
                  primaryYAxis: NumericAxis(rangePadding: ChartRangePadding.round, interactiveTooltip: InteractiveTooltip(enable: true),),
                  primaryXAxis: DateTimeAxis(
                    dateFormat: DateFormat('HH:mm'),
                    interval: 180,
                    intervalType: DateTimeIntervalType.minutes,
                    //interactiveTooltip: InteractiveTooltip(enable: true), // Enables the crosshair tooltip
                  ),
                  plotAreaBorderWidth: 0,
                  trackballBehavior: TrackballBehavior(
                      enable: true,
                      activationMode: ActivationMode.singleTap,
                      // tooltipDisplayMode: TrackballDisplayMode.groupAllPoints,
                      tooltipSettings: InteractiveTooltip(
                        // Formatting trackball tooltip text
                        format: 'point.x Hrs \n      point.y MW',
                        decimalPlaces:0,

                      )
                  ),
                  //tooltipBehavior: TooltipBehavior(enable: true),
                  legend: Legend(isVisible: true,position: LegendPosition.bottom,toggleSeriesVisibility: true ),
                  series: <ChartSeries>[
                    // Renders line chart
                    LineSeries<TimeValueObject,DateTime>(
                        name: 'Actual',
                        dataSource: controller.actual.value,
                        xValueMapper: (data,index) => data.timestamp,
                        yValueMapper: (data, index) => data.value,
                        color: Colors.green
                    ),
                    LineSeries<TimeValueObject,DateTime>(
                        name: 'Schedule',
                        dataSource: controller.schedule.value,
                        xValueMapper: (data,index) => data.timestamp,
                        yValueMapper: (data, index) => data.value,
                        color: Colors.red
                    )
                  ]
              ),
            ),
            SizedBox(height: 10,)
          ]
      ),
      /*    onLoading: loading(),
          onError: (error){
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(error!),
                SizedBox(height: 10,),
                InkWell(
                  child: Icon(Icons.refresh),
                  onTap: ()=>controller.getData(),
                )
              ],
            );
          }*/
      ) );

  }

}
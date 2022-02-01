
import 'package:amcmobile/domain/time_value_object.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class YearlyChartController extends GetxController with StateMixin<String> {

  final String currentRoute="/navigation/dashboard/daily/";

  List types=['Daily','Monthly','Yearly'];
  var selectedType='Yearly';
  var actual=<TimeValueObject>[].obs;
  var schedule=<TimeValueObject>[].obs;
  String selectedDaily='Yearly';




}
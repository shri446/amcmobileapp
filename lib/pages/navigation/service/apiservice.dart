import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:amcmobile/pages/navigation/menubar/change_theme/change_theme_page.dart';
import 'package:amcmobile/pages/navigation/service/oauth2_dio.dart';
import 'package:amcmobile/utils/constants.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:network_info_plus/network_info_plus.dart';


class ApiService extends GetxService {
  static ApiService get to => Get.find();


  final GetStorage storage=GetStorage();
//  final String baseUrl = "http://192.168.0.199:8080";
  var networkStatus=false.obs;
  late OAuth oauthClient;



  getOauthToken() {
    Dio dio =Dio();
   /* final requestHeader = {'Authorization': 'Basic '+base64.encode(utf8.encode('$clientId:$clientSecret'))};
    dio.post(baseUrl,)   .then((response) => {
    print(response)*/

    String authorizationHeader=stringToBase64.encode('$clientId:$clientSecret');
     dio.post("http://192.168.100.17:8082/oauth/token",  data: {'grant_type':'password','username':'srikanth','password':'srikanth123'}, options: Options( headers: {'Content-Type':'application/X-WWW-form-urlencoded','Authorization':"Basic$authorizationHeader"})).then((response) => {
       print(response)
     });
  }
  
  ainitOAuthClient(){
    oauthClient=OAuth(
        tokenUrl: "$baseUrl/oauth/token",
        clientId: clientId,
        clientSecret: clientSecret);
  }

var dio = Dio();
  ApiService() {
  Dio  dio = Dio(BaseOptions(
        baseUrl: baseUrl,
        headers: {
          Headers.acceptHeader:ContentType.json,
        },
        connectTimeout: 5 * 1000,
        receiveTimeout: 3 * 1000,
        receiveDataWhenStatusError: true,
        contentType: Headers.jsonContentType,
        responseType: ResponseType.json
    )
    );
  }

  @override
  void onInit() {

    getAllStations();

  }
  getUsername(){
    return storage.read("username") ?? "";
  }
  Future getAllDevices() {
    return dio.get(baseUrl + "/oauth/device");
  }
  Future getAllUsers() {
    return dio.get(baseUrl + "/oauth/users");
  }
  Future getAlllogins() {
    return dio.get(baseUrl + "/loginhistory");
  }
  Future getAllStations() {
    return dio.get(baseUrl + "/stations");
  }
  Future servertime() {
    return dio.get(baseUrl + "/servertime");
  }
 /* Future  {
    return dio.get(baseUrl + "/events");
  }*/
  Future getAllEvents(String stationId , String type){
    return dio.get(baseUrl + "/events",queryParameters: {'stationId':stationId,'type': "Events"});
  }

   Future getPoints(String stationId , String type){
    return dio.get(baseUrl + "/station",queryParameters: {'stationId':stationId,'type': type});
  }
  Future getSld(String stationId , String type){
    return dio.get(baseUrl + "/drawings",queryParameters: {'stationId':stationId,'type': type});
  }
  Future getTrends(String stationId,String type) {
    return dio.get(baseUrl + "/adDaily",
        queryParameters: {'stationId': stationId, 'type': "aDaily"});
  }

  Future getDataFromAmcServer(){
    return dio.get(baseUrl +"");
   }
late Map<String,dynamic> authenticatedMenuItems1={
  'Menu':()=>main(),
  'App Theme':()=>_changeTheme(),
};
  main(){
    Get.toNamed("/navpage");
  }

  late Map<String,dynamic> authenticatedMenuItems={
    'App Theme':()=>_changeTheme(),
    'Profile':()=>_showProfileInfo(),
    'Logout':()=>logout(),
  };
  _changeTheme(){
    Get.bottomSheet(
    ChangeThemePage(),
      barrierColor: Colors.transparent,
      useRootNavigator: true,
    );

  }
  _showProfileInfo(){
    Get.defaultDialog(
      title: "Profile",
      barrierDismissible: true,
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          CircleAvatar(child: Icon(Icons.person,size: 40,),),
          Text('Logged in as '),
          Text("srikanth",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.orange),)
        ],
      ),
    );
  }

  logout()  {
    log("logging out..... ");
    Get.toNamed("/loginpage");
  }

  /*goToLoginPage() async {
    //Get.rootDelegate.popRoute();
    // storage.erase();
    Get.rootDelegate.offNamed("/Loginpage");
  }*/

}





import 'dart:developer';
import 'dart:io';
import 'package:amcmobile/pages/menubar/change_password/change_password_controller.dart';
import 'package:amcmobile/pages/menubar/change_password/change_password_page.dart';
import 'package:amcmobile/pages/menubar/change_theme/change_theme_page.dart';
import 'package:amcmobile/pages/menubar/profile/profile_controller.dart';
import 'package:amcmobile/pages/menubar/profile/profile_page.dart';
import 'package:amcmobile/pages/navigation/widget/appbar_widgets.dart';
import 'package:amcmobile/service/amc_api_error_handler.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'amc_storage.dart';
import 'oauth2_dio.dart';

class ApiService1 extends GetxService{
  static ApiService1 get to => Get.find();
  //test

  // final isLoggedIn = false.obs;
  // bool get isLoggedInValue => isLoggedIn.value;

  final GetStorage storage=GetStorage();
  final String baseUrl="http://192.168.98.134:8080";


  // bool authenticatedUser;
  late Dio dio;
  late OAuth _oauthClient;

  // SldcApiService({required this.authenticatedUser});


  @override
  void onInit() {
    dio=Dio(BaseOptions(
        baseUrl: baseUrl,
        headers: {Headers.acceptHeader: ContentType.json },
        contentType: Headers.jsonContentType,
        responseType: ResponseType.json,
        receiveDataWhenStatusError: true,
        connectTimeout: 5*1000, // 5 seconds
        receiveTimeout: 3*1000 // 3 seconds
    ));
    // super.onReady();
  }


  addAuthenticationInterceptors(){
    final String tokenUrl = baseUrl + "/oauth/token";
    final String clientId = "gridx";
    final String clientSecret = "gridx-secret";

    _oauthClient = OAuth(tokenUrl: tokenUrl,
        clientId: clientId,
        clientSecret: clientSecret,
        storage: OAuthSecureStorage());
    dio.interceptors.add(BearerInterceptor(_oauthClient));
    dio.interceptors.add(AmcApiErrorHandler());
  }

  Future<OAuthToken> authenticate(String username, String password)  {
    addAuthenticationInterceptors();
    return _oauthClient.requestTokenAndSave(
        PasswordGrant(username: username, password: password)
    );
  }

  void onSelectAppbarMenuItem(String value){
    if(value=='Login'){
      // Get.offAndToNamed("/login");

      Get.rootDelegate.offNamed("/navigation/loginpage");
    }else if(value=='Logout'){
      logout();
    }else if(value=='Profile'){
      showSnackBar("TODO", "Under Development");
    }
  }
  bool isAuthenticated(){
    return storage.hasData("accessToken");
  }
/*
  @override
  void onInit() {

    getAllStations();

  }*/
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
    return dio.get(baseUrl + "/oauth/loginhistory");
  }
  Future getAllStations() {
    return dio.get(baseUrl + "/oauth/stations");
  }
  Future servertime() {
    return dio.get(baseUrl + "/servertime");
  }

  Future getAllEvents(String stationId , String type){
    return dio.get(baseUrl + "/oauth/events",queryParameters: {'stationId':stationId,'type': "Events"});
  }

  Future getPoints(String stationId , String type){
    return dio.get(baseUrl + "/oauth/station",queryParameters: {'stationId':stationId,'type': type});
  }
  Future getSld(String stationId , String type){
    return dio.get(baseUrl + "/oauth/drawings",queryParameters: {'stationId':stationId,'type': type});
  }
  Future getTrends(String stationId,String type) {
    return dio.get(baseUrl + "/oauth/adDaily",
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
    Get.toNamed("/rootpage");
  }

  late Map<String,dynamic> authenticatedMenuItems={
    'App Theme':()=>_changeTheme(),
    //'Profile':()=>_showProfileInfo(),
    'Logout':()=>logout(),
  };

  _drawer(){
    Get.toNamed("/changetheme");
  }

  _changeTheme(){
    Get.bottomSheet(
      ChangeThemePage(),
      barrierColor: Colors.transparent,
      useRootNavigator: true,);


  }
 /* _showProfileInfo(){
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
  }*/

  logout()  {
    log("logging out..... ");
    Get.toNamed("/loginpage");
  }
}

showProfileInfo() {
  Get.lazyPut(() => ProfileController());
  Get.defaultDialog(
    title: "Profile",
    // textConfirm: "Save",
    barrierDismissible: true,
    content: ProfilePage(),
    radius: 20,
    //onConfirm: () => Get.find<ProfileController>().saveProfileDetails(),
  ).then((value) => Get.delete<ProfileController>(force: true));
}

changePassword() {
  Get.lazyPut(() => ChangePasswordController());
  Get.defaultDialog(
    title: "Change Password",
    textConfirm: "Confirm",
    textCancel: "Cancel",
    barrierDismissible: false,
    content: ChangePasswordPage(),
    radius: 20,
    onCancel: () => Get.delete<ChangePasswordController>(force: true),
    onWillPop: () => Get.delete<ChangePasswordController>(force: true),
    onConfirm: () => Get.find<ChangePasswordController>().changePassword(),
  ).then((value) => Get.delete<ChangePasswordController>(force: true));
}

showAlertDialog(){
  return AlertDialog(
    title: Text("Alert"),
    content: Text("Are you sure want to exit"),
    actions: [
      ElevatedButton(
        child: Text('sign out'),
        onPressed: () => {/*Navigator.of(context).pop(true);*/},
      ),
      ElevatedButton(
          child: Text('cancel'),
          onPressed: () => {/*Navigator.of(context).pop(false);*/}
      ),
    ],

  );
}



late OAuth oauthClient;
Future postRequest1(String path, Map<String, String> params, StateMixin statemixin) {
  return oauthClient.dio!.post(
      path, queryParameters: params.isNotEmpty ? params : {},
      options: Options(headers: {"Authorization": "Bearer " + getToken()},))
      .whenComplete(() =>
      statemixin.change("Success", status: RxStatus.success()))
      .onError((error, stackTrace) {
    String message = 'Error occured, retry again';
    if (error is DioError) {
      var dioError = error as DioError;
      if (dioError.error is SocketException) {
        message = "Check Internet connection";
      } else if (dioError.type == DioErrorType.connectTimeout) {
        message = 'Connection timed out, retry';
      }else if (dioError.type == DioErrorType.response) {
        int? status = dioError.response?.statusCode;
        print(dioError.response);
        if (status == 401) { //invalid access token
         // refreshAccessToken();
        }
      }
    }
    statemixin.change("Failed", status: RxStatus.error(message));
    return Future.error(error!, stackTrace);
  });
  /*.catchError((error,stackTrace){
            statemixin.change("Failed",status: RxStatus.error("Error occured, retry again"));
            return Future.value(error!);
        });*/
}
getToken() {
  return storage.read("accessToken") ?? "";
}

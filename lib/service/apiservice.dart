/*
import 'dart:io';

import 'package:flutter_first_project/services/authenticated_api_service.dart';
import 'package:flutter_first_project/services/unathenticated_api_service.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:stomp_dart_client/stomp_config.dart';

class ApiService extends GetxService{

  var networkStatus=false.obs;
  var initialRoute='';

  bool isAuthenticated(){
    return GetStorage().hasData("accessToken");
  }


  setMethod(Function() subscribe){
    if(isAuthenticated()){
      Get.find<AuthenticatedApiService>().setMethod(subscribe);
    }else{
      Get.find<UnAuthenticatedApiService>().setMethod(subscribe);
    }
  }

  setParentMethod(Function() subscribe){
    if(isAuthenticated()){
      AuthenticatedApiService sldcApiService=Get.find<AuthenticatedApiService>();
      sldcApiService.setParentMethod(subscribe);
    }else{
      UnAuthenticatedApiService unAuthenticatedApiService=Get.find<UnAuthenticatedApiService>();
      unAuthenticatedApiService.setParentMethod(subscribe);
    }
  }

  setExecutionMethodWithParentMethod(){
    if(isAuthenticated()){
      AuthenticatedApiService sldcApiService=Get.find<AuthenticatedApiService>();
      Get.find<AuthenticatedApiService>().setMethod(sldcApiService.parentMethod!);
    }else{
      UnAuthenticatedApiService unAuthenticatedApiService=Get.find<UnAuthenticatedApiService>();
      unAuthenticatedApiService.setMethod(unAuthenticatedApiService.parentMethod!);
    }
  }

  subscribe(String subscriptionUrl,StompFrameCallback callback){
    if(isAuthenticated()){
      return Get.find<AuthenticatedApiService>().subscribe(subscriptionUrl, (frame)=>callback(frame));
    }else{
      return Get.find<UnAuthenticatedApiService>().subscribe(subscriptionUrl, (frame)=>callback(frame));
    }
  }

  bool send(String url) {
    if(isAuthenticated()){
      return Get.find<AuthenticatedApiService>().send(url);
    }else{
      return Get.find<UnAuthenticatedApiService>().send(url+'_');
    }
  }

  Future<bool> internetConnectivity() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      }
    } on SocketException catch (_) {
      return false;
    }
    return false;
  }
}*/

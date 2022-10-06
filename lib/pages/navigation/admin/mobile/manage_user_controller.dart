import 'dart:io';

import 'package:amcmobile/service/authenticated_api_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class ManageUserController extends GetxController with StateMixin<String>{
  AuthenticatedApiService apiService=Get.find<AuthenticatedApiService>();

  var errorText=''.obs;
  var name=''.obs;
  var userId=''.obs;
  var position=''.obs;
  var mobile=''.obs;

  @override
  void onInit() {
    print("Opened "+this.runtimeType.toString());
  }



  onChangeName(String val){
    name.value=val;
  }

  onChangeUserID(String val){
    userId.value=val;
  }

  onChangePosition(String val){
    position.value=val;
  }

  onChangeMobile(String val){
    mobile.value=val;
  }

  addUser(){
 /*   if(name.value.isEmpty || userId.value.isEmpty || position.value.isEmpty || mobile.value.isEmpty){
      errorText.value="Fields Cannot be empty";
    }else if(!isValidUserName(mobile.value)){
      errorText.value="Invalid mobile number";
    }else {
      sldcApiService.postRequest1("/stomp_protected/add_user", {'name': name.value.trim(),'userId':userId.value,'position':position.value, 'mobile':mobile.value},this).then((response) {
        if(response.data['status']=="Success") {
          Get.back();
          deleteController();
          Get.defaultDialog(
              title: "Success",
              barrierDismissible: true,
              content: Text(response.data['message'],style: TextStyle(color: Colors.green.shade800),)
          );
        }else{
          errorText.value=response.data['message'];
        }
      }).onError((error, stackTrace) {
        if(error is DioError) {
          DioError dioError = error as DioError;
          errorText.value = dioError.response != null ? dioError.response!.data['error'] : dioError.error.toString();

          if (dioError.error is SocketException) {
            errorText.value = "Check Internet connection";
          }
        }else{
          print(error);
        }
      });
    }*/
  }

  deleteUser(String mobile){
    apiService.postRequest1("/stomp_protected/delete_user", {'mobile':mobile},this).then((response) {
        if(response.data['status']=="Success") {
          Get.back();
          deleteController();
          Get.defaultDialog(
              title: "Success",
              barrierDismissible: true,
              content: Text(response.data['message'],style: TextStyle(color: Colors.green.shade800),)
          );
        }else{
          errorText.value=response.data['message'];
        }
      }).onError((error, stackTrace) {
        if(error is DioError) {
          DioError dioError = error as DioError;
          errorText.value = dioError.response != null ? dioError.response!.data['error'] : dioError.error.toString();

          if (dioError.error is SocketException) {
            errorText.value = "Check Internet connection";
          }
        }else{
          print(error);
        }
      });
  }

  deleteController(){
    Get.delete<ManageUserController>(force: true);
  }


}
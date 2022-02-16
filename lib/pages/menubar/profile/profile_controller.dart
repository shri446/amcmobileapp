import 'dart:collection';
import 'dart:io';

import 'package:amcmobile/service/authenticated_apiservice.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';


class ProfileController extends GetxController with StateMixin<String>{
  ApiService1 apiService1=Get.find<ApiService1>();
  GetStorage storage=GetStorage();

  var errorText=''.obs;
  var name=''.obs;
  var position=''.obs;
  var email=''.obs;

  @override
  void onInit() {
    print("Opened "+this.runtimeType.toString());
    Map<String,dynamic> map=storage.read("profileInfo") ?? new HashMap();

    name.value=map['name'] ?? '';
    position.value=map['position'] ?? '';
    email.value=map['email'] ?? '';
  }



  /*saveProfileDetails(){
    if(name.value.isEmpty || mobile.value.isEmpty || email.value.isEmpty){
      errorText.value="Fields Cannot be empty";
    }else if(GetUtils.isPhoneNumber(mobile.value)){
      errorText.value="Invalid mobile number";
    }else if(GetUtils.isEmail(email.value)){
      errorText.value="Invalid email";
    }else {
      authenticatedApiService.postRequest1("/stomp_protected/update_profile", {'name': name.value.trim(),'mobile':mobile.value,'email':email.value},this).then((response) {
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
  }*/

  deleteController(){
    Get.delete<ProfileController>(force: true);
  }


}
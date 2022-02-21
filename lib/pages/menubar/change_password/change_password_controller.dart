import 'dart:io';

import 'package:get/get.dart';

import '../../../service/authenticated_api_service.dart';




class ChangePasswordController extends GetxController with StateMixin<String>{
  AuthenticatedApiService authenticatedApiService=Get.find<AuthenticatedApiService>();

  var errorText=''.obs;
  var newPassword=''.obs;
  var confirmPassword=''.obs;

  @override
  void onInit() {
    print("Opened "+this.runtimeType.toString());
  }

  onChangeNewPassword(String val){
    newPassword.value=val;
  }

  onChangeConfirmPassword(String val){
    confirmPassword.value=val;
  }
changePassword(){}
 /* changePassword(){
    if(newPassword.value.isEmpty || confirmPassword.value.isEmpty){
      errorText.value="Fields Cannot be empty";
    }else if(newPassword.value!=confirmPassword.value){
      errorText.value="Password doesn't match";
    }else {
      AuthenticatedApiService.postRequest1("/stomp_protected/change_password", {'newpassword': newPassword.value.trim()},this).then((response) {
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
    Get.delete<ChangePasswordController>(force: true);
  }


}
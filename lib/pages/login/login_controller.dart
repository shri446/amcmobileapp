import 'dart:io';

import 'package:amcmobile/service/authenticated_api_service.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../navigation/widget/appbar_widgets.dart';

class LoginController extends GetxController {
  final AuthenticatedApiService authenticatedApiService = Get.find<AuthenticatedApiService>();

  final userName = ''.obs;
  final password = ''.obs;
  final errorText = ''.obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    print("Opened " + this.runtimeType.toString());
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  onChangeUsername(String  name){
    userName.value=name;
  }

  onChangePassword(String pwd){
    password.value=pwd;
  }

  login() {
    if (userName.isEmpty) {
      errorText.value = "Username cannot empty";
    } else if (password.isEmpty) {
      errorText.value = "Password cannot be empty";
    } else {
      Connectivity().checkConnectivity().then((result) {
        bool status = (result == ConnectivityResult.none) ? false : true;
        if (status) {
          var dialog = Get.dialog(showLoginProgress(), barrierDismissible: false);
              authenticatedApiService.storage.erase();
              authenticatedApiService.login(userName.value, password.value).then((token) async {
                int expirationTime = DateTime.fromMillisecondsSinceEpoch(authenticatedApiService.storage.read("expiration")).difference(DateTime.now()).inSeconds;
                authenticatedApiService.storage.write("tokenValidityTime", (expirationTime - expirationTime / 5).toInt());
                authenticatedApiService.storage.write("username", userName.value);

                Get.back(); //rootDelegate.popHistory();
                // authenticatedApiService.initialRoute = '/navigation';
                Get.offNamed("/rootpage");
                //authenticatedApiService.saveProfileInfoDialog();
                //authenticatedApiService.disconnectFromStompServer();
                authenticatedApiService.initializeStompClientAndConnect();
                authenticatedApiService.listenForNetworkChanges();
            }).onError((error, stackTrace) {
              Get.back();
              if (error is DioError) {
                DioError dioError = error as DioError;
                errorText.value = dioError.response != null ? dioError.response!
                    .data['error_description'] : dioError.error.toString();

                /*if(errorText.value=='invalid_grant'){
                  errorText.value='Bad Credentials';
                }*/
                if (dioError.error is SocketException) {
                  errorText.value = "Please try again after sometime";
                }
              } else {
                print(error);
              }
            });
          } else {
            errorText.value = "Check Internet connection";
          }
      });
    }
  }

}


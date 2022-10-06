import 'dart:convert';
import 'dart:developer';

import 'package:amcmobile/pages/navigation/admin/mobile/manage_user_controller.dart';
import 'package:amcmobile/pages/navigation/admin/mobile/user_add_page.dart';
import 'package:amcmobile/service/authenticated_api_service.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';


class MobileUsersController extends GetxController {

  final AuthenticatedApiService authenticatedApiService=Get.find<AuthenticatedApiService>();
  final RefreshController refreshController=RefreshController(initialRefresh: false,);

  // final String title='Mobile';
  var users={}.obs;
  var timestamp=0.obs;


  dynamic unsubscribeFn;
  String currentRoute="/navigation/admin/mobile-users";
  late String subscriptionUrl;

  @override
  void onInit() {
    subscriptionUrl='/user/'+authenticatedApiService.getUsername()+currentRoute;
    super.onInit();

  } // String currentRoute=Get.rootDelegate.currentConfiguration!.location!+"/";


  @override
  void onReady() {
    print("Opened "+this.runtimeType.toString());
    super.onReady();
  }

  @override
  void onClose() {
    log('Unsubscribing '+subscriptionUrl);
    unsubscribeFn?.call();
    refreshController.dispose();
    super.onClose();
  }

  clearUsers(){
    users.value={};
    log('Unsubscribing '+subscriptionUrl);
    unsubscribeFn?.call();
  }

  init(){
    authenticatedApiService.setMethod(subscribe);
    getData();
  }

  subscribe()  {
    users.value={};
    if(authenticatedApiService.stompClient!.connected) {
      unsubscribeFn = authenticatedApiService.stompClient?.subscribe(destination: subscriptionUrl, callback: (frame) {
        // print(frame.body);
        Map<String,dynamic> usersMap =jsonDecode(frame.body!);
        String action=usersMap['Action'];
        if(action=='onLoad'){  //initially load all users
          users.value=usersMap['Users'];
        }else if(action=='onAdd'){
          users.addEntries([MapEntry(usersMap['Mobile'], usersMap['UserData'])]);
          //users.update(key, (value) => null)
        }else if(action=='onDelete'){
           users.remove(usersMap['Mobile']);
        }else if(action=='onUpdate'){// when user disconnected / connected
          usersMap['Users'].entries.forEach((entry) {
            Map detailMap=users.value[entry.key];
            detailMap['name']=entry.value['name'];
            detailMap['ipAddress']=entry.value['ipAddress'];
            detailMap['status']=entry.value['status'];
          });
          users.refresh();
        }

        if(refreshController.isRefresh){
          refreshController.refreshCompleted();
        }


      });
      getData();
    }
  }



  getData() {
    /*authenticatedApiService.postRequest('/stomp_protected/mobile-users', {}).then((response) {
      if(response.statusCode==200) {
        print(response.data);
        users.value = response.data ?? {};
        // timestamp.value=response.data['Timestamp'] ?? 0;
        if(refreshController.isRefresh){
          refreshController.refreshCompleted();
        }
      }
    }).onError((error, stackTrace) {
      log(error);
      Get.back();
      refreshController.refreshFailed();
    });*/
    if(authenticatedApiService.stompClient!.connected) {
      authenticatedApiService.stompClient!.send(destination: currentRoute);

    }else{
      refreshController.refreshFailed();
    }
  }

  Color getUserStatusColor(String status){
    //String status=users.value[index]['status'];
    if(status=='ONLINE'){
      return Colors.green;
    }else if(status=='OFFLINE'){
      return Colors.red;
    }else{
      return Colors.grey;
    }
  }

  showAddUserDialog(){
    Get.lazyPut(() => ManageUserController());
    Get.defaultDialog(
      title: "Add User",
      textConfirm: "Save",
      textCancel: "Cancel",
      barrierDismissible: false,
      content: UserAddPage(),
      radius: 20,
      onCancel: () => Get.delete<ManageUserController>(force: true),
      onWillPop: () => Get.delete<ManageUserController>(force: true),
      onConfirm: () => Get.find<ManageUserController>().addUser(),
    ).then((value) => Get.delete<ManageUserController>(force: true));
  }

  showDeleteUserDialog(Map userMap){
    Get.lazyPut(() => ManageUserController());
    Get.defaultDialog(
      title: "Delete User",
      textConfirm: "Delete",
      textCancel: "Cancel",
      barrierDismissible: false,
      content: Text("Are you sure want to Delete?"+userMap['name']),
      radius: 20,
      onCancel: () => Get.delete<ManageUserController>(force: true),
      onWillPop: () => Get.delete<ManageUserController>(force: true),
      onConfirm: () => Get.find<ManageUserController>().deleteUser(userMap['user']),
    ).then((value) => Get.delete<ManageUserController>(force: true));
  }

  forceLogout(String user,String status){
      Get.back();
      if(authenticatedApiService.stompClient!.connected) {
        authenticatedApiService.stompClient!.send(destination: "/stomp_protected/forcelogout",headers: {'username':user, 'status': status, 'application':'MOBILE'});
      }
  }
}
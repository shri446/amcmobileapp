import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';

import '/pages/menubar/change_theme/change_theme_page.dart';
import '/utils/constants.dart';
import '/utils/log.dart';
import 'api_service.dart';

class UnAuthenticatedApiService extends GetxService {

  // static SldcApiService get to => Get.find();
  final ApiService apiService =Get.find<ApiService>();
  final GetStorage storage=GetStorage();
   // var networkStatus=false.obs;
  // bool appResumed=false;
  // String initialRoute='/navigation';

  late Map<String, dynamic> menuItems={
    'Login':()=>goToLoginPage(),
    // 'Switch Theme':()=>_changeTheme(),
  };

  StompClient? stompClient;
  StreamSubscription? connectivitySubscription;

  Function()? executingMethod;
  Function()? parentMethod;

  setMethod(Function() f){
    executingMethod=f;
    if(stompClient!=null && stompClient!.connected && executingMethod!=null) {
      executingMethod!();//?.call();
    }
  }

  setParentMethod(Function() f){
    parentMethod=f;
  }

  @override
  void onInit() {

    super.onInit();
  }


  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    disconnectFromStompServer();
    if(connectivitySubscription!=null) {
      log("Removing UnAuthenticated Connectivity Listener subscription....");
      connectivitySubscription!.cancel();
      connectivitySubscription=null;
    }
    super.onClose();
  }

  listenForNetworkChanges(){
    bool first=true;
    if(connectivitySubscription==null) {
      log("Creating UnAuthenticated Listener for networkChanges....");
      connectivitySubscription = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
        //ConnectivityResult result=await Connectivity().checkConnectivity();
        if(first==false) {
          log('UnAuthenticated Connectivity Listener Status changed to =' + result.toString());
          updateNetworkStatusAndConnect(result);
        }else{
          first=false;
        }
      });
    }
  }

  checkNetworkAfterMain() async{
    ConnectivityResult result=await Connectivity().checkConnectivity();
    apiService.networkStatus.value=(result == ConnectivityResult.none) ? false : true;
    apiService.initialRoute='/navigation/statistics';

    if(apiService.networkStatus.value){
      initializeStompClientAndConnect();
    }

    listenForNetworkChanges();

  }

  checkNetworkAfter_onClick_onResumed() async{
    ConnectivityResult result=await (Connectivity().checkConnectivity());
    updateNetworkStatusAndConnect(result);

  }

  updateNetworkStatusAndConnect(ConnectivityResult result){
    apiService.networkStatus.value=(result == ConnectivityResult.none) ? false : true;
    if (apiService.networkStatus.value) {
      if(Get.rootDelegate!=null && Get.rootDelegate.currentConfiguration!=null && Get.rootDelegate.currentConfiguration!.currentPage!.name!='/login') {
        initializeStompClientAndConnect();
      }
    }else{
      disconnectFromStompServer();
    }
  }

  subscribe(String subscriptionUrl,StompFrameCallback callback){
    if (stompClient!=null && stompClient!.connected) {
      log("Subscribing to $subscriptionUrl");
      return stompClient?.subscribe(destination: subscriptionUrl, callback:(frame)=>callback(frame));
    }
  }

  bool send(String url){
    if (stompClient!=null && stompClient!.connected) {
      stompClient!.send(destination: url);
      return true;
    }else{
      return false;
    }
  }

  initializeStompClientAndConnect(){
    log("called UnAuthenticated StompClient Connect method...");
    if(stompClient==null) {
      String url = getWebsocketUrl() +  '/stomp';
      log("Connecting to url=" + url);
      stompClient = StompClient(
          config: StompConfig(
              url: url,
              onConnect: (connectFrame) {
                log("Connected to $url ......");
                executingMethod?.call();
              },
              connectionTimeout: Duration(milliseconds: 3000),
              heartbeatOutgoing: Duration(milliseconds: 4000),
              heartbeatIncoming: Duration(milliseconds: 5000),
              onUnhandledReceipt: (f) {
                print('Unhandled Receipt='+f.body.toString());
              },
              onWebSocketError: (e) {
                log(e.toString());
              },
              onStompError: (d) => print('error stomp'),
              onDisconnect: (f) {
                log('Disconnected from $url');
              },
              onDebugMessage: (message) {
                log(message);
              }
          )
      );
      stompClient!.activate();
    }

  }

  disconnectFromStompServer(){
    if(stompClient!=null ) { //&& stompClient!.connected
      log("Disconnecting from "+stompClient!.config.url+'......');
      stompClient?.deactivate();
      stompClient=null;
    }
  }

  goToLoginPage() async {
    //Get.rootDelegate.popRoute();
    // storage.erase();
    apiService.initialRoute='/login';
    Get.rootDelegate.offNamed("/login");
    disconnectFromStompServer();
    // Get.back(closeOverlays: true,canPop: true);
  }


  /*_changeTheme(){
    // var branch=Get.rootDelegate.currentConfiguration!.currentTreeBranch;
    GetNavConfig navConfig=Get.rootDelegate.currentConfiguration!.copyWith(location: '/navigation/switch_theme', state: null);
    Get.rootDelegate.pushHistory(navConfig);
    // Get.to(ChangeThemePage());
    Get.bottomSheet(
        ChangeThemePage(),
        barrierColor: Colors.transparent,
        useRootNavigator: true,
        settings: RouteSettings(name: '/navigation/switch_theme')
    );//.then((value) => Get.rootDelegate.popRoute());  //=>Get.find<SldcThemeService>().switchTheme()
  }*/

  onSelectNotification(String payload)  {
   // showAlertDialog();
    /*return new AlertDialog(
      title: Text("PayLoad"),
      content: Text("Payload : $payload"),
    );*/

    /*showDialog(
      context: context,
      builder: (_) {
        return new AlertDialog(
          title: Text("PayLoad"),
          content: Text("Payload : $payload"),
        );
      },
    );*/
  }



}



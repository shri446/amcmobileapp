import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';

import '/utils/constants.dart';
import '../pages/navigation/widget/appbar_widgets.dart';
import '../utils/log.dart';
import 'amc_storage.dart';
import 'oauth2_dio.dart';

class AuthenticatedApiService extends GetxService  {

  // static SldcApiService get to => Get.find();

  // final ApiService apiService=Get.find<ApiService>();
  final GetStorage storage = GetStorage();

  var initialRoute='';
  var networkStatus=false.obs;
  //var networkStatus = false.obs;

  // String initialRoute = '/navigation';

  /*late Map<String, dynamic> menuItems = {
    'Profile': () => showProfileInfo(),
    // 'Change Password': () => _changePassword(),
    'Switch Theme': () => _changeTheme(),
    'Logout': () => logout()
  };*/

  // late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  late OAuth oauthClient;

  // late Dio dio;

  StompClient? stompClient;
  StreamSubscription? connectivitySubscription;


  Function()? executingMethod;
  Function()? parentMethod;
  Timer? timer;

  setMethod(Function() f) {
    executingMethod = f;
    if (stompClient != null && stompClient!.connected &&
        executingMethod != null) {
      executingMethod!(); //?.call();
    }
  }

  setParentMethod(Function() f) {
    parentMethod = f;
  }

  @override
  void onInit() async{
    String deviceInfo=json.encode(await getDeviceInfo());
    deviceInfo=stringToBase64.encode(deviceInfo);// Uri.encodeComponent(deviceInfo);
    initOAuthClient(deviceInfo);

    super.onInit();
  }

  @override
  void onClose() {
    disconnectFromStompServer();
    if(connectivitySubscription!=null) {
      log("Removing Authenticated Connectivity Listener subscription....");
      connectivitySubscription!.cancel();
      connectivitySubscription = null;
    }
    super.onClose();
  }

  listenForNetworkChanges() {
    //Socket.connect('host', 53).then((value) => value.li)
    //InternetConnectionChecker().hasConnection.then((value) => null)
    bool first=true;
    if(connectivitySubscription==null) {
      log("Creating Authenticated Listener for networkChanges....");
      connectivitySubscription = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
        //ConnectivityResult result=await Connectivity().checkConnectivity();
        if(first==false) {
          log('Authenticated Connectivity Listener Status changed to =' + result.toString());
          updateNetworkStatusAndConnect(result);
        }else{
          first=false;
        }
      });
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

  checkNetworkAfterMain() async{
    ConnectivityResult result=await Connectivity().checkConnectivity();
    networkStatus.value=(result == ConnectivityResult.none) ? false : true;
    initialRoute = '/navigation';

    if (networkStatus.value) {
      try {
        log("Refreshing Accesstoken...");
        await oauthClient.refreshAccessToken();
      } catch (e) {
        if (e is DioError) {
          DioError dioError = e as DioError;
          if (dioError.type == DioErrorType.response) {
            int? status = dioError.response?.statusCode;
            log(dioError.response);
            if (status == 400) { //invalid grant (RefreshToken)
              initialRoute = '/login';
            }
          } else {
            log(e.toString());
          }
        }
        return;
      }
      initializeStompClientAndConnect();
    }
    listenForNetworkChanges();

  }

  checkNetworkAfter_onClick_onResumed() async{
    ConnectivityResult result=await (Connectivity().checkConnectivity());

    updateNetworkStatusAndConnect(result);

  }

  updateNetworkStatusAndConnect(ConnectivityResult result){
    networkStatus.value=(result == ConnectivityResult.none) ? false : true;
    if (networkStatus.value) {
      if(Get.rootDelegate!=null && Get.rootDelegate.currentConfiguration!=null && Get.rootDelegate.currentConfiguration!.currentPage!.name!='/login') {
        refreshAccessToken();
      }
    }else{
      disconnectFromStompServer();
    }
  }

    subscribe(String subscriptionUrl, StompFrameCallback callback) {
      if (stompClient!=null && stompClient!.connected) {
        log("Subscribing to $subscriptionUrl");
        return stompClient?.subscribe(destination: subscriptionUrl, callback: (frame) => callback(frame));
      }
    }

    bool send(String url) {
      if (stompClient!=null && stompClient!.connected) {
        stompClient!.send(destination: url);
        return true;
      } else {
        return false;
      }
    }



    initOAuthClient(String deviceInfo) {
      // String deviceInfo=json.encode(await getDeviceInfo());
      oauthClient = OAuth(
          tokenUrl: "$baseUrl/oauth/token",
          clientId: clientId,
          clientSecret: clientSecret,
          storage: OAuthSecureStorage(),
          dio: _createDio(deviceInfo)
      );


    }

    _createDio(String deviceInfo) {
      Dio dio = Dio(
          BaseOptions(
            baseUrl: baseUrl,
            headers: {
              Headers.acceptHeader: ContentType.json,
              'deviceInfo': deviceInfo,
            },
            contentType: Headers.jsonContentType,
            responseType: ResponseType.json,
            receiveDataWhenStatusError: true,
            connectTimeout: 5 * 1000,
            // 5 seconds
            receiveTimeout: 3 * 1000, // 3 seconds
          ));
      // dio.interceptors.add(SldcApiErrorHandler(this));
      return dio;
    }


    initializeStompClientAndConnect() {
       log("called Authenticated StompClient Connect method...");
       if(stompClient==null) {
          String url = getWebsocketUrl() +  '/stomp_protected';
          log("Connecting to url=" + url);
          stompClient = StompClient(
              config: StompConfig(
                  url: url,
                  onConnect: (connectFrame) {
                    log("Connected to $url ......");
                    executingMethod?.call();
                    //subscribeLogoutFromServer();
                    startTokenTimer();
                  },
                  connectionTimeout: Duration(milliseconds: 3000),
                  heartbeatOutgoing: Duration(milliseconds: 4000),
                  heartbeatIncoming: Duration(milliseconds: 5000),
                  stompConnectHeaders: {'Authorization': 'Bearer ' + getToken(),} ,
                  webSocketConnectHeaders: {'Authorization': 'Bearer ' + getToken(),},
                  onUnhandledReceipt: (f) {
                    print('Unhandled Receipt='+f.body.toString());
                  },
                  onWebSocketError: (e) {
                    log(e.toString());
                    stopTokenTimer();
                    if (e.toString().contains("was not upgraded to websocket")) { // if access token is invalid
                      log("onWebsocketError, Invalid Access token " + getToken());
                      oauthClient.refreshAccessToken().then((value) {
                        stompClient!.config.webSocketConnectHeaders!.assign("Authorization", 'Bearer ' + getToken());
                        stompClient!.config.stompConnectHeaders!.assign("Authorization", 'Bearer ' + getToken());
                      }).onError((e, stackTrace) {
                        if (e is OAuthException) {
                          OAuthException oAuthException = e as OAuthException;
                          print(oAuthException.message);
                        } else if (e is DioError) {
                          DioError dioError = e as DioError;
                          if (dioError.type == DioErrorType.receiveTimeout) {
                            print("Receive timeout.....");
                          } else if (dioError.type == DioErrorType.connectTimeout) {
                            print("Connection timeout.....");
                          } else if (dioError.type == DioErrorType.response) {
                            int? status = dioError.response?.statusCode;
                            print(dioError.response);
                            if (status == 400) { //invalid grant (RefreshToken)
                              goToLoginPage();
                            }
                          }
                        }
                      });
                      //refreshAccessToken();
                    } //else if (e is TimeoutException) {

                    //}
                  },
                  onStompError: (d) => print('error stomp'),
                  onDisconnect: (f) {
                    log('Disconnected from $url');
                    stopTokenTimer();
                  },
                  onDebugMessage: (message) {
                    log(message);
                  }
              )
          );
        stompClient!.activate();
      }
    }

    disconnectFromStompServer() {
      if (stompClient != null) { //&& stompClient!.connected
        log("Disconnecting from " + stompClient!.config.url + '......');
        stompClient?.deactivate();
        stompClient = null;
      }
      stopTokenTimer();
    }

    subscribeLogoutFromServer() {
      final String subscriptionUrl = "/user/" + getUsername() + "/admin/forcelogout";
      //print("Subscribing to $subscriptionUrl");
      stompClient!.subscribe(destination: subscriptionUrl,
          callback: (frame) {
            // Get.rootDelegate.popRoute();
            //Get.back(closeOverlays: true,canPop: true);
            // Get.rootDelegate.offNamed("/login");
            goToLoginPage();

            Get.defaultDialog(
                title: "Admin Information",
                content: Text(frame.body.toString()),
                barrierDismissible: false,
                textCancel: "Close"
            );
          }
      );
    }

    logout() {
      log("logging out..... ");
       Connectivity().checkConnectivity().then((result) {
         if(result==ConnectivityResult.none){
           showSnackBar("Error", "Check Internet connection...");
         }else {
           Get.dialog(showLoginProgress(), barrierDismissible: false);
           postRequest("/stomp_protected/logout", {}).then((response) {
             Get.back();
             if (response.statusCode == 200) {
               print(response);
               goToLoginPage();
             } else {
               showSnackBar("Error", response);
             }
           }).onError((error, stackTrace) {
             log(error);
             Get.back();
             showSnackBar("Error", "Please try again...");
           });
         }
       });
    }

    goToLoginPage() async {
      //Get.rootDelegate.popRoute();
      // storage.erase();
      disconnectFromStompServer();
      initialRoute = '/login';
      Get.rootDelegate.offNamed("/login");
      // Get.back(closeOverlays: true,canPop: true);
    }

    Future<OAuthToken> login(String username, String password) {
      return oauthClient.requestTokenAndSave(
          PasswordGrant(username: username, password: password)
      );
    }

    startTokenTimer() {
      print("Starting RefreshToken update timer...");
      if (timer == null) {
        timer = Timer.periodic(Duration(seconds: getTokenValidityTime()), (timer) {
              refreshAccessToken();
            });
      }
    }

    stopTokenTimer() {
      if (timer != null) {
        print("Stopping RefreshToken update timer...");
        timer?.cancel();
        timer = null;
      }
    }

    /*fetchOrRefreshAccessToken() async{
    log("Validating existing token, if expired Refreshing Accesstoken...");
    await oauthClient.fetchOrRefreshAccessToken();.then((value) {

    }).onError((error, stackTrace){
      if(error is DioError) {
        DioError dioError = error as DioError;
        print(dioError.error);
      }else{
        print(error);
      }
    });
  }*/

    refreshAccessToken() {
      log("Refreshing every(" + getTokenValidityTime().toString() + ") with Old AccessToken=" + getToken());
      oauthClient.refreshAccessToken().then((value) {
        log("Received new AccessToken=" + getToken());
        if (stompClient != null && stompClient!.connected) { //expected to be called from timer, onclick
          stompClient!.config.webSocketConnectHeaders!.assign("Authorization", 'Bearer ' + getToken());
          stompClient!.config.stompConnectHeaders!.assign("Authorization", 'Bearer ' + getToken());
          stompClient!.send(destination: "/upgrade_token", headers: {'accessToken': getToken()});

          //stompClient!.deactivate();
          //stompClient!.config.webSocketConnectHeaders!.assign("Authorization", 'Bearer ' + getToken());
          //stompClient!.config.stompConnectHeaders!.assign("Authorization", 'Bearer ' + getToken());
          //stompClient!.activate();
        } else {
          initializeStompClientAndConnect();
        }
      }).onError((e, stackTrace) {
        if (e is OAuthException) {
          OAuthException oAuthException = e as OAuthException;
          print(oAuthException.message);
        } else if (e is DioError) {
          DioError dioError = e as DioError;
          if (dioError.type == DioErrorType.receiveTimeout) {
            print("Receive timeout.....");
          } else if (dioError.type == DioErrorType.connectTimeout) {
            print("Connection timeout.....");
          } else if (dioError.type == DioErrorType.response) {
            int? status = dioError.response?.statusCode;
            print(dioError.response);
            if (status == 400) { //invalid grant (RefreshToken)
              goToLoginPage();
              return;
            }
          }
        }
        //wait for 1 s
        /*Timer(const Duration(seconds: 1), () {
          refreshAccessToken();
        });*/

      });
    }

    getData(String currentRoute) {
      if (stompClient!=null && stompClient!.connected) {
        stompClient!.send(destination: currentRoute);
        return Future.value(true);
      } else {
        showSnackBar("Failed", "Failed to refresh");
        return Future.value(false);
        //refreshController.refreshFailed();
      }
    }



    Future postRequest(String path, Map<String, String> params) {
        return oauthClient.dio!.post(
            path, queryParameters: params.isNotEmpty ? params : {},
            options: Options(headers: {"Authorization": "Bearer " + getToken()},));
    }

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
              refreshAccessToken();
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


    getTokenValidityTime() {
      return storage.read("tokenValidityTime") ?? 10;
    }


    getToken() {
      return storage.read("accessToken") ?? "";
    }

    getUsername() {
      return storage.read("username") ?? "";
    }

    isLoggedIn() {
      return storage.hasData("accessToken");
      /*if(storage.hasData("expiration")){
      return DateTime.now().isBefore(DateTime.fromMillisecondsSinceEpoch(storage.read("expiration"))) ;
    }else{
      return false;
    }*/
    }

  getDeviceInfo() async{
    // final networkInfo = NetworkInfo();
    // String wifiName = await networkInfo.getWifiName() ?? 'Not found';
    // String wifiIp = await networkInfo.getWifiIP() ?? 'Not found';
    // String wifiGateway = await networkInfo.getWifiGatewayIP() ?? 'Nofound';

    if (Platform.isIOS) {
      return _readIosDeviceInfo(await DeviceInfoPlugin().iosInfo);
    } else if (Platform.isAndroid) {
      return _readAndroidBuildData(await DeviceInfoPlugin().androidInfo);
    }
  }

  Map<String, dynamic> _readAndroidBuildData(AndroidDeviceInfo info) {
    return <String, dynamic>{
      'Brand': info.brand,
      'Manufacturer': info.manufacturer,
      'Model': info.model,
      'Device': info.device,
      'Hardware': info.hardware,
      // 'Display': info.display,
      // 'Fingerprint': info.fingerprint,
      // 'Host': info.host,
      // 'Id': info.id,
      // 'Product': info.product,
      'AndroidId': info.androidId,
      'Version_securityPatch': info.version.securityPatch,
      'Version_sdk': info.version.sdkInt.toString()+'.'+info.version.release.toString()+'.'+info.version.previewSdkInt.toString(),
      // 'Version.incremental': info.version.incremental,
      // 'Version.codename': info.version.codename,

      // 'version.previewSdkInt': build.version.previewSdkInt,
      // 'version.release': build.version.release,
      // 'supportedAbis': build.supportedAbis,
      // 'Tags': build.tags,
      // 'Board': build.board,
      // 'version.baseOS': build.version.baseOS,
      // 'supported32BitAbis': build.supported32BitAbis,
      // 'supported64BitAbis': build.supported64BitAbis,
      // 'Bootloader': build.bootloader,
      // 'type': build.type,
      // 'isPhysicalDevice': build.isPhysicalDevice,
      // 'systemFeatures': build.systemFeatures,
    };
  }

  Map<String, dynamic> _readIosDeviceInfo(IosDeviceInfo info) {
    return <String, dynamic>{
      'Name': info.name,
      'Model': info.model,
      'SystemName': info.systemName,
      'systemVersion': info.systemVersion,
      'localizedModel': info.localizedModel,
      'identifierForVendor': info.identifierForVendor,
      'utsname_sysname:': info.utsname.sysname,
      'utsname_nodename:': info.utsname.nodename,
      'utsname_release:': info.utsname.release,
      // 'utsname.version:': info.utsname.version,
      // 'utsname.machine:': info.utsname.machine,
      // 'isPhysicalDevice': data.isPhysicalDevice,
    };
  }

    bool hasValidToken() {
      if (storage.hasData("expiration")) {
        return DateTime.now().isBefore(
            DateTime.fromMillisecondsSinceEpoch(storage.read("expiration")));
      } else {
        return false;
      }
    }


    onSelectNotification(String payload) {
      showAlertDialog();
    }


  }




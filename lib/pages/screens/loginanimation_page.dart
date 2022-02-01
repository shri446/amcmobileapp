import 'package:amcmobile/pages/navigation/dashboard/dashboard_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'login_controller.dart';

const users = const {
  'dribbble@gmail.com': '12345',
  'hunter@gmail.com': 'hunter',
};

class LoginScreen extends GetView <LoginController> {
  Duration get loginTime => Duration(milliseconds: 2250);

  Future<String> _authUser(LoginData data) {
    print('Name: ${controller.users}, Password: ${controller.password}');
    return Future.delayed(loginTime).then((_) {
      if (!users.containsKey(controller.users)) {
        return 'Username not exists';
      }
      if (users[data.name] != controller.password) {
        return 'Password does not match';
      }
      return _authUser(data);
    });
  }

 Future<String> _recoverPassword(String name) {
    print('Name: $name');
    return Future.delayed(loginTime).then((_) {
      if (!users.containsKey(name)) {
        return 'Username not exists';
      }
      return name;
    });
  }


  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      title: 'gridx',
      logo: 'assets/gridx1.png',
      onLogin: _authUser,
     // onSignup: _authUser,
      onSubmitAnimationCompleted: () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => DashboardPage(),
        ));
      },
      onRecoverPassword: _recoverPassword,
    );
  }
}

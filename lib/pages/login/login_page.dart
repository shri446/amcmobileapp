import 'package:amcmobile/pages/components/background.dart';
import 'package:amcmobile/pages/login/login_controller.dart';
import 'package:amcmobile/pages/root/root_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPage extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        color:Colors.black12,
        child: Background(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.symmetric(horizontal: 40),
                child: Text(
                  "LOGIN",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color:Color(0xFF0093f9),
                      fontSize: 36
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              SizedBox(height: size.height * 0.03),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(horizontal: 40),
                child: TextFormField(
                  initialValue: controller.userName.value,
                  decoration: InputDecoration(
                      labelText: "Username",
                    icon: Icon(Icons.person),
                  ),
                  onChanged: (text)=>controller.onChangeUsername(text),
                ),
              ),
              SizedBox(height: size.height * 0.03),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(horizontal: 40),
                child: TextFormField(
                  initialValue: controller.password.value,
                  decoration: InputDecoration(
                    labelText: "Password",
                    icon: Icon(Icons.lock),
                  ),
                  obscureText: true,
                  onChanged: (text)=>controller.onChangePassword(text),
                ),

              ),
              SizedBox(height: size.height * 0.05),
              Container(
                alignment: Alignment.centerRight,
                margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                child: Container(
                    alignment: Alignment.center,
                    height: 50.0,
                    width: size.width * 0.3,
                    decoration: new BoxDecoration(
                        borderRadius: BorderRadius.circular(80.0),
                        gradient: new LinearGradient(
                            colors: [
                              Color.fromARGB(255, 255, 136, 34),
                              Color.fromARGB(255, 255, 177, 41)
                            ]
                        )
                    ),
                    child: Row(
                        children: [
                          // Text(controller.errorText.value,style: TextStyle(color: Colors.red.shade800,fontWeight: FontWeight.bold),),
                          MaterialButton(
                            child: Text("Login",style: TextStyle(fontSize: 18,),),
                            onPressed: ()=>controller.login()
                          ),
                        ],
                      )
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
/*
Widget TextButton(String name,String page,) {
  return MaterialButton(
    onPressed: () {
      Get.toNamed(page);
    },
    child: Text(name,style: TextStyle(fontSize:20,fontWeight: FontWeight.bold,color: Colors.white),),
    height: 50,
  );
}*/

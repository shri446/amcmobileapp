import 'package:amcmobile/pages/login/login_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'login_widget/background.dart';

class LoginPage extends GetView<LoginController>{
  @override Widget build(BuildContext context) {
    return  Scaffold(
      body: Stack(
        children: [
          Background(),
          SingleChildScrollView(
            child:Container(
              padding: const EdgeInsets.fromLTRB(25,170,25,25),
              child:Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0)),
                  color: Colors.white,
                  elevation: 10,
                  child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child:Column(
                        children: [
                          Image.asset(
                            'assets/images/gridxlogo.png',
                            height: 100,
                          ),
                          SizedBox(height: 30,),
                          createUserLogin(controller)
                        ],
                      ),
                  )
              ),
            ),
          ),
            ],
      ),
    );
  }
}




Widget createUserLogin(LoginController controller){
  return Column(
    children: [
      TextFormField(
        initialValue: controller.userName.value,
        style: TextStyle(color: Colors.black),
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          labelText: "User Name",
          hintText: 'User Name',
          prefixIcon: Icon(Icons.person,color: Colors.blue,),
        ),
        onChanged: (text)=>controller.onChangeUsername(text),
      ),
      SizedBox(height: 10,),
      TextFormField(
        initialValue: controller.password.value,
        style: TextStyle(color: Colors.black),
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          labelText: "Password",
          hintText: 'Password',
          prefixIcon: Icon(Icons.lock,color:Colors.blue),
        ),
        obscureText: true,
        onChanged: (text)=>controller.onChangePassword(text),
      ),
      SizedBox(height:50),
      Obx(()=>Text(controller.errorText.value,style: TextStyle(color: Colors.red.shade800,fontWeight: FontWeight.bold),),),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
              height: 50,
              width: 130 ,
              margin: EdgeInsets.only(bottom: 20),
              child: MaterialButton(
                  elevation: 5.0,
                  color: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child:
                   Text(
                    "Login",
                    style: TextStyle(color: Colors.white,letterSpacing: 1.5,fontSize: 20,fontWeight: FontWeight.bold),
                  ),
                  onPressed: ()=>controller.login()
              )
          )
        ],
      )
    ]
  );
}
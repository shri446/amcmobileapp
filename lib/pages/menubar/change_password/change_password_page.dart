
import 'package:amcmobile/pages/menubar/change_password/change_password_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangePasswordPage extends GetView<ChangePasswordController>{
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          initialValue: controller.newPassword.value,
          keyboardType: TextInputType.text,
          onChanged: (newvalue)=>controller.onChangeNewPassword(newvalue),
          decoration: InputDecoration(
            labelText: 'New Password',
          ),
        ),
        SizedBox(height: 16),
        TextFormField(
          initialValue: controller.confirmPassword.value,
          keyboardType: TextInputType.text,
          obscureText: true,
          onChanged: (newvalue)=>controller.onChangeConfirmPassword(newvalue),
          decoration: InputDecoration(
            labelText: 'Confirm Password',
          ),
        ),
        Obx(()=>Text(controller.errorText.value,style: TextStyle(color: Colors.red),)),
      ],
    );
  }

}
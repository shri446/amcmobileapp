import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import '/pages/navigation/admin/mobile/manage_user_controller.dart';
import 'package:get/get.dart';

class UserAddPage extends GetView<ManageUserController>{
  @override
  Widget build(BuildContext context) {
   return Column(
     children: [
       TextFormField(
         initialValue: controller.name.value,
         keyboardType: TextInputType.text,
         onChanged: (newvalue)=>controller.onChangeName(newvalue),
         decoration: InputDecoration(
           labelText: 'Name',
         ),
       ),
       TextFormField(
         initialValue: controller.userId.value,
         keyboardType: TextInputType.text,
         onChanged: (newvalue)=>controller.onChangeUserID(newvalue),
         decoration: InputDecoration(
           labelText: 'UserId',
         ),
       ),
       SizedBox(height: 16),
       TextFormField(
         initialValue: controller.position.value,
         keyboardType: TextInputType.text,
         onChanged: (newvalue)=>controller.onChangePosition(newvalue),
         decoration: InputDecoration(
           labelText: 'Position',
         ),
       ),
       SizedBox(height: 16),
       TextFormField(
         initialValue: controller.mobile.value,
         maxLength: 10,
         keyboardType: TextInputType.text,
         onChanged: (newvalue)=>controller.onChangeMobile(newvalue),
         decoration: InputDecoration(
           labelText: 'Mobile',
         ),
       ),
       SizedBox(height: 16),

       Obx(()=>Text(controller.errorText.value,style: TextStyle(color: Colors.red),)),
     ],
   );
  }

}
import 'package:amcmobile/pages/menubar/profile/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

import '../../../service/authenticated_api_service.dart';

class ProfilePage extends GetView<ProfileController>{
  @override
  Widget build(BuildContext context) {
   return Container(
       child:Column(
           children: [
         Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: [
             // CircleAvatar(child: Icon(Icons.person, size: 40,),),
             Text('Logged in as: '),
             Text(controller.authenticatedApiService.getUsername(), style: TextStyle(fontWeight: FontWeight.bold),)
           ],
        ),
         Divider(height: 3.0,),
         Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: [
             Text('Name: '),
             Text(controller.name.value, style: TextStyle(fontWeight: FontWeight.bold),)
           ],
         ),
             Divider(height: 3.0,),
         Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: [
             Text('Position: '),
             Text(controller.position.value, style: TextStyle(fontWeight: FontWeight.bold),)
           ],
         ),
             Divider(height: 3.0,),
         Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: [
             Text('Email: '),
             Text(controller.email.value, style: TextStyle(fontWeight: FontWeight.bold),)
           ],
         )
       ])
   );
  }

}
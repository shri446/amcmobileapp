import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'mobile_users_controller.dart';

class MobileUsersPage extends GetView<MobileUsersController>{
  @override
  Widget build(BuildContext context) {
    return Obx(()=>Scaffold(
      body: SmartRefresher(
            enablePullDown: true,
            controller: controller.refreshController,
            onRefresh: () => controller.getData(),
            child: controller.users.isEmpty ? Center(child:Text("Loading, please wait....",style: TextStyle(fontSize: 18),)) : Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children:[
                  SizedBox(height: 5,),
                  /*Container(
                    decoration: AppTheme.boxDecorationStyle(),
                    padding: EdgeInsets.fromLTRB(30, 5, 30, 5),
                    // color: AppColors.getContainerColor(),
                    child:Column(
                      // mainAxisAlignment: MainAxisAlignment.end,
                      // crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(DateFormat('HH:mm:ss').format(DateTime.fromMillisecondsSinceEpoch(controller.timestamp.value))  , style: TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold,color:AppColors.getDynamicTextColor()),),
                        Text(DateFormat('EEEE dd/MM').format(DateTime.fromMillisecondsSinceEpoch(controller.timestamp.value)), style: TextStyle(fontSize: 11.0,fontWeight: FontWeight.bold,color:AppColors.getDynamicTextColor()),)
                      ],
                    ),
                  ),*/
                  MaterialButton(
                      color: const Color(0xffea5d49),
                      splashColor: Colors.white,
                      height: 45,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        'Add User',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onPressed: ()=> controller.showAddUserDialog(),

                  ),

                  Expanded(
                    child: ListView(
                      padding: const EdgeInsets.all(5),
                      physics: BouncingScrollPhysics(),
                      children: controller.users.entries.map((entry) => createUser(entry.value)).toList(),
                    ),
                  )
                ]
          )
      )
    )
    );
  }

  Widget createUser(dynamic user){
    return Card(
      elevation: 5,
      child: ExpansionTile(
          title: Row(
            children: [
              CircleAvatar(
                radius: 20,
                child: Text(user['name'].toString().toUpperCase().substring(0,1),style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),),
                backgroundColor: controller.getUserStatusColor(user['status']),
                // backgroundColor: Colors.primaries[Random().nextInt(Colors.primaries.length)][Random().nextInt(9) * 100]
              ),
              SizedBox(width: 10,),
              Expanded(child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(user['name'], style: TextStyle(fontWeight: FontWeight.bold),),
                  Text(user['position'],style: TextStyle(fontSize: 11),),
                  Text(user['user'], style: TextStyle(fontSize: 10),),
                  Text(user['ipAddress'], style: TextStyle(fontSize: 10),),
                ],
              )),
              user['status'] !='INACTIVE' ? IconButton(
                  onPressed: (){
                    Get.defaultDialog(
                        barrierDismissible: false,
                        title: 'Alert',
                        content: Text('Are you sure want to Logout '+user['name']),
                        textCancel: 'Cancel',
                        textConfirm: 'Logout',
                        onConfirm: ()=>controller.forceLogout(user['user'],user['status'])
                    );
                  }, icon: Icon(Icons.power_settings_new)
              ) : IconButton(
                  onPressed: ()=>controller.showDeleteUserDialog(user),
                  icon: Icon(Icons.close)
              ),
            ],
          ),
          children: (user['details'] as Map).entries.map((entry) {
            return Container(
                padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                decoration: BoxDecoration(border: Border(top: BorderSide(width: 0.3,color: Colors.black,))),
                child:Row(
                  children: [
                    Expanded(child:Text(entry.key),),
                    Expanded(child:Text(entry.value.toString()))
                  ],
                )
            );
          }).toList()
      ),
    );
  }

}
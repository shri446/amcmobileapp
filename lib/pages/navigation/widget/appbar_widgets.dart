import 'package:amcmobile/pages/menubar/change_theme/change_theme_page.dart';
import 'package:amcmobile/pages/navigation/admin/apps/apps_controller.dart';
import 'package:amcmobile/service/authenticated_apiservice.dart';
import 'package:amcmobile/themes/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

showApplicationControlDialog(Map map,String status){
  AppsController controller=Get.find<AppsController>();
  Get.defaultDialog(
      barrierDismissible: false,
      title: 'Alert!',
      content: Text('Are you sure want to '+status),
      textCancel: 'Cancel',
      textConfirm: status,
      onConfirm: ()=>controller.takeAction(map, status.toUpperCase())
  );
}

void showSnackBar(String title,String message){
  Get.snackbar(
    title, // title
    message,
    backgroundColor: Colors.black87,
    colorText: Colors.white,
    icon: Icon(Icons.alarm),
    shouldIconPulse: true,
    //barBlur: 20,
    isDismissible: true,
    duration: Duration(seconds: 4),
    snackPosition: SnackPosition.BOTTOM,
  );
}
Widget loading() {
  return Center(
      child:  Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            backgroundColor: AppColors.getThemeColor(),
            valueColor: new AlwaysStoppedAnimation<Color>(Colors.red),
          ),
          SizedBox(height: 10,),
          Text("Loading, please wait..."),
        ],
      )

  );

}


AppBar dashboardAppbar(String title){
  return AppBar(
    leading: IconButton(
      icon: Icon(Icons.arrow_back, color: Colors.white),
      onPressed: () =>Get.back(),
    ),
    // backgroundColor: Colors.transparent,
    centerTitle: false,
    titleSpacing: 0,
    title: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:[
          Image.asset("assets/images/gridx.png",width: 100,height: 50,),
          Padding(
            padding: const EdgeInsets.fromLTRB(0,30,0,0),
             child: Text(title,style: TextStyle(fontSize: 15)),
          ),
        ]
    ),
  );
}

AppBar navAppbar(){
  return AppBar(
    // backgroundColor: Colors.transparent,
    //centerTitle: false,
    titleSpacing: 0,
    title: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:[
          Image.asset("assets/images/gridx.png",width: 100,height: 50,),
          Padding(
            padding: const EdgeInsets.fromLTRB(0,30,0,0),
           // child: Text(title,style: TextStyle(fontSize: 15)),
          ),
        ]
    ),
/*    actions: [
      PopupMenuButton<MapEntry>(
          icon: Icon(Icons.more_vert,color: Colors.white,),
          tooltip: 'Actions',
          elevation: 20,
          onSelected:(entry)=>entry.value.call(),
          itemBuilder: (context) => ApiService1.to.authenticatedMenuItems.entries.map((entry) =>
              PopupMenuItem(
                value: entry,
                child: Text(entry.key.toString()),
              )).toList()
      ),
    ],*/
  );
}

AppBar eventsAppbar(String title, String timestamp2,ApiService1 apiService){
  return AppBar(
    leading: IconButton(
      icon: Icon(Icons.arrow_back, color: Colors.white),
      onPressed: () =>Get.back(),
    ),

    //backgroundColor: Colors.transparent,
    centerTitle: false,
    titleSpacing: 0,
    title: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:[
          Image.asset("assets/images/gridx.png",width: 100,height: 50,),
          Padding(
            padding: const EdgeInsets.fromLTRB(0,30,0,0),
            child: Text(title,style: TextStyle(fontSize: 15)),

          ),
          SizedBox(width: 40,),
          Column(
            children: [
              Padding(padding: const EdgeInsets.fromLTRB(0,5,0,0)),
              Text(timestamp2.substring(11,19)+""+"\n"+timestamp2.substring(0,10),style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),)
            ],
          )
        ]
    ),

  );
}

AppBar networkAppbar(String title, String timestamp2,ApiService1 apiService){
  var timestamp;
  return AppBar(
    leading: IconButton(
      icon: Icon(Icons.arrow_back, color: Colors.white),
      onPressed: () =>Get.back(),
    ),
   /* shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        bottom: Radius.circular(20),
      ),
    ),*/
   // backgroundColor: Colors.transparent,
    centerTitle: false,
    titleSpacing: 0,
    title: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:[
          Image.asset("assets/images/gridx.png",width: 100,height: 50,),
          Padding(
            padding: const EdgeInsets.fromLTRB(0,30,0,0),
            child: Text(title,style: TextStyle(fontSize: 15)),
          ),
          SizedBox(width: 40,),
          Column(
            children: [
              Padding(padding: const EdgeInsets.fromLTRB(0,5,0,0)),
              Text(timestamp2.substring(11,19)+""+"\n"+timestamp2.substring(0,10),style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),)
            ],
          )
        ]
    ),
  );
}

AppBar createAppbar(String title,String timestamp2,ApiService1 apiService,){
  return AppBar(
    leading: IconButton(
      icon: Icon(Icons.arrow_back, color: Colors.white),
      onPressed: () =>Get.back(),
    ),

    // backgroundColor:Colors.transparent,
    centerTitle: false,
    titleSpacing: 0,
    title: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:[
          Image.asset("assets/gridx.png",width: 100,height: 50,),
          Padding(
            padding: const EdgeInsets.fromLTRB(0,30,0,0),
            child: Text(title,style: TextStyle(fontSize: 15)),
          ),
        ]
    ),


  );
}
AppBar trendsAppbar(String title,){
  return AppBar(
    leading: IconButton(
      icon: Icon(Icons.arrow_back, color: Colors.white),
      onPressed: () =>Get.back(),
    ),
    // backgroundColor: Colors.transparent,
    centerTitle: true,
    titleSpacing: 0,

    title: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:[
          Image.asset("assets/images/gridx.png",width: 100,height: 50,),
          Padding(
            padding: const EdgeInsets.fromLTRB(0,30,0,0),
            child: Text(title,style: TextStyle(fontSize: 15)),
          ),
        ]
    ),
  );
}

AppBar reportsAppbar(String title,){
  return AppBar(
    leading: IconButton(
      icon: Icon(Icons.arrow_back, color: Colors.white),
      onPressed: () =>Get.back(),
    ),
    leadingWidth: 40,
   // backgroundColor: Colors.transparent,
    centerTitle: false,
    titleSpacing: 0,
    title: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:[
          Image.asset("assets/images/gridx.png",width: 100,height: 50,),
          Padding(
            padding: const EdgeInsets.fromLTRB(0,30,0,0),
            child: Text(title,style: TextStyle(fontSize: 15)),
          ),
        ]
    ),
  );
}

AppBar sldcAppbar(String title,){
  return AppBar(
    leading: IconButton(
      icon: Icon(Icons.arrow_back, color: Colors.white),
      onPressed: () =>Get.back(),
    ),
    leadingWidth: 40,
   // backgroundColor: Colors.transparent,
    centerTitle: false,
    titleSpacing: 0,
    title: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:[
          Image.asset("assets/images/gridx.png",width: 100,height: 50,),
          Padding(
            padding: const EdgeInsets.fromLTRB(0,30,0,0),
            child: Text(title,style: TextStyle(fontSize: 15)),
          ),
        ]
    ),
  );
}

AppBar adminAppbar(String title,){
  return AppBar(
    leading: IconButton(
      icon: Icon(Icons.arrow_back, color: Colors.white),
      onPressed: () =>Get.back(),
    ),
    leadingWidth: 40,
   // backgroundColor: Colors.transparent,
    centerTitle: false,
    titleSpacing: 0,
    title: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:[
          Image.asset("assets/images/gridx.png",width: 100,height: 50,),
          Padding(
            padding: const EdgeInsets.fromLTRB(0,30,0,0),
            child: Text(title,style: TextStyle(fontSize: 15)),
          ),
        ]
    ),
    actions: [
      ],
  );
}


class AppDrawer extends StatefulWidget {
  @override
  _AppDrawerState createState() => new _AppDrawerState();
}
class _AppDrawerState extends State<AppDrawer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height*6/7,
      width: MediaQuery.of(context).size.width*2/3,
      child: new Drawer(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(20),
              topLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
              bottomLeft: Radius.circular(20)),
        ),

       child: new ListView(
         children: [
           ListTile(
             leading: Icon(Icons.supervised_user_circle_outlined),
             title: Text("Profile",style: TextStyle(fontSize: 16),),
             onTap: (){
               showProfileInfo();
             },
           ),
           Divider(height: 3.0,),
           ListTile(
             leading: Icon(Icons.vpn_key_outlined),
             title: Text("Change Password",style: TextStyle(fontSize: 16),),
             onTap: (){
               changePassword();
             },
           ),
           Divider(height: 3.0,),
           ListTile(
             leading: Icon(Icons.logout),
             title: Text("Logout",style: TextStyle(fontSize: 16),),
             onTap: (){
               Navigator.pop(context);
               showDialog(
                   context: context,
                   builder: (BuildContext context)
                   {
                     context = context;
                     return CupertinoAlertDialog(
                       title: Text("Logout"),
                       content: Text("Are you sure, do you want to exit?"),
                       actions: [
                         CupertinoDialogAction(
                           isDefaultAction: true,
                           child: Text("Cancel"),
                           onPressed: ()=>{},
                         ),
                         CupertinoDialogAction(
                           textStyle: TextStyle(color: Colors.red),
                           child: Text("Logout"),
                           onPressed:()=>{} ,
                            ),
                       ],
                     );
                   }
                   );
               },
           ),
           Divider(height: 3.0,),
           ExpansionTile(
             leading: Icon(Icons.wb_incandescent_outlined),
             title: Text("App Theme's",style: TextStyle(fontSize: 16),),
             children: [
                ChangeThemePage()
              ],
           ),
         ],
       ),
      ),
    );
  }
}
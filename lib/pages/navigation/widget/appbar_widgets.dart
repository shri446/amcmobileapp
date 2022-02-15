import 'package:amcmobile/pages/menubar/change_password/change_password_page.dart';
import 'package:amcmobile/pages/menubar/change_theme/change_theme_page.dart';
import 'package:amcmobile/pages/navigation/network/network_controller.dart';
import 'package:amcmobile/pages/navigation/realtime/realtime_controller.dart';
import 'package:amcmobile/service/authenticated_apiservice.dart';
import 'package:amcmobile/themes/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:intl/intl.dart';

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
/*Widget loading() {
  return Center(
      child: Obx(()=>Get.find<ApiService>().networkStatus.value ?  Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(color: Colors.blue,),
          SizedBox(height: 10,),
          Text("Loading, please wait..."),
        ],
      ) : Center(child:Text("Check Internet connection"))
      )
  );
}*/

AppBar dashboardAppbar(String title){
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
   /* actions: [
      PopupMenuButton<MapEntry>(
          icon: Icon(Icons.home,color: Colors.white,size: 35,),
          tooltip: 'Actions',
          elevation: 20,
          onSelected:(entry)=>entry.value.call(),
          itemBuilder: (context) => ApiService1.to.authenticatedMenuItems1.entries.map((entry) =>
              PopupMenuItem(
                value: entry,
                child: Text(entry.key.toString()),
              )).toList()
      ),
    ],*/
  );
}

AppBar navAppbar(){
  return AppBar(

    leadingWidth: 60,
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
    leadingWidth: 40,
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
        ]
    ),
    actions: [
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
         Text(timestamp2.substring(11,19)+""+"\n"+timestamp2.substring(0,10)),
         // Text(timestamp);
         //Text(timestamp2.substring(11,19)+""+"\n"+timestamp2.substring(0,10)),
        ],
      ),
   /*   PopupMenuButton<MapEntry>(
          icon: Icon(Icons.more_vert,color: Colors.white,),
          tooltip: 'Actions',
          elevation: 20,
          onSelected:(entry)=>entry.value.call(),
          itemBuilder: (context) => ApiService1.to.authenticatedMenuItems.entries.map((entry) =>
              PopupMenuItem(
                value: entry,
                child: Text(entry.key.toString()),
              )).toList()
      ),*/
    ],
  );
}

AppBar networkAppbar(String title, String timestamp2,ApiService1 apiService){
  var timestamp;
  return AppBar(
    leadingWidth: 40,
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
        ]
    ),
    actions: [
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
    /*      Text(
            DateFormat.Hms().format(DateTime.now()),
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          Text(  DateFormat('EEEE dd/MM').format(DateTime.now()),
  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
  ),*/
         // Text(timestamp2.substring(11,16))
          Text(timestamp2.substring(11,19)+""+"\n"+timestamp2.substring(0,10),)
        //  Text(timestamp2>0?DateFormat('HH:mm:ss').format(DateTime.fromMillisecondsSinceEpoch(controller.timestamp.value)) :'' , style: TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold,color: Colors.orange),),

          //Text(timestamp> 0 ? DateFormat('HH:mm:ss').format(DateTime.fromMillisecondsSinceEpoch(timestamp)) : '' , style: TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold,color: Colors.orange),),
         // Text(timestamp> 0 ? DateFormat('EEEE dd/MM').format(DateTime.fromMillisecondsSinceEpoch(timestamp)) : '', style: TextStyle(fontSize: 11.0,fontWeight: FontWeight.bold),)
        ],
      ),
  /*    PopupMenuButton<MapEntry>(
          icon: Icon(Icons.more_vert,color: Colors.white,),
          tooltip: 'Actions',
          elevation: 20,
          onSelected:(entry)=>entry.value.call(),
          itemBuilder: (context) => ApiService1.to.authenticatedMenuItems.entries.map((entry) =>
              PopupMenuItem(
                value: entry,
                child: Text(entry.key.toString()),
              )).toList()
      ),*/
    ],
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

    /*actions: [
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [


         // Text(timestamp2.substring(11,19)+""+"\n"+timestamp2.substring(0,10)),

          *//*   Text(timestamp> 0 ? DateFormat('HH:mm:ss').format(DateTime.fromMillisecondsSinceEpoch(timestamp)) : '' , style: TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold),),
          Text(timestamp> 0 ? DateFormat('EEEE dd/MM').format(DateTime.fromMillisecondsSinceEpoch(timestamp)) : '', style: TextStyle(fontSize: 11.0,fontWeight: FontWeight.bold),)
*//*
   ]),
      *//* IconButton(icon: Icon(Icons.notifications),
        onPressed: ()=> Get.isDarkMode? Get.changeTheme(ThemeData.light()):Get.changeTheme(ThemeData.dark()),),*//*
     *//* PopupMenuButton<MapEntry>(
          icon: Icon(Icons.more_vert,color: Colors.white,),
          tooltip: 'Actions',
          elevation: 20,
          onSelected:(entry)=>entry.value.call(),
          itemBuilder: (context) => apiService.authenticatedMenuItems.entries.map((entry) =>
              PopupMenuItem<MapEntry>(
                value: entry,
                child: Text(entry.key.toString()),
              )).toList()
      ),*//*
    ],*/
  );
}
AppBar trendsAppbar(String title,){

  return AppBar(
    leadingWidth: 50,
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
/*
    actions: [
      IconButton(
        icon: const Icon(Icons.more_vert),
        onPressed: () => AppDrawer(),
      ),
    ],*/
/*    actions: [
      Builder(builder:(context){
        return IconButton(
          onPressed: (){
            Scaffold.of(context).openDrawer(

            );
            },
          icon: const Icon(Icons.more_vert,color: Colors.pinkAccent,),
        );
      })
     *//* Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          //  Text(timestamp2.substring(11,19)+""+"\n"+timestamp2.substring(0,10)),
          ]
      ),
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
      ),*//*
    ],*/
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

        ]),

 /*   actions: [
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
 /*   actions: [
      PopupMenuButton<MapEntry>(
          icon: Icon(Icons.more_vert,color: Colors.black,),
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





/*
        child: new ListView(
          children: <Widget>[
            Column(
              children: [
                TextButton( child: Text("Profile",style: TextStyle(color:AppColors.backgroundColorDark)),
                onPressed: (){
               showProfileInfo();
               },),
              ],
            ),
            Column(
              children: [
                TextButton(child: Text("Change pw",style: TextStyle(color:AppColors.backgroundColorDark), ),
                    onPressed:(){
                    changePassword();
                  }),
              ],
            ),
            Column(
              children: [
                ListTile(
                    title: Text('Sign out'),
                    leading: Icon(Icons.logout),
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
                            child: Text("Yes"),
                          ),
                          CupertinoDialogAction(
                            textStyle: TextStyle(color: Colors.red),
                            child: Text("No"),
                            onPressed:()=>{} ,
                          ),

                          ElevatedButton(
                            child: Text('No'),
                            onPressed: () => {Navigator.of(context).pop(true);},
                          ),
                          ElevatedButton(
                              child: Text('Yes'),
                              onPressed: () => {Navigator.of(context).pop(false);}
                          ),
                        ],
                      );
                    }
                    );
                  }
                  )
                  ]
            ),
            Column(
              children: [
                ExpansionTile(
                  controlAffinity: ListTileControlAffinity.leading,
                  title: Text("App Theam",style: TextStyle(fontSize: 15),),
                  children: [
                    ChangeThemePage()
                  ],
                ),
              ],
            ),
          ],
        ),*/
      ),
    );
  }
}
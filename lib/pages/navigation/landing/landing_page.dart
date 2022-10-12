import 'package:amcmobile/pages/navigation/landing/about/about_page.dart';
import 'package:amcmobile/pages/navigation/landing/contacts/contacts_page.dart';
import 'package:amcmobile/pages/navigation/landing/rtu/rtu_page.dart';
import 'package:amcmobile/pages/navigation/landing/scada/scada_page.dart';
import 'package:amcmobile/themes/app_colors.dart';
import 'package:bulleted_list/bulleted_list.dart';
import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';


import '../widget/appbar_widgets.dart';

class LandingPage extends GetView {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:staticAppbar(),
      body: SafeArea(
        child: DefaultTabController(
          length: 4,
          child: Column(
            children: <Widget>[
              ButtonsTabBar(
                contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                backgroundColor: AppColors.getThemeColor(),
                unselectedBackgroundColor: AppColors.getContainerColor(),
                unselectedLabelStyle: TextStyle(color: Colors.black),
                //radius: 100,
                height: 50,
                labelStyle:
                TextStyle(color: Colors.white, fontWeight: FontWeight.bold,fontSize: 16),
                tabs: [
                  Tab(child: Text("About Us",style: TextStyle(color:Colors.black),),),
                  Tab(text: "SCADA",),
                  Tab(text: "RTU"),
                  Tab(text: "Contact"),
                ],
              ),
              Expanded(
                child: TabBarView(
                    children: <Widget>[
                    Aboutpage(),
                    ScadaPage(),
                    RtuPage(),
                    ContactsPage(),
                  ]
                )
              ),
            ],
          ),
        ),
      ),
    );
  }
}
class MyBullet extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return new Container(
      height: 5.0,
      width: 5.0,
      decoration: new BoxDecoration(
        color: Colors.black,
        shape: BoxShape.circle,
      ),
    );
  }
}
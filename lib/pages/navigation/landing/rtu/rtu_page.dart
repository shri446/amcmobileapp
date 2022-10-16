
import 'package:amcmobile/pages/navigation/admin/admin_controller.dart';
import 'package:amcmobile/pages/navigation/widget/appbar_widgets.dart';
import 'package:bulleted_list/bulleted_list.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

class RtuPage extends GetView<AdminController>{
  @override
  Widget build(BuildContext context){
    return Padding(
        padding: EdgeInsets.all(10), //apply padding to all four sides
        child:SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                  height: 200,
                  // width: 370,
                  child: Carousel(
                    images: [
                      AssetImage("assets/images/rtu-p1.jpg",),
                      AssetImage("assets/images/rtu-p2.jpg"),
                      AssetImage("assets/images/rtu-p3.jpg",),
                      //AssetImage("assets/images/events.png",),
                    ],
                    dotSize: 4.0,
                    dotSpacing: 15.0,
                    dotColor: Colors.lightGreenAccent,
                    indicatorBgPadding: 5.0,
                    borderRadius: true,
                  )
              ),
              Container(
                  child: Column(
                    children: [

                      Padding(
                        padding: EdgeInsets.all(15), //apply padding to all four sides
                        child: Text("RTU",style: TextStyle(fontWeight: FontWeight.bold,color:Colors.blue,fontSize: 20.0)),
                      ),
                      BulletedList(
                        bullet: Icon(
                          Icons.circle,
                          color: Colors.green,
                          size:10,
                        ),
                        listItems: [
                          Text('Erection Procurement and Commission of RTUs’ & FRTUs’',style: TextStyle(fontSize: 16.0)),
                          Text('Control System Conceptual Design',style: TextStyle(fontSize: 16.0)),
                          Text( 'Control System Specification/RFQ /Purchase recommendations',style: TextStyle(fontSize: 16.0)),
                          Text('Detailed Control System Engineering',style: TextStyle(fontSize: 16.0)),
                          Text('Specialists in Industrial Control',style: TextStyle(fontSize: 16.0)),
                          Text('Gridx Core Competencies',style: TextStyle(fontSize: 16.0)),
                        ],
                      ),

                    ],
                  )
              ),


            ],
          ),
        )

    );



  }
}
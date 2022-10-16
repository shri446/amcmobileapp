

import 'package:amcmobile/pages/navigation/admin/admin_controller.dart';
import 'package:amcmobile/pages/navigation/widget/appbar_widgets.dart';
import 'package:bulleted_list/bulleted_list.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

class ScadaPage extends GetView<AdminController> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(10), //apply padding to all four sides
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                  height: 200,
                  // width: 370,
                  child: Carousel(
                    images: [
                      AssetImage("assets/images/login.png",),
                      AssetImage("assets/images/sld.png"),
                      AssetImage("assets/images/graph.png",),
                      AssetImage("assets/images/events.png",),
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
                        padding: EdgeInsets.all(15),
                        //apply padding to all four sides
                        child: Text(
                            "GridX SCADA is a powerful data acquisition, process monitoring and control software that lets you build and deliver HMI / SCADA and reporting solutions with minimal efforts. It is designed to provide data visualization suitable for Infrastructure operations, as well as to generate data and analysis reports that help process managers take informed and timely decisions.",
                            style: TextStyle(fontSize: 16.0)),
                      ),
                      Padding(
                        padding: EdgeInsets.all(15),
                        //apply padding to all four sides
                        child: Text("Key Benefits", style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                            fontSize: 20.0)),
                      ),
                      BulletedList(
                        bullet: Icon(
                          Icons.circle,
                          color: Colors.green,
                          size: 10,
                        ),
                        listItems: [

                          Text(
                              'Flexible, configurable, easy to implement and intuitively user friendly SCADA',
                              style: TextStyle(fontSize: 16.0)),
                          Text('High reliability and availability',
                              style: TextStyle(fontSize: 16.0)),
                          Text('Highly Scalable',
                              style: TextStyle(fontSize: 16.0)),
                          Text(
                              'Lower cost of building solution due to ease of use and short learning curve',
                              style: TextStyle(fontSize: 16.0)),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.all(15),
                        //apply padding to all four sides
                        child: Text("Features", style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                            fontSize: 20.0)),
                      ),
                      BulletedList(
                        bullet: Icon(
                          Icons.circle,
                          color: Colors.green,
                          size: 10,
                        ),
                        listItems: [
                          Text(
                              'Highly visual and easy SET-UP AND CONFIGURATION',
                              style: TextStyle(fontSize: 16.0)),
                          Text(
                              'Exhaustive LIBRARIES of configurable items along with OEM specified ranges and standards for Pick and Place and Drag and Drop in entire scope of HMI',
                              style: TextStyle(fontSize: 16.0)),
                          Text(
                              'Extensive and extensible symbols library with animation support lets you build intuitive, HMIs with professional look and feel',
                              style: TextStyle(fontSize: 16.0)),
                          Text(
                              'Intuitive STATISTICAL PLOTTER, with complete control on parameters to be recorded for statistical history',
                              style: TextStyle(fontSize: 16.0)),
                          Text(
                              'Easy and flexible process alarm definition and alarm management',
                              style: TextStyle(fontSize: 16.0)),
                          Text('Built-in active and historical alarm views',
                              style: TextStyle(fontSize: 16.0)),
                          Text(
                              'Built-in REPORTER for generating reports based on captured process data and manually entered data',
                              style: TextStyle(fontSize: 16.0)),
                          Text(
                              'Ability to compute resource consumption that is measured with monotonically increasing meters. This provides you with an ability to get hourly power / fuel consumption reports without writing elaborate scripts',
                              style: TextStyle(fontSize: 16.0))
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
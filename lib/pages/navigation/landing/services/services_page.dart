import 'package:amcmobile/pages/navigation/widget/appbar_widgets.dart';
import 'package:bulleted_list/bulleted_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ServicesPage extends GetView{
  @override Widget build(BuildContext context) {
    return  Padding(
        padding: EdgeInsets.all(15), //apply padding to all four sides
        child:SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                
                BulletedList(
                  bullet: Icon(
                    Icons.circle,
                    color: Colors.green,
                    size: 10,
                  ),
                  listItems: [
                    Text('SCADA EPC Services.', style: TextStyle(fontSize: 16.0)),
                    Text('OLTE EPC Services.', style: TextStyle(fontSize: 16.0)),
                    Text('PLCC EPC Services.', style: TextStyle(fontSize: 16.0)),
                    Text('AMC.', style: TextStyle(fontSize: 16.0)),
                  ],
                ),
                Padding(padding: EdgeInsets.all(15),
                  child: Column(
                    children: [
                      Image.asset('assets/images/services.png'),
                      Text(''),
                      Text('  We have separate teams for doing Business and Presale, Technology, Field Operations, Project Management, and Administration Teams. All the teams follow the processes that are standardized to ensure quality assurance.',style: TextStyle(fontSize: 16.0)),
                      Text(''),
                      Text('JPS also has a host of SMEs as retainers to troubleshoot and kind of problems that occur in due course of the contract so that our clients always have the possible resolutions for all their roadblocks.',style: TextStyle(fontSize: 16.0))
                    ],
                  ),
                )
              ],
            ),
          ),
         
          



        )

    );
  }

}
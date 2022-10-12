import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

class Aboutpage extends GetView{
  @override
  Widget build(BuildContext context){
    return  Padding(
        padding: EdgeInsets.all(15), //apply padding to all four sides
        child:SingleChildScrollView(
          child: Column(
            children: [
              Text('Joohitha Power Systems - GridX Company based in Hyderabad was created to establish itself as a leader in SCADA consulting, Implementation and Commissioning services, formerly known as Sri Ragavendra Electricals with 12 years of successful productive business experience. We have been undertaking SCADA based contracts in various sectors since year 2000.', style: TextStyle(fontSize: 16.0)),
              //Text('Joohitha Power Systems - GridX Company based in Hyderabad was created to establish itself as a leader in SCADA consulting, Implementation and Commissioning services, formerly known as Sri Ragavendra Electricals with 12 years of successful productive business experience. We have been undertaking SCADA based contracts in various sectors since year 2000.'),
              Image.asset('assets/images/grid x pic 1.png'),
              Text('All the key stake holder have worked with many utilities, both small and large, in selecting and implementing their SCADA, OLTE and PLCC systems. Our hands-on team of professionals has many years of experience successfully designing, specifying, and implementing SCADA, OLTE and PLCC systems. We have team members who have worked in utility operation centers, in the vendor arena, and as consultants. We know the applications, resources, and constraints common to these organizations.',style: TextStyle(fontSize: 16.0)),
              Text(''),
              Text('We have independent Capability and Knowhow in delivering and commissioning RTUs (Remote Telemetry Units) for Power Sector, Gas Pipelines, Railways, State Utilities like APTRANSCO, APGENCO, MSEDCL, KSEB, KEB etc. We have extensive experience in working with various OEM equipments from ABB, GE Harris, AREVA, NELCO, CMC, RAD, SECURE, VCARE, RISHABH, PYROTECH…',style: TextStyle(fontSize: 16.0))
            ],
          ),
        )

    );
  }
}
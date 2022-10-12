
import 'package:amcmobile/pages/navigation/admin/admin_controller.dart';
import 'package:amcmobile/pages/navigation/widget/appbar_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

class ContactsPage extends GetView<AdminController>{
  @override
  Widget build(BuildContext context){
    return Padding(
        padding: EdgeInsets.all(15), //apply padding to all four sides
        child:SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(15), //apply padding to all four sides
                child: Text("CONTACT US",style: TextStyle(fontWeight: FontWeight.bold,color:Colors.blue,fontSize: 20.0)),
              ),
              Center(
                child: Icon(Icons.location_on,size: 30,color: Colors.blue,),

              ),
              Text(''),
              Center(
                child: Text('JoohithaPowerSystems Pvt.Ltd.,', style: TextStyle(fontSize: 20.0)),
              ),
              Center(
                child: Text('House No.1-8-12-20-A/NR,',style: TextStyle(fontSize: 20.0)),
              ),
              Center(
                child: Text('4th Floor, Apyaya,',style: TextStyle(fontSize: 20.0)),
              ),
              Center(
                child: Text('Street No.8, Habsiguda,',style: TextStyle(fontSize: 20.0)),
              ),
              Center(
                child: Text('Telangana-500007',style: TextStyle(fontSize: 20.0)),
              ),
              Text(''),
              Center(
                child: Text('Mobile Contact',style: TextStyle(fontSize: 20.0,color:Colors.blue)),

              ),
              Center(
                child: Icon(Icons.phone,size: 30,color: Colors.blue,),
              ),
              Center(
                  child:Text('Rajendra',style: TextStyle(fontSize: 20.0))
              ),
              Center(
                  child:Text('+91 9248034689',style: TextStyle(fontSize: 20.0))
              ),
              Center(
                child: Text(''),
              ),
              Center(
                child: Text('Scan for Location'),
              ),
              Center(
                child:Image.asset('assets/images/qr-code.png',width: 400,
                  height: 200,),

              ),

            ],
          ),
        )

    );

  }
}
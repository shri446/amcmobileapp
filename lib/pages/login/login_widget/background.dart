import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'login_widget.dart';

class Background extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    var heightOfScreen = MediaQuery.of(context).size.height;
    var widthOfScreen = MediaQuery.of(context).size.width;
   return Scaffold(
     backgroundColor: Colors.orange,
     body: Container(
       child: Stack(
         children: [
           Positioned(
               left: 0,
               top: 0,
               right: 0,
               child: ClipPath(
                 clipper: DrawClip(),
                 child: Container(
                   height: heightOfScreen,
                   width: widthOfScreen,
                   decoration: BoxDecoration(color: Colors.blue),
                 ),
               ),
             ),

           Positioned(
             left: 0,
             top: 0,
             right: 0,
             child: ClipPath(
               clipper: DrawClip1(),
               child: Container(
                 height: heightOfScreen,
                 width: widthOfScreen,
                 decoration: BoxDecoration(color: Colors.pink),

               ),
             ),
           ),
           Positioned(
             left: 0,
             bottom: 0,
             right: 0,
             child: ClipPath(
               clipper: CustomLoginShapeClipper6(),
               child: Container(
                 height: heightOfScreen,
                 decoration: BoxDecoration(color: Colors.greenAccent),
               ),
             ),
           ),
         ],
       ),
     ),
   );
  }

}

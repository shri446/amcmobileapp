import 'package:amcmobile/pages/navigation/widget/appbar_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StaticPage extends GetView{
  @override Widget build(BuildContext context) {
    context.theme;
    return Scaffold(
      appBar: staticAppbar(),
      body: SingleChildScrollView(
        child: Container(
          child: Text("Under Process")
        ),
      ),

    );
  }

}
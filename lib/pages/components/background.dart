import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  final Widget child;
  const Background({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: size.height,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(
            top: 0,
            right: 0,
            child: Image.asset(
                "assets/images/top1.png",color: Color(0xFF0093f9),
                width: size.width,
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: Image.asset(
                "assets/images/top2.png",
                width: size.width,color: Color(0xFF0093f9),
            ),
            ),

          Positioned(
            top: 50,
            right: 10,
            child: Image.asset(
                "assets/images/gridx.png",
                width: size.width * 0.40
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Image.asset(
                "assets/images/bottom1.png",
                width: size.width,color: Color(0xFF0093f9),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Image.asset(
                "assets/images/bottom2.png",
                width: size.width,color: Color(0xff0093f9),
            ),
          ),

        ],
      ),
    );
  }
}
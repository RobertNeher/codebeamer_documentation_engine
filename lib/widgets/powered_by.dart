import 'package:flutter/material.dart';

Widget PoweredBy() {
  return Container(
    color: const  Color.fromARGB(255, 204, 204, 204),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: const <Widget>[
        Text(
          'Powered by',
          style: TextStyle(
              fontFamily: "Railway",
              fontWeight: FontWeight.bold,
              fontSize: 24,
              color: Colors.grey),
        ),
        SizedBox(width: 10),
        FlutterLogo(size: 40)
      ]));
}

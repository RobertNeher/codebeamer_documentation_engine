import 'dart:async';

import 'package:flutter/material.dart';
import '../config/configuration.dart';

extension StringExtension on String {
  String truncateTo(int maxLength) =>
      (this.length <= maxLength) ? this : '${this.substring(0, maxLength)}...';
}

Map<String, String> httpHeader() {
  Configuration config = Configuration();

  return {
    'accept': 'application/json',
    'content-type': 'application/json',
    'authorization': config.getAuthToken(),
  };
}



void showToast(BuildContext context, String message) async {
  Timer _timer;
  _timer = Timer(Duration(seconds: 3), () {
    Navigator.of(context).pop();
  });

  return showDialog(
      context: context,
      builder: ((context) => AlertDialog(
            titleTextStyle: const TextStyle(
                fontFamily: "Railway",
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.black),
            elevation: 20,
            alignment: Alignment.bottomCenter,
            content: Text(message),
            contentTextStyle: const TextStyle(
                fontFamily: "Railway",
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.orange),
            contentPadding: const EdgeInsets.all(10),
            // title: const Text('Hint'),
          )));
}

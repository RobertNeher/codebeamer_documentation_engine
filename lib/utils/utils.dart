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

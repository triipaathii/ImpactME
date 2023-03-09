import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

showToastNotification(String empty, String msg) {
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_LONG,
      textColor: Colors.white,
      backgroundColor: const Color(0xff243b55),
      fontSize: 16.0);
}
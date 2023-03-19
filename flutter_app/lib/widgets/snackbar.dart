 import 'package:flutter/material.dart';

void showSnackBar(String message, BuildContext context){
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Theme.of(context).primaryColor,
          content: Text(message,
              textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white,fontSize: 16.0)))
    );
  }
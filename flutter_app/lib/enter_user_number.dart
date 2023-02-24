import 'package:flutter/material.dart';

class EnterUserNumber extends StatefulWidget {
  const EnterUserNumber({super.key});

  @override
  State<EnterUserNumber> createState() => _EnterUserNumberState();
}

class _EnterUserNumberState extends State<EnterUserNumber> {
  final mobileNumerController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              colors: <Color>[Color(0xff0ccda3), Color(0xff243b55)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter)),
      child: const Scaffold(
        backgroundColor: Colors.transparent,
      ),
    );
  }
}

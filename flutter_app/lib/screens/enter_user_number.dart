import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/screens/enter_user_details.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';

import '../widgets/toast.dart';

class EnterUserNumber extends StatefulWidget {
  const EnterUserNumber({super.key});

  @override
  State<EnterUserNumber> createState() => _EnterUserNumberState();
}

class _EnterUserNumberState extends State<EnterUserNumber> {
  TextEditingController mobileNumerController = TextEditingController();
  int? mobileNumberLength;
  final otpController = TextEditingController();
  bool otpWindow = false;

  Timer? countdownTimer;
  Duration myDuration = const Duration(seconds: 60);
  bool resendOTPCondition = false;

  void startTimer() {
    countdownTimer =
        Timer.periodic(const Duration(seconds: 1), (_) => setCountDown());
  }

  void stopTimer() {
    setState(() => countdownTimer!.cancel());
  }

  void resetTimer() {
    stopTimer();
    setState(() => myDuration = const Duration(seconds: 60));
  }

  void setCountDown() {
    const reduceSecondsBy = 1;
    setState(() {
      final seconds = myDuration.inSeconds - reduceSecondsBy;
      if (seconds < 0) {
        countdownTimer!.cancel();
      } else {
        myDuration = Duration(seconds: seconds);
      }
      if (seconds == 0) {
        resendOTPCondition = true;
      }
    });
  }

  void resendOTP() async {
    // dataBaseMethods.sendOTPForRegistration(widget.mobileNo);
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      systemNavigationBarColor: Color(0xff243b55),
    ));

    final mediaQueryHeight = MediaQuery.of(context).size.height;
    final mediaQueryWidth = MediaQuery.of(context).size.width;

    final minutes = (myDuration.inMinutes.remainder(60));
    final seconds = (myDuration.inSeconds.remainder(60));

    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              colors: <Color>[Color(0xff0ccda3), Color(0xff243b55)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter)),
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.transparent,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                width: double.infinity,
              ),
              Text(
                "IMPACT ME",
                style: GoogleFonts.raleway(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    letterSpacing: 7),
              ),
              const SizedBox(height: 50),
              Text(
                "Enter your Mobile Number",
                style: GoogleFonts.raleway(color: Colors.white, fontSize: 22),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child: TextFormField(
                  controller: mobileNumerController,
                  keyboardType: TextInputType.phone,
                  cursorColor: const Color(0xff0ccda3),
                  textAlign: TextAlign.center,
                  cursorHeight: 30,
                  onChanged: (value) {
                    // print(mobileNumerController.text);
                    // print(mobileNumerController.text.length);
                    setState(() {
                      mobileNumberLength = value.length;
                      if (mobileNumberLength != 10) {
                        otpWindow = false;
                      }
                    });
                  },
                  decoration: const InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xff0ccda3))),
                    disabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xff243b55))),
                  ),
                  maxLength: 10,
                  style: GoogleFonts.raleway(
                      color: Colors.white, fontSize: 20, letterSpacing: 2),
                ),
              ),
              const SizedBox(height: 20),
              if (mobileNumberLength != null &&
                  mobileNumberLength == 10 &&
                  !otpWindow)
                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        otpWindow = true;
                      });
                      startTimer();
                    },
                    style: ElevatedButton.styleFrom(
                        elevation: 0, backgroundColor: const Color(0xff0ccda3)),
                    child: Text(
                      "GET OTP",
                      style: GoogleFonts.raleway(
                          color: const Color(0xff243b55),
                          fontSize: 15,
                          letterSpacing: 2),
                    )),
              if (otpWindow && mobileNumberLength == 10)
                Column(
                  children: [
                    Text(
                      "We have sent you a 4-digit verification code",
                      style: GoogleFonts.raleway(
                          color: Colors.white, fontSize: 15),
                    ),
                    const SizedBox(
                      height: 15,
                      width: double.infinity,
                    ),
                    Pinput(
                      controller: otpController,
                      keyboardType: TextInputType.number,
                      defaultPinTheme: PinTheme(
                        width: 56,
                        height: 56,
                        textStyle: GoogleFonts.raleway(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.w700),
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: const Color(0xff243b55), width: 3),
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: mediaQueryHeight * 0.025,
                      width: double.infinity,
                    ),
                    resendOTPCondition
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                "Didn't you receive the OTP? ",
                                style: GoogleFonts.raleway(
                                    color: Colors.white, fontSize: 14),
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    resendOTPCondition = false;
                                  });
                                  resendOTP();
                                  showToastNotification(
                                    "",
                                    "An One Time Password has been sent to your mobile Number",
                                    // duration: const Duration(seconds: 1),
                                  );
                                  resetTimer();
                                  startTimer();
                                },
                                child: Text(
                                  "Resend OTP",
                                  style: GoogleFonts.raleway(
                                      color: const Color(0xff0ccda3),
                                      fontSize: 15),
                                ),
                              )
                            ],
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                "Resend OTP in ",
                                style: GoogleFonts.raleway(
                                    color: Colors.white, fontSize: 14),
                              ),
                              Text(
                                seconds < 10
                                    ? "0$minutes:0$seconds"
                                    : "0$minutes:$seconds",
                                style: GoogleFonts.raleway(
                                    color: const Color(0xff0ccda3),
                                    fontSize: 16),
                              ),
                              Text(
                                " seconds",
                                style: GoogleFonts.raleway(
                                    color: Colors.white, fontSize: 15),
                              ),
                            ],
                          ),
                    if (mobileNumberLength != null &&
                        mobileNumberLength == 10 &&
                        otpWindow)
                      Column(
                        children: [
                          const SizedBox(height: 20),
                          ElevatedButton(
                              onPressed: () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const EnterUserBasicDetails()));
                              },
                              style: ElevatedButton.styleFrom(
                                  elevation: 0,
                                  backgroundColor: const Color(0xff0ccda3)),
                              child: Text(
                                "VERIFY OTP",
                                style: GoogleFonts.raleway(
                                    color: const Color(0xff243b55),
                                    fontSize: 15,
                                    letterSpacing: 2),
                              )),
                        ],
                      ),
                  ],
                )
            ],
          ),
        ),
      ),
    );
  }
}

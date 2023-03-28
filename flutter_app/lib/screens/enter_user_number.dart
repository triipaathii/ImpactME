import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/screens/enter_user_details.dart';
import 'package:flutter_app/widgets/snackbar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../providers/user_provider.dart';
import '../widgets/toast.dart';
import 'homepage.dart';

class EnterUserNumber extends StatefulWidget {
  const EnterUserNumber({super.key});

  @override
  State<EnterUserNumber> createState() => _EnterUserNumberState();
}

class _EnterUserNumberState extends State<EnterUserNumber> {
  TextEditingController mobileNumerController = TextEditingController();
  static String verify = "";
  int? resendToken1;
  final FirebaseAuth auth = FirebaseAuth.instance;

  int? mobileNumberLength;
  final otpController = TextEditingController();
  bool otpWindow = false;
  var phone = "";
  var code = "";
  Timer? countdownTimer;
  Duration myDuration = const Duration(seconds: 60);
  bool resendOTPCondition = false;
  bool isLoading = false;
  bool isExistingUser = false;
  final db = FirebaseFirestore.instance;

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
    _sendOTP();
  }

  _sendOTP() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: '${"+91" + phone}',
      verificationCompleted: (PhoneAuthCredential credential) {},
      verificationFailed: (FirebaseAuthException e) {
        if (e.code == 'invalid-phone-number') {
          print('The provided phone number is not valid.');
          showSnackBar(e.code.toString(), context, Colors.redAccent.shade700);
        }
      },
      codeSent: (String verificationId, int? resendToken) async {
        verify = verificationId;
        resendToken1 = resendToken;
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
    setState(() {
      otpWindow = true;
    });
    startTimer();
  }

  @override
  void dispose() {
    stopTimer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      systemNavigationBarColor: Color(0xff243b55),
    ));

    final mediaQueryHeight = MediaQuery.of(context).size.height;
    final minutes = (myDuration.inMinutes.remainder(60));
    final seconds = (myDuration.inSeconds.remainder(60));

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Color(0xff243b55),
        body: isLoading
            ? Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    width: double.infinity,
                  ),
                  Image.asset(
                    "assets/images/logo.png",
                    color: Colors.white,
                    height: 100,
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
                    "ENTER YOUR MOBILE NUMBER",
                    style:
                        GoogleFonts.raleway(color: Colors.white, fontSize: 19),
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
                        phone = value;
                        print(phone);
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
                        onPressed: () async {
                          _sendOTP();
                        },
                        style: ElevatedButton.styleFrom(
                            elevation: 0,
                            backgroundColor: const Color(0xff0ccda3)),
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
                          "We have sent you a 6-digit verification code",
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
                          length: 6,
                          onChanged: (value) {
                            code = value;
                          },
                          defaultPinTheme: PinTheme(
                            width: 40,
                            height: 45,
                            textStyle: GoogleFonts.raleway(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.w700),
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: const Color(0xff0ccda3), width: 3),
                              borderRadius: BorderRadius.circular(10),
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
                                  onPressed: () async {
                                    setState(() {
                                      isLoading = true;
                                    });
                                    try {
                                      PhoneAuthCredential credential =
                                          PhoneAuthProvider.credential(
                                              verificationId: verify,
                                              smsCode: code);

                                      // Sign the user in (or link) with the credential
                                      await auth
                                          .signInWithCredential(credential);

                                      await db
                                          .collection("users")
                                          .get()
                                          .then((users) async {
                                        for (var user in users.docs) {
                                          if (user.data()['phone_number'] ==
                                              mobileNumerController.text) {
                                            final prefs =
                                                await SharedPreferences
                                                    .getInstance();
                                            await prefs.setString(
                                                'userId', user.id);
                                            await prefs.setBool('isVolunteer',
                                                user.data()['isVolunteer']);
                                            setState(() {
                                              isExistingUser = true;
                                              isLoading = false;
                                            });
                                            break;
                                          }
                                        }
                                      });
                                      if (await isExistingUser) {
                                        print(
                                            "============= USER FOUND ==============");
                                        // print(context
                                        //     .read<UserIdProvider>()
                                        //     .userId);
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    UserHomePage()));
                                      } else {
                                        print(
                                            "============= USER NOT FOUND ==============");
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    EnterUserBasicDetails(
                                                        phone_number:
                                                            mobileNumerController
                                                                .text)));
                                      }
                                    } catch (e) {
                                      print(e);
                                      setState(() {
                                        isLoading = false;
                                      });
                                      showSnackBar("Invalid OTP", context,
                                          Colors.redAccent.shade700);
                                    }
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
    );
  }
}

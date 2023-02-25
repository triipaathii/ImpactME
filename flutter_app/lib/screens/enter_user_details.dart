import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class EnterUserBasicDetails extends StatefulWidget {
  const EnterUserBasicDetails({super.key});

  @override
  State<EnterUserBasicDetails> createState() => _EnterUserBasicDetailsState();
}

class _EnterUserBasicDetailsState extends State<EnterUserBasicDetails> {
  final nameController = TextEditingController();
  final dobDatePicker = DateRangePickerController();
  String _selectedGender = 'male';

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      systemNavigationBarColor: Color(0xff243b55),
    ));

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
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  width: double.infinity,
                  height: 50,
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
                  "Enter your Name",
                  style: GoogleFonts.raleway(
                      color: const Color(0xff243b55),
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0),
                  child: TextFormField(
                    controller: nameController,
                    keyboardType: TextInputType.name,
                    cursorColor: const Color(0xff0ccda3),
                    textAlign: TextAlign.center,
                    cursorHeight: 30,
                    decoration: const InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color(0xff0ccda3))),
                      disabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color(0xff243b55))),
                    ),
                    style: GoogleFonts.raleway(
                        color: Colors.white, fontSize: 20, letterSpacing: 2),
                  ),
                ),
                const SizedBox(height: 50),
                Text(
                  "Select your DOB",
                  style: GoogleFonts.raleway(
                      color: const Color(0xff243b55),
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40.0),
                    child: SfDateRangePicker(
                      selectionMode: DateRangePickerSelectionMode.single,
                      controller: dobDatePicker,
                      monthCellStyle: DateRangePickerMonthCellStyle(
                        textStyle: GoogleFonts.raleway(
                          color: Colors.white,
                          fontSize: 15,
                        ),
                      ),
                      headerStyle: DateRangePickerHeaderStyle(
                          textAlign: TextAlign.center,
                          textStyle: GoogleFonts.raleway(
                              color: const Color(0xff243b55),
                              fontSize: 20,
                              fontWeight: FontWeight.bold)),
                      selectionTextStyle: GoogleFonts.raleway(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                      selectionColor: const Color(0xff243b55),
                      yearCellStyle: DateRangePickerYearCellStyle(
                        textStyle: GoogleFonts.raleway(
                          color: Colors.white,
                          fontSize: 15,
                        ),
                      ),
                    )),
                const SizedBox(height: 20),
                Text(
                  "Select your Gender",
                  style: GoogleFonts.raleway(
                      color: const Color(0xff243b55),
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5),
                ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 100),
                  leading: Radio<String>(
                    value: 'male',
                    groupValue: _selectedGender,
                    onChanged: (value) {
                      setState(() {
                        _selectedGender = value!;
                      });
                    },
                  ),
                  title: Text(
                    'Male',
                    style: GoogleFonts.raleway(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
                ),
                ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 100),
                  leading: Radio<String>(
                    value: 'female',
                    groupValue: _selectedGender,
                    onChanged: (value) {
                      setState(() {
                        _selectedGender = value!;
                      });
                    },
                  ),
                  title: Text('Female',
                      style: GoogleFonts.raleway(
                        color: Colors.white,
                        fontSize: 15,
                      )),
                ),
                ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 100),
                  leading: Radio<String>(
                    value: 'other',
                    groupValue: _selectedGender,
                    onChanged: (value) {
                      setState(() {
                        _selectedGender = value!;
                      });
                    },
                  ),
                  title: Text(
                    'Other',
                    style: GoogleFonts.raleway(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                        elevation: 0, backgroundColor: const Color(0xff0ccda3)),
                    child: Text(
                      "NEXT",
                      style: GoogleFonts.raleway(
                          color: const Color(0xff243b55),
                          fontSize: 15,
                          letterSpacing: 2),
                    )),
                const SizedBox(
                  height: 50,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

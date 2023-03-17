import 'package:country_state_city_pro/country_state_city_pro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/screens/homepage.dart';
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
  final userCityController = TextEditingController();
  final userStateController = TextEditingController();
  final userCountryController = TextEditingController();
  final userPincodeController = TextEditingController();
  String _selectedGender = 'male';

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      systemNavigationBarColor: Color(0xff243b55),
    ));

    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xff243b55),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                width: double.infinity,
                height: 50,
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
                "ENTER YOUR NAME",
                style: GoogleFonts.raleway(color: Colors.white, fontSize: 19),
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
                "SELECT YOUR DOB",
                style: GoogleFonts.raleway(color: Colors.white, fontSize: 19),
              ),
              const SizedBox(height: 20),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0),
                  child: SfDateRangePicker(
                    selectionMode: DateRangePickerSelectionMode.single,
                    controller: dobDatePicker,
                    rangeTextStyle: GoogleFonts.raleway(),
                    todayHighlightColor: const Color(0xff0ccda3),
                    monthCellStyle: DateRangePickerMonthCellStyle(
                        textStyle: GoogleFonts.raleway(
                          color: Colors.white,
                          fontSize: 15,
                        ),
                        disabledDatesTextStyle: GoogleFonts.raleway(),
                        leadingDatesTextStyle: GoogleFonts.raleway(),
                        todayTextStyle: GoogleFonts.raleway(),
                        trailingDatesTextStyle: GoogleFonts.raleway(),
                        blackoutDateTextStyle: GoogleFonts.raleway(),
                        weekendTextStyle: GoogleFonts.raleway(),
                        todayCellDecoration: BoxDecoration(
                            border: Border.all(
                              color: const Color(0xff0ccda3),
                            ),
                            shape: BoxShape.circle)),
                    headerStyle: DateRangePickerHeaderStyle(
                        textAlign: TextAlign.center,
                        textStyle: GoogleFonts.raleway(
                            color: const Color(0xff0ccda3),
                            fontSize: 20,
                            fontWeight: FontWeight.bold)),
                    selectionTextStyle: GoogleFonts.raleway(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                    selectionColor: const Color(0xff0ccda3),
                    yearCellStyle: DateRangePickerYearCellStyle(
                      textStyle: GoogleFonts.raleway(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                    ),
                  )),
              const SizedBox(height: 20),
              Text(
                "SELECT YOUR GENDER",
                style: GoogleFonts.raleway(color: Colors.white, fontSize: 19),
              ),
              const SizedBox(height: 5),
              ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 100),
                leading: Radio<String>(
                  activeColor: Color(0xff0ccda3),
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
                  activeColor: Color(0xff0ccda3),
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
                  activeColor: Color(0xff0ccda3),
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
              Text(
                "LOCATION",
                style: GoogleFonts.raleway(color: Colors.white, fontSize: 19),
              ),
              const SizedBox(height: 10),
              CountryStateCityPicker(
                country: userCountryController,
                state: userStateController,
                city: userCityController,
                textFieldInputBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Color(0xff243b55), width: 2)),
              ),
              const SizedBox(height: 30),
              Text(
                "ENTER YOUR PINCODE",
                style: GoogleFonts.raleway(color: Colors.white, fontSize: 19),
              ),
              const SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child: TextFormField(
                  controller: userPincodeController,
                  keyboardType: TextInputType.number,
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
              ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => UserHomePage(
                                  isVolunteer: false,
                                )));
                  },
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
    );
  }
}

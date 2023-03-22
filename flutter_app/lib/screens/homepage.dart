import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_app/screens/about_us.dart';
import 'package:flutter_app/screens/feeds.dart';
import 'package:flutter_app/screens/jobs.dart';
import 'package:flutter_app/screens/profile.dart';
import 'package:google_fonts/google_fonts.dart';

import 'home.dart';

class UserHomePage extends StatefulWidget {
  bool isVolunteer;
  UserHomePage({super.key, required this.isVolunteer});

  @override
  State<UserHomePage> createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {
  final _advancedDrawerController = AdvancedDrawerController();
  int pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Color(0xff243b55),
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: Color(0xff243b55),
        systemNavigationBarIconBrightness: Brightness.light));

    return AdvancedDrawer(
      backdropColor: const Color.fromARGB(255, 43, 70, 100),
      controller: _advancedDrawerController,
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 300),
      animateChildDecoration: true,
      rtlOpening: false,
      disabledGestures: false,
      childDecoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      drawer: SafeArea(
        child: ListTileTheme(
          textColor: Colors.white,
          iconColor: Colors.white,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              const SizedBox(
                height: 50,
              ),
              // Padding(
              //   padding: EdgeInsets.symmetric(vertical: 20),
              //   child: Image.asset(
              //     "assets/images/logo.png",
              //     color: Colors.white,
              //     height: 100,
              //   ),
              // ),

              CircleAvatar(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Image.asset(
                    "assets/images/logo.png",
                    color: const Color.fromARGB(255, 43, 70, 100),
                  ),
                ),
                backgroundColor: Colors.white,
                radius: 70,
              ),

              const SizedBox(
                height: 25,
              ),

              Text(
                "IMPACT ME",
                style: GoogleFonts.raleway(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 7),
              ),

              const SizedBox(
                height: 25,
              ),

              // HOME Tile
              ListTile(
                onTap: () {
                  setState(() {
                    pageIndex = 0;
                  });
                },
                tileColor: pageIndex == 0 ? Colors.white : Colors.transparent,
                leading: Icon(
                  Icons.home,
                  color: pageIndex == 0
                      ? const Color.fromARGB(255, 43, 70, 100)
                      : Colors.white,
                ),
                title: Text(
                  'Home',
                  style: GoogleFonts.raleway(
                      color: pageIndex == 0
                          ? const Color.fromARGB(255, 43, 70, 100)
                          : Colors.white),
                ),
              ),

              // FEEDS Tile
              ListTile(
                onTap: () {
                  setState(() {
                    pageIndex = 1;
                  });
                },
                tileColor: pageIndex == 1 ? Colors.white : Colors.transparent,
                leading: Icon(
                  Icons.ads_click_rounded,
                  color: pageIndex == 1
                      ? const Color.fromARGB(255, 43, 70, 100)
                      : Colors.white,
                ),
                title: Text(
                  'Feeds',
                  style: GoogleFonts.raleway(
                      color: pageIndex == 1
                          ? const Color.fromARGB(255, 43, 70, 100)
                          : Colors.white),
                ),
              ),

              // PROFILE Tile
              ListTile(
                onTap: () {
                  setState(() {
                    pageIndex = 2;
                  });
                },
                tileColor: pageIndex == 2 ? Colors.white : Colors.transparent,
                leading: Icon(
                  Icons.account_circle_rounded,
                  color: pageIndex == 2
                      ? const Color.fromARGB(255, 43, 70, 100)
                      : Colors.white,
                ),
                title: Text(
                  'Jobs',
                  style: GoogleFonts.raleway(
                      color: pageIndex == 2
                          ? const Color.fromARGB(255, 43, 70, 100)
                          : Colors.white),
                ),
              ),

              // SETTINGS Tile
              ListTile(
                onTap: () {
                  setState(() {
                    pageIndex = 3;
                  });
                },
                tileColor: pageIndex == 3 ? Colors.white : Colors.transparent,
                leading: Icon(
                  Icons.settings,
                  color: pageIndex == 3
                      ? const Color.fromARGB(255, 43, 70, 100)
                      : Colors.white,
                ),
                title: Text(
                  'Profile',
                  style: GoogleFonts.raleway(
                      color: pageIndex == 3
                          ? const Color.fromARGB(255, 43, 70, 100)
                          : Colors.white),
                ),
              ),

              // ABOUT US Tile
              ListTile(
                onTap: () {
                  setState(() {
                    pageIndex = 4;
                  });
                },
                tileColor: pageIndex == 4 ? Colors.white : Colors.transparent,
                leading: Icon(
                  Icons.info_rounded,
                  color: pageIndex == 4
                      ? const Color.fromARGB(255, 43, 70, 100)
                      : Colors.white,
                ),
                title: Text(
                  'About Us',
                  style: GoogleFonts.raleway(
                      color: pageIndex == 4
                          ? const Color.fromARGB(255, 43, 70, 100)
                          : Colors.white),
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: const Color(0xff243b55),
            title: Row(
              children: pageIndex == 0
                  ? <Widget>[
                      const Icon(Icons.home),
                      Text(
                        '  HOME',
                        style: GoogleFonts.raleway(),
                      ),
                    ]
                  : pageIndex == 1
                      ? <Widget>[
                          const Icon(Icons.ads_click_rounded),
                          Text(
                            '  FEEDS',
                            style: GoogleFonts.raleway(),
                          ),
                        ]
                      : pageIndex == 2
                          ? <Widget>[
                              const Icon(Icons.account_circle_rounded),
                              Text(
                                '  JOB DESCRIPTION',
                                style: GoogleFonts.raleway(),
                              ),
                            ]
                          : pageIndex == 3
                              ? <Widget>[
                                  const Icon(Icons.settings),
                                  Text(
                                    '  PROFILE',
                                    style: GoogleFonts.raleway(),
                                  ),
                                ]
                              : <Widget>[
                                  const Icon(Icons.info_rounded),
                                  Text(
                                    '  ABOUT US',
                                    style: GoogleFonts.raleway(),
                                  ),
                                ],
            ),
            leading: IconButton(
              onPressed: _handleMenuButtonPressed,
              icon: ValueListenableBuilder<AdvancedDrawerValue>(
                valueListenable: _advancedDrawerController,
                builder: (_, value, __) {
                  return AnimatedSwitcher(
                    duration: const Duration(milliseconds: 250),
                    child: Icon(
                      value.visible ? Icons.clear : Icons.menu,
                      key: ValueKey<bool>(value.visible),
                    ),
                  );
                },
              ),
            ),
          ),
          body: pageIndex == 0
              ? Home()
              : pageIndex == 1
                  ? const Feeds()
                  : pageIndex == 2
                      ? const Jobs()
                      : pageIndex == 3
                          ? const Profile()
                          : const AboutUs()),
    );
  }

  void _handleMenuButtonPressed() {
    _advancedDrawerController.showDrawer();
  }
}

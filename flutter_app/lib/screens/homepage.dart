import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:google_fonts/google_fonts.dart';

class UserHomePage extends StatefulWidget {
  const UserHomePage({super.key});

  @override
  State<UserHomePage> createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {
  final _advancedDrawerController = AdvancedDrawerController();
  int pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return AdvancedDrawer(
      backdropColor: Color.fromARGB(255, 43, 70, 100),
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
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 50),
                child: CircleAvatar(
                  radius: 70,
                  backgroundImage: AssetImage(
                    'assets/images/p1.jpg',
                  ),
                ),
              ),
              ListTile(
                onTap: () {
                  setState(() {
                    pageIndex = 0;
                  });
                },
                leading: const Icon(Icons.home),
                title: Text(
                  'Home',
                  style: GoogleFonts.raleway(),
                ),
              ),
              ListTile(
                onTap: () {
                  setState(() {
                    pageIndex = 1;
                  });
                },
                leading: const Icon(Icons.ads_click_rounded),
                title: Text(
                  'Feeds',
                  style: GoogleFonts.raleway(),
                ),
              ),
              ListTile(
                onTap: () {
                  setState(() {
                    pageIndex = 2;
                  });
                },
                leading: const Icon(Icons.account_circle_rounded),
                title: Text(
                  'Profile',
                  style: GoogleFonts.raleway(),
                ),
              ),
              ListTile(
                onTap: () {
                  setState(() {
                    pageIndex = 3;
                  });
                },
                leading: const Icon(Icons.settings),
                title: Text(
                  'Settings',
                  style: GoogleFonts.raleway(),
                ),
              ),
              ListTile(
                onTap: () {
                  setState(() {
                    pageIndex = 4;
                  });
                },
                leading: const Icon(Icons.info_rounded),
                title: Text(
                  'About Us',
                  style: GoogleFonts.raleway(),
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
      child: Scaffold(
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
                              '  PROFILE',
                              style: GoogleFonts.raleway(),
                            ),
                          ]
                        : pageIndex == 3
                            ? <Widget>[
                                const Icon(Icons.settings),
                                Text(
                                  '  SETTINGS',
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
        body: Container(),
      ),
    );
  }

  void _handleMenuButtonPressed() {
    // NOTICE: Manage Advanced Drawer state through the Controller.
    // _advancedDrawerController.value = AdvancedDrawerValue.visible();
    _advancedDrawerController.showDrawer();
  }
}

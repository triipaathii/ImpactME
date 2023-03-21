import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/providers/user_provider.dart';
import 'package:flutter_app/screens/homepage.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'providers/courses_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => UserModel()),
    ChangeNotifierProvider(create: (context) => CourseProvider())
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      systemNavigationBarColor: Color(0xff243b55),
    ));
    
    return MaterialApp(
      title: 'ImpactME',
      debugShowCheckedModeBanner: false,

      home: UserHomePage(isVolunteer: false),
    );
  }
}

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:food_example/constants.dart';
import 'package:food_example/firebase_options.dart';
import 'package:food_example/screens/intro_login_register/intro_page.dart';
import 'package:food_example/screens/main_screen.dart';
import 'package:food_example/screens/profill/profile.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "Biofit",
        colorScheme: ColorScheme.fromSeed(seedColor: kprimaryColor),
        scaffoldBackgroundColor: kbackgroundColor,
        useMaterial3: true,
      ),
      home: IntroPage(),
    );
  }
}

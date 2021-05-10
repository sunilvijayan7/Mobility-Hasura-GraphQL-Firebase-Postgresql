import 'package:country_code_picker/country_localizations.dart';
import 'package:en_payroll/screens/login_screen.dart';
import 'package:en_payroll/screens/home_screen.dart';
import 'package:en_payroll/screens/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      supportedLocales: [
        Locale("en"),
      ],
      localizationsDelegates: [
        CountryLocalizations.delegate,
      ],
      debugShowCheckedModeBanner: false,
      title: 'EN PAYROLL',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        accentColor: Colors.blue,
        fontFamily: 'Montserrat',
      ),
      initialRoute: SplashScreen.id,
      routes: {
        SplashScreen.id: (context) => SplashScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        HomeScreen.id: (context) => HomeScreen(),
      },
    );
  }
}


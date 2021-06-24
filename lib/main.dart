import 'package:apollo/Auth/LoginScreen.dart';
import 'package:apollo/Auth/RegistrationScreen.dart';
import 'package:apollo/Screen/MainScreen.dart';
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(new MaterialApp(
    home: new MyApp(),
  ));
}

DatabaseReference usersRef =
    FirebaseDatabase.instance.reference().child("users");

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return new SplashScreen(
      seconds: 3,
      navigateAfterSeconds: new AfterSplash(),
      image: new Image.asset('assets/logo/wslogo.png'),
      photoSize: 100.0,
      title: new Text(
        'APOLLO',
        style: new TextStyle(
            fontWeight: FontWeight.bold, fontSize: 45.0, fontFamily: 'Cinzel'),
        textAlign: TextAlign.center,
      ),
      loadingText: Text(
        'Conquer the world with information',
        style: new TextStyle(
            fontWeight: FontWeight.bold, fontSize: 15.0, fontFamily: 'Cinzel'),
      ),
      styleTextUnderTheLoader: new TextStyle(),
      backgroundColor: Colors.white,
      loaderColor: Colors.black,
    );
  }
}

class AfterSplash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Apollo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: LoginScreen.idScreen,
      routes: {
        LoginScreen.idScreen: (context) => LoginScreen(),
        RegistrationScreen.idScreen: (context) => RegistrationScreen(),
        MainScreen.idScreen: (context) => MainScreen(),
      },
    );
  }
}

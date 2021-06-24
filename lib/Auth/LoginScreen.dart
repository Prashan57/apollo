import 'package:apollo/Screen/MainScreen.dart';
import 'package:apollo/main.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'RegistrationScreen.dart';
import 'package:apollo/constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// ignore: must_be_immutable
class LoginScreen extends StatelessWidget {
  static const String idScreen = 'LoginScreen';
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height / 10,
                ),
                Center(
                  child: Hero(
                    tag: 'logo',
                    child: Image(
                      image: AssetImage('assets/logo/wslogo.png'),
                      width: MediaQuery.of(context).size.width / 2.5,
                      height: MediaQuery.of(context).size.height / 3.5,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      right: 15.0, left: 15.0, bottom: 15.0),
                  child: Card(
                    elevation: 2.0,
                    child: Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          Text(
                            "Login",
                            style: TextStyle(
                                fontSize: 24.0, fontWeight: FontWeight.w600),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          TextField(
                              keyboardType: TextInputType.emailAddress,
                              controller: emailTextEditingController,
                              decoration: InputDecoration(
                                  labelText: 'Email',
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: myConstant.primaryColorAlt),
                                  ),
                                  // labelStyle: TextStyle(fontSize: 14.0),
                                  labelStyle: new TextStyle(
                                      color: Colors.grey, fontSize: 14.0),
                                  hintStyle: TextStyle(
                                      color: Colors.grey, fontSize: 10.0)),
                              style: TextStyle(
                                  //color: Colors.grey,
                                  fontSize: 14.0)),
                          SizedBox(
                            height: 1.0,
                          ),
                          TextField(
                              obscureText: true,
                              controller: passwordTextEditingController,
                              decoration: InputDecoration(
                                  labelText: 'Password',
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: myConstant.primaryColor),
                                  ),
                                  labelStyle: new TextStyle(
                                      color: myConstant.primaryColorAlt,
                                      fontSize: 14.0),
                                  hintStyle: TextStyle(
                                      color: Colors.grey, fontSize: 10.0)),
                              style: TextStyle(
                                  //color: Colors.grey,
                                  fontSize: 14.0)),
                          SizedBox(
                            height: 20.0,
                          ),
                          FlatButton(
                              onPressed: () => {
                                    Navigator.pushNamedAndRemoveUntil(
                                        context,
                                        RegistrationScreen.idScreen,
                                        (route) => false),
                                    print('I am register login screen')
                                  },
                              child: Text(
                                'Do you have an Account? Register Here.',
                                style: TextStyle(
                                    fontFamily: 'bolt-regular',
                                    fontSize: 13.0,
                                    fontWeight: FontWeight.bold),
                              )),
                          ButtonTheme(
                            minWidth: MediaQuery.of(context).size.width / 1.3,
                            height: 50,
                            child: RaisedButton(
                              color: myConstant.primaryColor,
                              textColor: Colors.white,
                              child: Container(
                                child: Text(
                                  'Login',
                                  style: TextStyle(
                                      fontSize: 25.0,
                                      fontFamily: 'bolt-semibold'),
                                ),
                              ),
                              shape: new RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(8.4)),
                              onPressed: () => {
                                if (!emailTextEditingController
                                    .text
                                    .contains("@"))
                                  {
                                    displayToastMessage(
                                        "Invalid email address.", context)
                                  }
                                else if (passwordTextEditingController
                                        .text.length <
                                    6)
                                  {
                                    displayToastMessage(
                                        "Password too short.", context)
                                  },
                                loginAndAuthenticateUser(context),
                                print('Logged in button is pressed')
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButton(
                          icon: FaIcon(FontAwesomeIcons.google),
                          iconSize: 30,
                          onPressed: () {}),
                      IconButton(
                          icon: FaIcon(FontAwesomeIcons.facebook),
                          iconSize: 30,
                          onPressed: () {}),
                      IconButton(
                          icon: FaIcon(FontAwesomeIcons.apple),
                          iconSize: 30,
                          onPressed: () {})
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  void loginAndAuthenticateUser(BuildContext context) async {
    final User firebaseUser = (await _firebaseAuth
            .signInWithEmailAndPassword(
                email: emailTextEditingController.text,
                password: passwordTextEditingController.text)
            .catchError((errMsg) {
      displayToastMessage("Error: " + errMsg.toString(), context);
    }))
        .user;

    if (firebaseUser != null) {
      usersRef.child(firebaseUser.uid).once().then((DataSnapshot snap) {
        if (snap.value != null) {
          Navigator.pushNamedAndRemoveUntil(
              context, MainScreen.idScreen, (route) => false);
          displayToastMessage("you are logged-in.", context);
        } else {
          _firebaseAuth.signOut();
          displayToastMessage(
              "No matching records. Open a new account.", context);
        }
      });
    } else {
      displayToastMessage("Error Occured,cannot sign-in.", context);
    }
  }

  // void loginAndAuthenticateUser(BuildContext context) {
  //   FirebaseAuth.instance.signInWithEmailAndPassword(
  //       email: emailTextEditingController.text,
  //       password: passwordTextEditingController.text);
  //   Navigator.pushNamedAndRemoveUntil(
  //       context, MainScreen.idScreen, (route) => false);
  // }

}

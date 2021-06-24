import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:apollo/main.dart';
import 'LoginScreen.dart';
import 'package:apollo/constants.dart';

class RegistrationScreen extends StatelessWidget {
  static const String idScreen = 'RegistrationScreen';

  TextEditingController nameTextEditingController = TextEditingController();
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController phoneTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();
  TextEditingController confirmPasswordTextEditingController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              children: [
                SizedBox(
                  height: 20.0,
                ),
                Center(
                  child: Hero(
                    tag: 'logo',
                    child: Image(
                      image: AssetImage('assets/logo/wclogo.png'),
                      width: MediaQuery.of(context).size.width / 2.5,
                      height: MediaQuery.of(context).size.height / 4.5,
                    ),
                  ),
                ),
                Card(
                  elevation: 4.5,
                  shadowColor: myConstant.primaryColorAlt,
                  semanticContainer: true,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 38.0,
                      ),
                      Text(
                        "User Registration",
                        style: TextStyle(
                            fontSize: 24.0, fontFamily: 'bolt-semibold'),
                        textAlign: TextAlign.center,
                      ),
                      Padding(
                        padding: EdgeInsets.all(25.0),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 1.0,
                            ),
                            TextField(
                                controller: nameTextEditingController,
                                decoration: InputDecoration(
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: myConstant.primaryColor),
                                    ),
                                    labelText: 'Full Name',
                                    labelStyle: new TextStyle(
                                        color: myConstant.primaryColorAlt,
                                        fontSize: 14.0),
                                    hintStyle: TextStyle(
                                        color: Colors.grey, fontSize: 10.0)),
                                style: TextStyle(
                                    //color: Colors.grey,
                                    fontSize: 14.0)),
                            SizedBox(
                              height: 1.0,
                            ),
                            TextField(
                                controller: emailTextEditingController,
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: myConstant.primaryColor),
                                    ),
                                    labelText: 'Email',
                                    labelStyle: new TextStyle(
                                        color: myConstant.primaryColorAlt,
                                        fontSize: 14.0),
                                    hintStyle: TextStyle(
                                        color: Colors.grey, fontSize: 10.0)),
                                style: TextStyle(
                                    //color: Colors.grey,
                                    fontSize: 14.0)),
                            SizedBox(
                              height: 1.0,
                            ),
                            TextField(
                                controller: phoneTextEditingController,
                                keyboardType: TextInputType.phone,
                                decoration: InputDecoration(
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: myConstant.primaryColor),
                                    ),
                                    labelText: 'Contact Number',
                                    labelStyle: new TextStyle(
                                        color: myConstant.primaryColorAlt,
                                        fontSize: 14.0),
                                    hintStyle: TextStyle(
                                        color: Colors.grey, fontSize: 10.0)),
                                style: TextStyle(
                                    //color: Colors.grey,
                                    fontSize: 14.0)),
                            SizedBox(
                              height: 1.0,
                            ),
                            TextField(
                                controller: passwordTextEditingController,
                                obscureText: true,
                                decoration: InputDecoration(
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: myConstant.primaryColor),
                                    ),
                                    labelText: 'Password',
                                    labelStyle: new TextStyle(
                                        color: myConstant.primaryColorAlt,
                                        fontSize: 14.0),
                                    hintStyle: TextStyle(
                                        color: Colors.grey, fontSize: 10.0)),
                                style: TextStyle(
                                    //color: Colors.grey,
                                    fontSize: 14.0)),
                            SizedBox(
                              height: 10.0,
                            ),
                            TextField(
                                controller:
                                    confirmPasswordTextEditingController,
                                obscureText: true,
                                decoration: InputDecoration(
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: myConstant.primaryColor),
                                    ),
                                    labelText: 'Confirm Password',
                                    labelStyle: new TextStyle(
                                        color: myConstant.primaryColorAlt,
                                        fontSize: 14.0),
                                    hintStyle: TextStyle(
                                        color: Colors.grey, fontSize: 10.0)),
                                style: TextStyle(
                                    //color: Colors.grey,
                                    fontSize: 14.0)),
                            SizedBox(
                              height: 10.0,
                            ),
                            FlatButton(
                                onPressed: () => {
                                      Navigator.pushNamedAndRemoveUntil(
                                          context,
                                          LoginScreen.idScreen,
                                          (route) => false),
                                      print('I am register page login tap')
                                    },
                                child: Text(
                                  'Already have an account? Login Here.',
                                  style: TextStyle(
                                      fontFamily: 'bolt-regular',
                                      fontSize: 13.0,
                                      fontWeight: FontWeight.bold),
                                )),
                            SizedBox(
                              height: 10.0,
                            ),
                            ButtonTheme(
                              minWidth: MediaQuery.of(context).size.width / 1.3,
                              height: 50,
                              child: RaisedButton(
                                color: myConstant.primaryColor,
                                textColor: Colors.white,
                                child: Container(
                                  child: Text(
                                    'Create Account',
                                    style: TextStyle(
                                      fontSize: 25.0,
                                    ),
                                  ),
                                ),
                                shape: new RoundedRectangleBorder(
                                    borderRadius:
                                        new BorderRadius.circular(8.4)),
                                onPressed: () => {
                                  //TOAST MESSAGE
                                  if (nameTextEditingController.text.isEmpty)
                                    {
                                      displayToastMessage(
                                          'Name is mandatory', context)
                                    }
                                  else if (nameTextEditingController
                                          .text.length <
                                      3)
                                    {
                                      displayToastMessage(
                                          "Name must be atleast 3 characters.",
                                          context)
                                    }
                                  else if (!emailTextEditingController.text
                                      .contains("@"))
                                    {
                                      displayToastMessage(
                                          "Invalid email address.", context)
                                    }
                                  else if (phoneTextEditingController
                                      .text.isEmpty)
                                    {
                                      displayToastMessage(
                                          "Phone number is mandatory.", context)
                                    }
                                  else if (phoneTextEditingController
                                          .text.length <
                                      10)
                                    {
                                      displayToastMessage(
                                          "At least 10 digits.", context)
                                    }
                                  else if (passwordTextEditingController
                                          .text.length <
                                      6)
                                    {
                                      displayToastMessage(
                                          "Password too short. Atleast 6 characters.",
                                          context)
                                    }
                                  else if (confirmPasswordTextEditingController
                                          .text !=
                                      passwordTextEditingController.text)
                                    {
                                      displayToastMessage(
                                          "Passwords doesn't match", context)
                                    }
                                  else
                                    {
                                      registerNewUser(context),
                                    },
                                  print(
                                    'Register in button is pressed',
                                  )
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  void registerNewUser(BuildContext context) async {
    final User firebaseUser = (await _firebaseAuth
            .createUserWithEmailAndPassword(
                email: emailTextEditingController.text,
                password: confirmPasswordTextEditingController.text)
            .catchError((errMsg) {
      displayToastMessage("Error: " + errMsg.toString(), context);
    }))
        .user;

    if (firebaseUser != null) {
      //save user info to database
      Map userDataMap = {
        "name": nameTextEditingController.text.trim(),
        "email": emailTextEditingController.text.trim(),
        "phone": phoneTextEditingController.text.trim(),
        "password": confirmPasswordTextEditingController.text.trim(),
      };
      usersRef.child(firebaseUser.uid).set(userDataMap);
      displayToastMessage("New user account has been Created", context);

      Navigator.pushNamedAndRemoveUntil(
          context, LoginScreen.idScreen, (route) => false);
    } else {
      //error occured - display error message
      displayToastMessage("New user account has not been Created.", context);
    }
  }
}

displayToastMessage(String message, BuildContext context) {
  Fluttertoast.showToast(msg: message);
}

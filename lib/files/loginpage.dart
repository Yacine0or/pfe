import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:project2/files/scrolingpage.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import '../files/formfield.dart';
import '../providers/auth_provider.dart';

class LoginPage extends StatefulWidget {
  State<StatefulWidget> createState() {
    return _loginpage();
  }
}

class _loginpage extends State<LoginPage> {
  String? _email;
  String? _password;
  late AuthProvider _auth;
  @override
  Widget build(BuildContext context) {
    _auth = Provider.of<AuthProvider>(context);
    final _loginformkey = GlobalKey<FormState>();

    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(begin: Alignment.topCenter, colors: [
          Colors.green.shade800,
          Colors.green.shade800,
          Colors.green.shade400
        ])),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 80,
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  FadeInUp(
                      duration: Duration(milliseconds: 1000),
                      child: Text(
                        "Login",
                        style: TextStyle(color: Colors.white, fontSize: 40),
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  FadeInUp(
                      duration: Duration(milliseconds: 1300),
                      child: Text(
                        "Welcome Back",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      )),
                ],
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(60),
                        topRight: Radius.circular(60))),
                child: Padding(
                  padding: EdgeInsets.all(30),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 60,
                      ),
                      FadeInUp(
                          duration: Duration(milliseconds: 1400),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                      color: Color.fromARGB(255, 194, 218, 196),
                                      blurRadius: 20,
                                      offset: Offset(0, 10))
                                ]),
                            child: Form(
                              key: _loginformkey,
                              child: Column(
                                children: <Widget>[
                                  Container(
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  color:
                                                      Colors.grey.shade200))),
                                      child: customtextfield(
                                          obscure: false,
                                          errormssg: 'Check your email1',
                                          onSaved: (value) {
                                            setState(() {
                                              _email = value;
                                            });
                                          },
                                          regEx:
                                              "^[a-zA-Z0-9.a-zA-Z0-9.!# %&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+.[a-zA-Z]+",
                                          hinttext: 'Enter your email')),
                                  Container(
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  color:
                                                      Colors.grey.shade200))),
                                      child: customtextfield(
                                          obscure: true,
                                          errormssg: 'Check your password !',
                                          onSaved: (value) {
                                            setState(() {
                                              _password = value;
                                            });
                                          },
                                          regEx:
                                              "^[a-zA-Z0-9.a-zA-Z0-9.!# %&'*+-/=?^_`{|}~]+[a-zA-Z0-9]+.[a-zA-Z]+",
                                          hinttext: 'Password')),
                                ],
                              ),
                            ),
                          )),
                      SizedBox(
                        height: 190,
                      ),
                      FadeInUp(
                          duration: Duration(milliseconds: 1600),
                          child: MaterialButton(
                            onPressed: () {
                              if (_loginformkey.currentState!.validate()) {
                                print(
                                    "email======> $_email password======> $_password");

                                _loginformkey.currentState!.save();
                                // Navigator.pushReplacement(
                                //  context,
                                // MaterialPageRoute(
                                // builder: (context) => MyHomePage()),
                                // );
                                _auth.loginUsingEmailAndPassword(
                                    _email!, _password!);
                                print("email $_email password $_password");
                              }
                            },
                            height: 50,
                            // margin: EdgeInsets.symmetric(horizontal: 50),
                            color: Colors.green[800],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                            // decoration: BoxDecoration(
                            // ),
                            child: Center(
                              child: Text(
                                "Login",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          )),
                      SizedBox(
                        height: 50,
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

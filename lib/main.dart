import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
/*import 'package:flutter/material.dart';
import 'package:project2/loginpage.dart';
import './files/splash_pages.dart ';

void main() async {
  /*MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    )*/
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  //splashpages(key: UniqueKey(), onInitializationComplete: () {})
  runApp(
   Scaffold(body: LoginPage(),)
  );
}
*/
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:project2/files/emploi_de_temp.dart';
import 'package:project2/files/home.dart';
import 'package:project2/files/profile.dart';
import 'package:project2/files/scrolingpage.dart';
import 'package:project2/files/loginpage.dart';
import 'package:flutter/material.dart';
import 'package:project2/files/splash_pages.dart';
import 'package:project2/providers/auth_provider.dart';
import 'package:provider/provider.dart';
import '../services/could_storage.dart';
import '../files/splash_pages.dart';
import '../providers/auth_provider.dart';

/*void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  return runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: pages[_selectindex],
        bottomNavigationBar: _scrollingpageState(),
      ),

      // LoginPage(),
    ),
  );
}

int _selectindex = 0;
List<Widget> pages = [
  Center(child: Text("1")),
  Center(child: Text("1")),
  Center(child: Text("1")),
  Center(child: Text("1")),
];
*/

void main() {
  //async
  //WidgetsFlutterBinding.ensureInitialized();
  //await Firebase.initializeApp();
  runApp(splashpages(
      key: UniqueKey(),
      onInitializationComplete: () {
        runApp(MyApp());
      })); //LoginPage());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvider>(create: (BuildContext _context) {
          return AuthProvider();
        })
      ],
      child: MaterialApp(home: LoginPage()),
    );
  }
}

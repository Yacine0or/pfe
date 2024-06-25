
import 'package:animate_do/animate_do.dart';
import 'package:firebase_auth/firebase_auth.dart' as f;
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
        String uid =  f.FirebaseAuth.instance.currentUser?.uid??"";

        runApp(MyApp(islogin: uid.isNotEmpty,));
      })); //LoginPage());
}

class MyApp extends StatelessWidget {
  bool islogin;
  MyApp({required this.islogin});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvider>(create: (BuildContext _context) {
          return AuthProvider();
        })
      ],
      child: MaterialApp(home: islogin?MyHomePage():LoginPage()),
    );
  }
}

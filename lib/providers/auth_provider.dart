import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:project2/files/students_info.dart';
import '../services/database_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../files/students_info.dart';

class AuthProvider extends ChangeNotifier {
  late final FirebaseAuth _auth;
  late final DatabaseService _databaseService;
  late students user;
  AuthProvider() {
    _auth = FirebaseAuth.instance;
    _databaseService = GetIt.instance.get<DatabaseService>();
    _auth.signOut();
    _auth.authStateChanges().listen((_user) {
      if (_user != null) {
        print("User loges in");
        _databaseService.getUser(_user.uid).then(
          (_snapshot) {
            Map<String, dynamic> _userdata =
                _snapshot.data()! as Map<String, dynamic>;
            user = students.fromJSON(
              {
                "uid": _user.uid,
                "nom": _userdata["nom"],
                "prenom": _userdata["prenom"],
                "email": _userdata["email"],
                "group": _userdata["group"],
                "speciality": _userdata["speciality"],
              },
            );
            print(user.toMap());
          },
        );
      } else {
        print("not authenticated");
      }
    });
  }
  Future<void> loginUsingEmailAndPassword(
      String _email, String _password) async {
    try {
      await _auth.signInWithEmailAndPassword(
          email: _email, password: _password);
      print(_auth.currentUser);
    } on FirebaseAuthException {
      print("error login user into firebase");
    } catch (e) {
      print(e.toString());
    }
  }
}

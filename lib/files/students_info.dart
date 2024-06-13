import 'package:flutter/material.dart';

class Students {
  final String uid;
  final String nom;
  final String speciality;
  final String group;

  final String prenom;
  final String email;
  Students(
      {required this.group,
      required this.speciality,
      required this.email,
      required this.uid,
      required this.nom,
      required this.prenom});
  factory Students.fromJSON(Map<dynamic, dynamic> json) {
    return Students(
        uid: json["uid"],
        nom: json["nom"],
        prenom: json["prenom"],
        email: json["email"],
        group: json["group"],
        speciality: json["speciality"]);
  }
  Map<dynamic, dynamic> toMap() {
    return {
      "nom": nom,
      "prenom": prenom,
      'id': uid,
      "email": email,
      "group": group,
      "speciality": speciality
    };
  }
}

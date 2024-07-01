import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project2/files/loginpage.dart';

class ProfileData{
  String nom,prenom,email,matricule,groupe;

  ProfileData({required this.nom,required this.prenom,required this.email,required this.matricule,required this.groupe});
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  Future<ProfileData> getData() async{
    String uid =  FirebaseAuth.instance.currentUser?.uid??"";
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    DocumentSnapshot<Map<String, dynamic>> data = await firestore.collection("étudiants").doc(uid).get();
    return ProfileData(nom: data.get("nom_etudiant"), prenom: data.get("prenom_etudiant"), email: data.get("email_etudiant"), matricule: data.get("mat_etudiant"),groupe: data.get("group"));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: FutureBuilder<ProfileData>(
        future: getData(),
        builder: (BuildContext context, AsyncSnapshot<ProfileData> snapshot) {
          if(snapshot.connectionState == ConnectionState.done){
            ProfileData? data = snapshot.data;
            return SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  Container(
                    width: 120,
                    height: 120,
                    margin: EdgeInsets.only(bottom: 20,top: 40),
                    decoration: BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                        image: DecorationImage(image: AssetImage("lib/asset/icsemep.png"),fit: BoxFit.contain)
                    ),
                  ),

                  item(Icons.person, "Nom", "${data?.nom}"),
                  item(Icons.person, "Prenom", "${data?.prenom}"),
                  item(Icons.credit_card_rounded, "Matricule", "${data?.matricule}"),
                  item(Icons.email_sharp, "Email", "${data?.email}"),
                  item(Icons.group, "Groupe", "${data?.groupe}"),

                  SizedBox(height: 10,),
                  ElevatedButton(onPressed: () async{
                     await FirebaseAuth.instance.signOut();
                     Navigator.pushAndRemoveUntil(context,CupertinoPageRoute(builder: (context)=>LoginPage()),(route)=>false);
                  }, child: Text('Logout',style: TextStyle(color: Colors.white),),style: ButtonStyle(backgroundColor: MaterialStateColor.resolveWith((states) => Colors.redAccent),shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(12),)),minimumSize: MaterialStateProperty.all<Size>(Size(MediaQuery.of(context).size.width*0.97, 45))),)


                ],
              ),
            );
          }
          return Center(child: CircularProgressIndicator(),);

        },


      ),
    );
  }

  Widget item(IconData icon,String title,String subtitle){
    return  Container(
        margin: EdgeInsets.all(4),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
                color: Colors.grey,
                width: 1
            )
        ),
        child:  ListTile(
          leading: Icon(icon,size: 25,color: Colors.green,),
          title: Text(title,style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
          subtitle: Text(subtitle,style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.black),),
        ));
  }
}

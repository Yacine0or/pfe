import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project2/files/scane.dart';
import 'package:project2/models/science_object.dart';
import 'package:image_picker/image_picker.dart';
import 'package:qr_bar_code_scanner_dialog/qr_bar_code_scanner_dialog.dart';

class ScienceModel extends StatelessWidget {
  ScienceObject science;
  VoidCallback ontap;
  ScienceModel({Key? key,required this.science,required this.ontap}) : super(key: key);
  final _qrBarCodeScannerDialogPlugin = QrBarCodeScannerDialog();





  @override
  Widget build(BuildContext context) {
    return  Container(
      margin: EdgeInsets.all(5),
      padding: EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.circular(8)
      ),
      child: Column(
        children: [
          ListTile(
            onTap: (){
              ontap();
            },
            leading: FloatingActionButton(
              backgroundColor: Colors.grey.shade100.withOpacity(.5),
              onPressed: () async{
                XFile? xfile = await ImagePicker.platform.getImageFromSource(source: ImageSource.camera);
                if(xfile != null){
                  File f = File(xfile.path);
                  String link = await uploadFile(f.path);
                  FirebaseFirestore firestore = FirebaseFirestore.instance;
                  String uid =  FirebaseAuth.instance.currentUser?.uid??"";

                  firestore.collection("séances").doc(science.id).collection("justification").add(
                      {
                        "image" : link,
                        "etudiant":uid

                      });
                }

              },
              child: Icon(Icons.assignment_late,color: Colors.white,),
            ),
            title: Text(science.name,style: TextStyle(fontSize: 20,color: Colors.white),),
            subtitle: Text("${science.day} ${science.time}",style: TextStyle(fontSize: 18,color: Colors.white)),
            trailing: Container(
              height: 55,
              width: 55,
              child: FloatingActionButton(
                backgroundColor: Colors.black26,
                onPressed: () async{
                  try{
                    _qrBarCodeScannerDialogPlugin.getScannedQrBarCode(
                        context: context,
                        onCode: (code) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("success $code")));

                        });

                  }catch(e){
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("error $e")));

                  }

                  //Navigator.push(context, CupertinoPageRoute(builder: (context)=>Scane(idScience: science.id,qr: science.qr,)));
                },
                child: Icon(Icons.arrow_forward,color: Colors.white,),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<String> uploadFile(String path) async{
    FirebaseStorage firebaseStorage = FirebaseStorage.instance;
    String uid =  FirebaseAuth.instance.currentUser?.uid??"";

    final ref = firebaseStorage.ref().child("upload/justification/"+uid+science.id);

    TaskSnapshot taskSnapshot = await  ref.putFile(File(path)).whenComplete((){

    });
    String url = await taskSnapshot.ref.getDownloadURL();
    return url;
  }
}

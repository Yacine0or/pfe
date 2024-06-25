import 'package:ai_barcode_scanner/ai_barcode_scanner.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Scane extends StatefulWidget {
  String idScience,qr;
  Scane({Key? key,required this.idScience,required this.qr}) : super(key: key);

  @override
  State<Scane> createState() => _ScaneState();
}

class _ScaneState extends State<Scane> {

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose().then((val){
      super.dispose();

    });
  }

  MobileScannerController controller = MobileScannerController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AiBarcodeScanner(
          controller: controller,
          onDetect: (BarcodeCapture barcodeCapture) async{
            if(barcodeCapture.barcodes.first.displayValue != null ){
              if( barcodeCapture.barcodes.first.displayValue.toString() == widget.qr){
              String ui = FirebaseAuth.instance.currentUser?.uid??"";
              FirebaseFirestore firestore = FirebaseFirestore.instance;
              await firestore.collection("séances").doc(widget.idScience).collection("presence").add({'etudiant':ui});
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("present success")));
              Navigator.pop(context);}else{
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("incorrect qr")));

              }
            }else{

              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("error scaning")));

            }

          },
        ),
      )
    );
  }
}


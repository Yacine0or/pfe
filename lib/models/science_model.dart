import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project2/files/scane.dart';
import 'package:project2/models/science_object.dart';
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
}

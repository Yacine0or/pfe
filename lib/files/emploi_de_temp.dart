import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../models/science_model.dart';
import '../models/science_object.dart';

class SearchScreen extends StatefulWidget {

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  String search = "";

  Future<List<ScienceObject>> getData() async{
    List<ScienceObject> list = [];
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    QuerySnapshot<Map<String,dynamic>> querySnapshot = await firestore.collection("séances").where('name', isGreaterThanOrEqualTo: search)
        .where('name', isLessThan: search + '\uf8ff').get();
    for (var element in querySnapshot.docs) {
      list.add(
          ScienceObject(name: element.get("name"), time: element.get("time"), type: element.get("type"), id: element.get("id"), day: element.get("day"),room: element.get("room"),qr:  element.get("qr"),branche: element.get("branche"))
      );
    }
    return list;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          decoration: InputDecoration(
            hintText: "Rechercher Dans les Science",
            border: InputBorder.none
          ),
          onEditingComplete: (){

          },
          onChanged: (data) {

            setState(() {
              search = data;

            });

          },
        ),
      ),
      body: FutureBuilder<List<ScienceObject>>(
        future: getData(),
        builder: (BuildContext context, AsyncSnapshot<List<ScienceObject>> snapshot) {
          if(snapshot.connectionState == ConnectionState.done){
            return snapshot.data?.isEmpty??true?Center(
              child: Text("Aucun Resultat"),
            ):ListView.builder(

                itemCount: snapshot.data?.length??0,
                itemBuilder: (context,position){
                  return ScienceModel(science:snapshot.data![position],ontap: (){
                   ScienceObject object = snapshot.data![position];
                    showBottomSheet(context: context, builder: (context)=>Container(
                        color: Colors.grey.shade100,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              margin: EdgeInsets.only(top: 10),
                              height: 3,
                              color: Colors.grey,
                              width: 100,
                            ),
                            SizedBox(height: 10,),
                            item(Icons.credit_card_rounded, "Science",object.name ),
                            item(Icons.book, "Type",object.type ),
                            item(Icons.date_range, "Date","${object.day} ${object.time}" ),
                            item(Icons.maps_home_work_rounded, "Salle",object.room ),

                          ],
                        )


                    ));
                  },);
                });
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },


      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:time_scheduler_table/time_scheduler_table.dart';

import '../models/science_model.dart';
import '../models/science_object.dart';

class SearchScreen extends StatefulWidget {

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  String search = "";

  Future<List<EventModel>> getData() async{
    String uid =  FirebaseAuth.instance.currentUser?.uid??"";
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    DocumentSnapshot<Map<String, dynamic>> da = await firestore.collection("étudiants").doc(uid).get();

    List<EventModel> list = [];
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await firestore.collection('séances').where("group",isEqualTo: da.get("group")).get();

    var data = querySnapshot.docs;

    for(int i =0;i<6;i++){
      for(int j=0;j<6;j++){
        data.forEach((data){
          if(data["time"] == hours[j] && data["day"] == days[i]){
            list.add(
                EventModel(
                  title: data["name"] + " (${data["type"]})",
                  columnIndex: j,
                  rowIndex: i,
                  color: Colors.green,
                )
            );
          }

        });
      }
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

  var days = const [ // You can assign any value to columnTitles. For Example : ['Column 1','Column 2','Column 3', ...]
    "Saturday",
    "Sunday",
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday"
  ];

  var hours = const [ // You can assign any value to rowTitles. For Example : ['Row 1','Row 2','Row 3', ...]
    "08:00 - 09:30",
    "09:40 - 11:10",
    "11:20 - 12:50",
    "13:00 - 14:30",
    "14:40 - 16:10",
    "16:20 - 17:50"
  ];

  TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<EventModel>>(
        future: getData(),
        builder: (BuildContext context, AsyncSnapshot<List<EventModel>> snapshot) {
          if(snapshot.connectionState == ConnectionState.done){
            return TimeSchedulerTable(

              scrollColor: Colors.transparent,
              cellHeight: 74,
              cellWidth: 82,
              columnTitles: days,
              currentColumnTitleIndex: DateTime.now().weekday - 1,
              rowTitles: hours,
              title: "Emploi du Temp",
              isScrollTrackingVisible: false,

              titleStyle: const TextStyle(
                  fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black),
              eventTitleStyle: const TextStyle(color: Colors.white, fontSize: 10,fontWeight: FontWeight.bold),
              isBack: false, // back button
              eventList: snapshot.data!,
              eventAlert: EventAlert(
                alertTextController: textController,
                borderRadius: const BorderRadius.all(
                  Radius.circular(12.0),
                ),


              ),
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },


      ),
    );
  }
}

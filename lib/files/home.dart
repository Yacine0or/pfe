import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:project2/models/science_model.dart';
import 'package:intl/intl.dart';

import '../models/science_object.dart';



class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<HomeScreen> {

  final EasyInfiniteDateTimelineController _controller = EasyInfiniteDateTimelineController();
  var today = DateTime(2024,06,25);
  var dayName = "Tuesday";

  Future<List<ScienceObject>> getData() async{
    List<ScienceObject> list = [];
    debugPrint("name : ${dayName.substring(0,3)}");
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await firestore
          .collection("séances")
          .where('day', isEqualTo: dayName)
          .get();

      debugPrint("size : ${querySnapshot.docs.length}");
      for (var element in querySnapshot.docs) {
        list.add(
            ScienceObject(name: element.get("name"), time: element.get("time"), type: element.get("type"), id: element.get("id"), day: element.get("day"),room: element.get("room"),qr: element.get("qr"),branche: element.get("branch"))
        );
      }

    } catch (e) {
      print('Error fetching data: $e');
    }


    return list;
  }

  late ScienceObject object;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Welcome Back ! ",style: TextStyle(fontWeight: FontWeight.bold),),
        actions: [
          IconButton(onPressed: () async{



          }, icon: Icon(Icons.notifications,color: Colors.grey,))
        ]
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          EasyInfiniteDateTimeLine(

            activeColor: Colors.green,
            controller: _controller,
            firstDate: DateTime(2024,06,25),
            focusDate: today,
            lastDate: DateTime(2024,06,31),


            onDateChange: (selectedDate) {
              setState(() {
                today = selectedDate;
                dayName = DateFormat('EEEE').format(today);
              });
            },
          ),
          Padding(
            padding: const EdgeInsets.only(left: 13,top: 8),
            child: Text("Séance du jour",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
          ),
          Expanded(
              flex: 6,
              child: FutureBuilder<List<ScienceObject>>(
                future: getData(),
                builder: (BuildContext context, AsyncSnapshot<List<ScienceObject>> snapshot) {
                  if(snapshot.connectionState == ConnectionState.done){
                    return snapshot.data?.isEmpty??true?Center(child: Text("Aucune Séance"),):ListView.builder(
                        itemCount: snapshot.data?.length??0,
                        itemBuilder: (context,position){
                          return ScienceModel(science:snapshot.data![position],ontap: (){
                            setState(() {
                              object = snapshot.data![position];
                            });
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
                                    item(Icons.credit_card_rounded, "Séance",object.name ),
                                    item(Icons.book, "Type",object.type ),
                                    item(Icons.dashboard, "Branche",object.branche ),
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
                
                
              )
          )
        ],
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

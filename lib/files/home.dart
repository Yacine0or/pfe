import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:project2/models/science_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<HomeScreen> {

  final EasyInfiniteDateTimelineController _controller = EasyInfiniteDateTimelineController();
  var today = DateTime.now();

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
            firstDate: DateTime(2024,5,1),
            focusDate: today,

            lastDate: DateTime(DateTime.now().year,DateTime.december,31),
            disabledDates: [

            ],

            onDateChange: (selectedDate) {
              setState(() {
                today = selectedDate;
              });
            },
          ),
          Padding(
            padding: const EdgeInsets.only(left: 13,top: 8),
            child: Text("Science",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
          ),
          Expanded(
              flex: 6,
              child: ListView.builder(

                  itemCount: 4,
                  itemBuilder: (context,position){
                    return ScienceModel(title: 'Intelegence Arteficiel', date: '22-05-2024 13:30', uid: 'Chronologie');
                  }))
        ],
      ),
    );
  }
}

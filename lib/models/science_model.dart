import 'package:flutter/material.dart';

class ScienceModel extends StatelessWidget {
  String title ,date,uid;
  ScienceModel({Key? key,required this.title,required this.date,required this.uid}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
      margin: EdgeInsets.all(5),
      padding: EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.circular(8)
      ),
      child: ListTile(
        title: Text(title,style: TextStyle(fontSize: 20,color: Colors.white),),
        subtitle: Text(date,style: TextStyle(fontSize: 18,color: Colors.white)),
        trailing: Container(
          height: 55,
          width: 55,
          child: FloatingActionButton(
            backgroundColor: Colors.black26,
            onPressed: () {},
            child: Icon(Icons.arrow_forward,color: Colors.white,),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Profile ",style: TextStyle(fontWeight: FontWeight.bold),),),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          
          Container(
            width: 120,
            height: 120,
            margin: EdgeInsets.only(bottom: 20),
            decoration: BoxDecoration(
              color: Colors.green,
              shape: BoxShape.circle,
              image: DecorationImage(image: AssetImage("lib/asset/icsemep.png"),fit: BoxFit.contain)
            ),
          ),
          
          item(Icons.person, "First & Last name", "Abdeslam Khoudja"),
          item(Icons.calendar_month, "Date naissance", "12-06-2003"),
          item(Icons.place, "Adress", "Ain naadja , Les tours"),

          item(Icons.email_sharp, "Email", "khodja@gmail.com"),
          SizedBox(height: 10,),
          ElevatedButton(onPressed: (){
           // Navigator.pushReplacement(context, CupertinoPageRoute(builder: (context)=>Login()));
          }, child: Text('Logout',style: TextStyle(color: Colors.white),),style: ButtonStyle(backgroundColor: MaterialStateColor.resolveWith((states) => Colors.redAccent),shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(12),)),minimumSize: MaterialStateProperty.all<Size>(Size(MediaQuery.of(context).size.width*0.97, 45))),)


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

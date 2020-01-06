import 'package:flutter/material.dart';
import 'package:photo_album/pages/dinner_photos.dart';
import 'package:photo_album/pages/picnic_photos.dart';
import 'package:photo_album/pages/sign_out_photos.dart';

class GroupPhoto extends StatefulWidget {
  @override
  _GroupPhotoState createState() => _GroupPhotoState();
}

class _GroupPhotoState extends State<GroupPhoto> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.greenAccent,
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          children: <Widget>[
            Text(
              "Group Photographs",
              style: TextStyle(fontSize: 30, color: Colors.black45),
            ),
            SizedBox(
              height: 25,
            ),
            buildContainer("assets/images/one.jpg","Dinner",(){
         Navigator.push(context, MaterialPageRoute(builder: (context)=> DinnerPhoto()));
            }),
            SizedBox(
              height: 20,
            ),
            buildContainer("assets/images/four.jpg","Picnic",(){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> PicnicPhoto()));
            }),
            SizedBox(
              height: 20,
            ),
            buildContainer("assets/images/two.jpg","Signout",(){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> SignOutPhoto()));
            })
          ],
        ),
      ),
    );
  }

  Widget buildContainer(String url, String title, Function function) {
    return InkWell(
      onTap: function,
      child: Container(
        alignment: Alignment.center,
        height: 150,
        padding: EdgeInsets.only(left: 20, top: 20),
        child: Text(
          title,
          style: TextStyle(fontSize: 30, color: Colors.black, fontFamily: "Campton"),
        ),
        decoration: BoxDecoration(
           color: Colors.green,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(35.0), bottomRight: Radius.circular(35.0)),
          //image: DecorationImage(image: AssetImage(url), fit: BoxFit.cover),
        ),
      ),
    );
  }
}

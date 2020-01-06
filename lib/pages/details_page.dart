import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_album/models/student.dart';

class DetailsPage extends StatelessWidget {
  final Student student;
  final int index;

  DetailsPage({this.student, this.index});

  @override
  Widget build(BuildContext context) {
    print("profile_pic$index");
    return Scaffold(
      backgroundColor: Colors.greenAccent,
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 30,
          ),
          Container(
            height: 100,
            child: Stack(
              children: <Widget>[
                Positioned(
                  top: 15.0,
                  bottom: 15.0,
                  left: 5.0,
                  child: IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: Icon(Icons.arrow_back_ios),
                  ),
                ),
                Align(
                  alignment: Alignment(0.0, 0.0),
                  child: Text(
                    "About Me",
                    style: TextStyle(fontSize: 25, fontFamily: "Campton"),
                  ),
                )
              ],
            ),
          ),
          Container(
            height: 170,
            width: 170,
            alignment: Alignment.center,
            child: Hero(
              tag: "profile_pic$index",
              child: ClipOval(
                child:student.imgUrl!=null ?
                CachedNetworkImage(imageUrl: student.imgUrl,)
                    : Image.asset(
                  "assets/images/user_placeholder.jpg",
                )
               /* Image.asset(
                  "assets/images/bil.jpg",
                  width: 200,
                  height: 200,
                  fit: BoxFit.cover,
                ),*/
              ),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Expanded(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 16),
              child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  width: double.infinity,
                  // height: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20.0),
                          topRight: Radius.circular(20.0))),
                  // height: 600,
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.0),
                        topRight: Radius.circular(20.0)),
                    child: ListView(
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 2),
                        //     crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Name:",
                            style: TextStyle(fontSize: 15, letterSpacing: 1),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            student.name,
                            style:
                                TextStyle(fontSize: 18, fontFamily: "Campton"),
                          ),
                          Divider(),
                          Text(
                            "State of origin:",
                            style: TextStyle(fontSize: 15, letterSpacing: 1),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            student.state,
                            style:
                                TextStyle(fontSize: 18, fontFamily: "Campton"),
                          ),
                          Divider(),
                          Text(
                            "Birthday:",
                            style: TextStyle(fontSize: 15, letterSpacing: 1),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            student.birthday,
                            style:
                                TextStyle(fontSize: 18, fontFamily: "Campton"),
                          ),
                          Divider(),
                          Text(
                            "Hobbies:",
                            style: TextStyle(fontSize: 15, letterSpacing: 1),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            student.hobbies,
                            style:
                                TextStyle(fontSize: 18, fontFamily: "Campton"),
                          ),
                          Divider(),
                          Text(
                            "Class crush:",
                            style: TextStyle(fontSize: 15, letterSpacing: 1),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            student.classCrush,
                            style:
                                TextStyle(fontSize: 18, fontFamily: "Campton"),
                          ),
                          Divider(),
                          Text(
                            "Best Course:",
                            style: TextStyle(fontSize: 15, letterSpacing: 1),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            student.bestCourse,
                            style:
                                TextStyle(fontSize: 18, fontFamily: "Campton"),
                          ),
                          Divider(),
                          Text(
                            "Likes:",
                            style: TextStyle(fontSize: 15, letterSpacing: 1),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            student.likes,
                            style:
                                TextStyle(fontSize: 18, fontFamily: "Campton"),
                          ),
                          Divider(),
                          Text(
                            "Dislikes:",
                            style: TextStyle(fontSize: 15, letterSpacing: 1),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            student.dislikes,
                            style:
                                TextStyle(fontSize: 18, fontFamily: "Campton"),
                          ),
                          Divider(),
                          Text(
                            "Contact Address:",
                            style: TextStyle(fontSize: 15, letterSpacing: 1),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            student.address ??
                                "No. 66,MM street behind geoscience,Anguldi-Bukuru, Jos Plateau State",
                            style: TextStyle(
                              fontSize: 18,
                              fontFamily: "Campton",
                            ),
                          ),
                          Divider(),
                          Text(
                            "Phone Number:",
                            style: TextStyle(fontSize: 15, letterSpacing: 1),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "0${student.phoneNumber}",
                            style:
                                TextStyle(fontSize: 18, fontFamily: "Campton"),
                          ),
                          Divider(),
                          Text(
                            "Email Address:",
                            style: TextStyle(fontSize: 15, letterSpacing: 1),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            student.emailAddress,
                            style:
                                TextStyle(fontSize: 18, fontFamily: "Campton"),
                          ),
                          Divider(),
                        ]),
                  )),
            ),
          ),
        ],
      ),
    );
  }
}

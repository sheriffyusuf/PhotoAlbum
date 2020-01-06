import 'package:cached_network_image/cached_network_image.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:photo_album/models/student.dart';
import 'package:photo_album/pages/edit_profile.dart';
import 'package:photo_album/repository/user_repository.dart';
import 'package:provider/provider.dart';

class UserProfile extends StatefulWidget {
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController phoneController =TextEditingController();

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<UserRepository>(context);
    bool _isLoading = false;
//    final getUser= user.getProfile();
    return FutureBuilder(
        future: user.getProfile(),
        builder: (context, snapshot) {

          // print("orange"+student.imgUrl.toString());
          if(!snapshot.hasData){
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          Student student = snapshot.data;
        /*  switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.active:
            case ConnectionState.waiting:
              return Center(
                child: CircularProgressIndicator(),
              );
            case ConnectionState.done:
              if (snapshot.hasError) return Text('Error: ${snapshot.error}');*/
              nameController.value = TextEditingValue(
                text: student.name,
                selection: TextSelection.fromPosition(
                  TextPosition(offset: student.name.length),
                ),
              );
              addressController.value = TextEditingValue(
                text: student.address,
                selection: TextSelection.fromPosition(
                  TextPosition(offset: student.name.length),
                ),
              );

              phoneController.value = TextEditingValue(
                text: "0${student.phoneNumber}" ?? "",
                selection: TextSelection.fromPosition(
                  TextPosition(offset: student.name.length),
                ),
              );
              return  SafeArea(
                  child: ListView(
                    padding:
                    EdgeInsets.symmetric(vertical: 30.0, horizontal: 10.0),
                    shrinkWrap: true,
                    children: <Widget>[
                      Container(
                        height: 30,
                        child: Row(
                          children: <Widget>[
                            Spacer(flex: 1),
                            Text(
                              "My Profile",
                              style: TextStyle(fontSize: 25),
                            ),
                            Spacer(
                              flex: 10,
                            ),
                            InkWell(
                                onTap: () {
                                  user.signOut();
                                },
                                child: Icon(FontAwesomeIcons.signOutAlt)),
                            Spacer(flex: 1),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: 200,
                        height: 200,
                        child: student.imgUrl!=null ?
                        CachedNetworkImage(imageUrl: student.imgUrl,)
                            : Image.asset(
                          "assets/images/user_placeholder.jpg",
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(35.0),
                        width: double.infinity,
                        //   height: 600,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(50.0),
                                topLeft: Radius.circular(50.0))),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "Email Address",
                              style: TextStyle(fontSize: 18),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                              user.user.email,
                              style: TextStyle(
                                  fontSize: 18, fontStyle: FontStyle.italic),
                            ),
                            SizedBox(height: 8),
                            Text(
                              "Name",
                              style: TextStyle(fontSize: 18),
                            ),
                            TextField(
                              enabled: false,
                              controller: nameController,
                              onChanged: (value) {
                                student.name = value.trim();
                              },
                            ),
                            SizedBox(height: 8,),
                            Text(
                              "Phone Number",
                              style: TextStyle(fontSize: 18),
                            ),
                            TextField(
                              enabled: false,
                              controller: phoneController,
                              onChanged: (value) {
                                student.phoneNumber = value.trim();
                              },
                            ),
                            SizedBox(height: 15),
                            Text(
                              "Address",
                              style: TextStyle(fontSize: 18),
                            ),
                            TextField(
                              enabled: false,
                              keyboardType: TextInputType.multiline,
                              maxLines: null,
                              controller: addressController,
                              onChanged: (value) {
                                student.address = value.trim();
                              },
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              alignment: Alignment.center,
                              child: RaisedButton(
                                onPressed: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=> EditProfile(student: student,phone: user.user.uid.toString(),),fullscreenDialog: true));
                                  print("Updating details");
                                  /*  user.updateProfile(student).then((_){
                                    Flushbar(message: "Update Profile Successfully",duration: Duration(seconds: 3),).show(context);
                                  });
*/
                                },
                                color: Colors.greenAccent,
                                child: Text("Edit Profile"),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                );

          });
   return null;
        }
  }

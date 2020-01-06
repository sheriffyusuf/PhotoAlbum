import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:photo_album/models/student.dart';
import 'package:photo_album/models/student.dart';
import 'package:photo_album/repository/user_repository.dart';
import 'package:photo_album/services/database_service.dart';
import 'package:photo_album/services/storage_services.dart';
import 'package:provider/provider.dart';

class EditProfile extends StatefulWidget {
  final Student student;
  final String phone;

  EditProfile({this.phone, this.student});
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {

  final _formKey = GlobalKey<FormState>();
  File _profileImage;
  String _phoneNumber = '';
  String _address = '';
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _phoneNumber = "0${widget.phone}";
    //print(widget.student.phoneNumber);
    _address = widget.student.address;
  }

  _handleImageFromGallery() async {
  //  Navigator.pop(context);
    File imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (imageFile != null) {
      imageFile = await _cropImage(imageFile);
      setState(() {
        _profileImage = imageFile;
        print(_profileImage.toString());
      });
    }
  }

  _cropImage(File imageFile) async {
    File croppedImage = await ImageCropper.cropImage(
      sourcePath: imageFile.path,
      aspectRatio: CropAspectRatio(ratioX: 1.0, ratioY: 1.0),
    );
    return croppedImage;
  }

  _displayProfileImage() {
    // No new profile image
    if (_profileImage == null) {
      // No existing profile image
      if (widget.student.imgUrl == null) {
        // Display placeholder
        return AssetImage('assets/images/user_placeholder.jpg');
      } else {
        // User profile image exists
        return CachedNetworkImageProvider(widget.student.imgUrl);
      }
    } else {
      // New profile image
      return FileImage(_profileImage);
    }
  }

  _submit(String uid) async {
    if (_formKey.currentState.validate() && !_isLoading) {
      _formKey.currentState.save();

      setState(() {
        _isLoading = true;
      });

      // Update user in database
      String _profileImageUrl = '';

      if (_profileImage == null) {
        _profileImageUrl = widget.student.imgUrl ?? "";
      } else {
        _profileImageUrl = await StorageService.uploadUserProfileImage(
          widget.student.imgUrl ?? "",
          _profileImage,
        );
      }

      Student student = Student(
        phoneNumber: _phoneNumber.substring(1),
       // name: _address,
          address: _address,
        imgUrl: _profileImageUrl
      );
      // Database update
      await DatabaseService.updateUser(student, uid);

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<UserRepository>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.greenAccent,
        title: Text(
          'Edit Profile',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: ListView(
          children: <Widget>[
            _isLoading
                ? LinearProgressIndicator(
              backgroundColor: Colors.blue[200],
              valueColor: AlwaysStoppedAnimation(Colors.blue),
            )
                : SizedBox.shrink(),
            Padding(
              padding: EdgeInsets.all(30.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    CircleAvatar(
                      radius: 60.0,
                      backgroundColor: Colors.grey,
                     backgroundImage: _displayProfileImage(),
                    ),
                    FlatButton(
                      onPressed: _handleImageFromGallery,
                      child: Text(
                        'Change Profile Image',
                        style: TextStyle(
                            color: Theme.of(context).accentColor,
                            fontSize: 16.0),
                      ),
                    ),
                    TextFormField(
                      initialValue: _phoneNumber,
                      style: TextStyle(fontSize: 18.0),
                      decoration: InputDecoration(
                        icon: Icon(
                          Icons.phone,
                          size: 30.0,
                        ),
                        labelText: 'Phone Number',
                      ),
                      validator: (input) => input.trim().length == 12
                          ? 'Please enter a valid phone number'
                          : null,
                      onSaved: (input) => _phoneNumber = input,
                    ),
                    TextFormField(
                      initialValue: _address,
                      style: TextStyle(fontSize: 18.0),
                      decoration: InputDecoration(
                        icon: Icon(
                          FontAwesomeIcons.locationArrow,
                          size: 30.0,
                        ),
                        labelText: 'Address',
                      ),
                      validator: (input) => input.trim().length < 4
                          ? 'Please enter a valid address'
                          : null,
                      onSaved: (input) => _address = input,
                    ),
                    Container(
                      margin: EdgeInsets.all(40.0),
                      height: 40.0,
                      width: 250.0,
                      child: FlatButton(
                        onPressed: (){
                           _submit(user.user.uid.toString());
                        },
                        color: Colors.blue,
                        textColor: Colors.white,
                        child: Text(
                          'Save Profile',
                          style: TextStyle(fontSize: 18.0),
                        ),
                      ),
                    ),

                    Container(
                      margin: EdgeInsets.all(40.0),
                      height: 40.0,
                      width: 250.0,
                      child: FlatButton(
                        onPressed: () async {
                          setState(() {
                            _isLoading = true;
                          });
                          await user.resetPassword(user.user.email);
                          setState(() {
                            _isLoading = false;
                          });
                          Flushbar(message: "Password reset link has been sent to your email address",title: "Password reset",duration: Duration(seconds: 5),)..show(context);
                        },
                        color: Colors.green,
                        textColor: Colors.white,
                        child: Text(
                          'Reset Password',
                          style: TextStyle(fontSize: 18.0),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

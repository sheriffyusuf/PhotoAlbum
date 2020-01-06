import 'package:flutter/material.dart';
import 'package:photo_album/constants/colors.dart';
import 'package:photo_album/constants/strings.dart';
import 'package:photo_album/pages/dashboard.dart';
import 'package:photo_album/repository/user_repository.dart';
import 'package:photo_album/widgets/raised_gradient_button.dart';
import 'package:provider/provider.dart';

class AuthScreen extends StatefulWidget {

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  static final _formKey = GlobalKey<FormState>();
  static final  _key = GlobalKey<ScaffoldState>();
  TextStyle hintStyle = TextStyle(
      color: Colors.grey.shade500, fontFamily: 'CamptonLight', fontSize: 18);
  TextEditingController _email;
  TextEditingController _password;
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);



  @override
  void initState() {
    super.initState();
    _email = TextEditingController(text: "");
    _password = TextEditingController(text: "");
  }

  @override
  Widget build(BuildContext context) {
    //  var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    final user = Provider.of<UserRepository>(context);
    return Scaffold(
      key: _key,
        //  resizeToAvoidBottomPadding: true,
        body: GestureDetector(
          onTap: ()=> FocusScope.of(context).unfocus(),
          child: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                //  Colors.blueAccent.shade400,
                Colors.green.shade400,
                Colors.green.shade200
                //  Color.fromRGBO(144, 107, 255, 1),
                //Color.fromRGBO(128, 193, 255, 1),
                //   Colors.blue.shade400
              ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30.0, vertical: 30.0),
                child: Form(
                  key: _formKey,
                  child: ListView(
                      children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Image.asset("assets/images/abu_logo.png", height: 100,),
                        SizedBox(
                          height: 30,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              Strings.hello,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Campton',
                                  fontSize: 40,
                                  fontWeight: FontWeight.w200),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Text(
                              Strings.log_to_continue,
                              style: Theme.of(context).textTheme.display2,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 80,
                        ),
                        Container(
                          width: double.infinity,
                          height: height / 2.5,
                          // color: Colors.white,
                          decoration: BoxDecoration(
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                  color: Colors.black26,
                                  offset: Offset(1.0, -1.0),
                                  blurRadius: 10.0,
                                ),
                              ],
                              color: Colors.white,
                              borderRadius: BorderRadius.all(Radius.circular(10.0))),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                TextFormField(
                                  controller: _email,
                                  style: style,
                                  validator: (value) =>
                                  (value.isEmpty) ? "Please enter an email address" : null,
                                  decoration: InputDecoration(
                                    hintText: Strings.email_address,
                                    hintStyle: hintStyle,
                                    /*border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.teal,
                                      ),
                                    ),*/
                                  ),
                                ),
                                TextFormField(
                                  obscureText: true,
                                  controller: _password,
                                  style: style,
                                  validator: (value) =>
                                  (value.isEmpty) ? "Please Enter Password" : null,
                                  decoration: InputDecoration(
                                      hintText: Strings.password,
                                      hintStyle: hintStyle,
                                      /* border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.teal,
                                        ),
                                      ),*/
                                      focusColor: Colors.blue
                                      //  focusedBorder: UnderlineInputBorder(b)
                                      ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                    "",//  Strings.forgot_password,
                                      style: Theme.of(context).textTheme.display3,
                                    ),
                                    user. status == Status.Authenticating? CircularProgressIndicator() : RaisedGradientButton(
                                      width: 55,
                                      height: 50,
                                      child: Icon(
                                        Icons.send,
                                        color: white,
                                      ),
                                      gradient: LinearGradient(colors: [
                                        Color.fromRGBO(144, 107, 255, 1),
                                        Color.fromRGBO(128, 193, 255, 1),
                                      ]),
                                      onPressed: () async {
                                        if (_formKey.currentState.validate()) {
                                          if (!await user.signIn(
                                          _email.text, _password.text))
                                        _key.currentState.showSnackBar(SnackBar(
                                        content: Text("Something is wrong"),
                                        ));
                                      }
                                       /* Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => Dashboard()));*/
                                      },
                                    )
                                    /*  Container(
                                      height:50,
                                      width: 55,
                                      child: RaisedButton(
                                        color: Colors.blue, onPressed: () {},
                                      ),
                                    )*/
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ]),
                ),
              )),
        ));
  }

  @override
  void dispose(){
    _email.dispose();
    _password.dispose();
    super.dispose();
  }
}

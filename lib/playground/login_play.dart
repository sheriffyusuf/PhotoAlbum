import 'package:flutter/material.dart';

class LoginPlay extends StatefulWidget {
  @override
  _LoginPlayState createState() => _LoginPlayState();
}

class _LoginPlayState extends State<LoginPlay> {
  @override
  Widget build(BuildContext context) {
    //  print(MediaQuery.of(context).size.height * 0.625);
    return Scaffold(
      //043A22 dark green
      //53C66D light green

      backgroundColor: Color(0xFF043A22),
      body: Stack(children: [
        Align(
          alignment: Alignment.bottomCenter,
          child: ClipPath(
            clipper: Mclipper(),
            child: Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.625,
              color: Color(0xFF53C66D),
            ),
          ),
        ),
        Positioned(
          top: 100,
          left: 30,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Welcome",
                style: TextStyle(color: Colors.white, fontSize: 40),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                "Login to access your account",
                style: TextStyle(color: Colors.white),
              )
            ],
          ),
        ),
        Align(
          alignment: Alignment(0, 0.3),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              width: double.infinity,
              height: 400,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.white,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Spacer(
                    flex: 2,
                  ),
                  Container(
                    width: double.infinity,
                    child: Text(
                      "Email Address",
                      textAlign: TextAlign.start,
                    ),
                  ),
                  TextField(),
                  Spacer(
                    flex: 1,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("Password"),
                      Text(
                        "Forgot Password?",
                        style: TextStyle(color: Color(0xFF53C66D)),
                      ),
                    ],
                  ),
                  TextField(),
                  Spacer(
                    flex: 1,
                  ),
                  Container(
                    alignment: Alignment.center,
                    height: 50,
                    width: 200,
                    decoration: BoxDecoration(
                      color: Color(0xFF043A22),
                      borderRadius: BorderRadius.circular(75),
                    ),
                    child: Text(
                      "Sign In",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Spacer(
                    flex: 1,
                  ),
                  Text("or"),
                  Spacer(
                    flex: 1,
                  ),
                  Container(
                    width: 200,
                    height: 50,
                    child: OutlineButton(
                      color: Color(0xFF043A22),
                      borderSide: BorderSide(
                        color: Color(0xFF043A22),
                        style: BorderStyle.solid,
                        width: 1.5,
                      ),
                      highlightedBorderColor: Color(0xFF043A22),
                      child: Text(
                        "Sign in with Google",
                        style: TextStyle(color: Color(0xFF043A22)),
                      ),
                      onPressed: () {},
                      shape: StadiumBorder(),
                    ),
                  ),
                  /*   RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0)),
                  ) */
                  Spacer(
                    flex: 2,
                  )
                ],
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 50,
          left: 15,
          right: 15,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Don't have an account? ",
                style: TextStyle(color: Colors.white),
              ),
              Text(
                "Sign Up",
                style: TextStyle(color: Color(0xFF043A22)),
              )
            ],
          ),
        )
      ]),
    );
  }
}

class Mclipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = new Path();
    path.lineTo(0.0, size.height);
    path.lineTo(size.width, size.height);
    print(size.height);
    path.lineTo(size.width, size.height - 350);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}

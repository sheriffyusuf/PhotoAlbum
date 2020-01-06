/* import 'package:flutter/material.dart';

import 'homepage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Flutter Demo ",
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomePage(),
    );
  }
}
 */

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
//import 'package:photo_album/dashboard.dart';
import 'package:photo_album/models/auth_page.dart';
import 'package:photo_album/pages/dashboard.dart';
import 'package:photo_album/repository/user_repository.dart';
import 'package:provider/provider.dart';
import 'models/auth_page.dart';
import 'models/student_model.dart';
import "package:firebase_remote_config/firebase_remote_config.dart";

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          StreamProvider(
              builder: (_) => StudentModel().getStudentList(),
              initialData: null),
          ChangeNotifierProvider(
            builder: (_) => UserRepository.instance(),
          )
        ],
        child: MaterialApp(
          theme: ThemeData(
              primarySwatch: Colors.lightBlue,
              textTheme: TextTheme(
                  display1: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Campton',
                      fontWeight: FontWeight.w500,
                      fontStyle: FontStyle.normal),
                  display2: TextStyle(
                      color: Colors.white,
                      fontFamily: 'CamptonLight',
                      fontStyle: FontStyle.normal,
                      fontSize: 20),
                  display3: TextStyle(
                      color: Colors.black,
                      fontFamily: 'CamptonLight',
                      fontStyle: FontStyle.normal,
                      fontSize: 18))
              //  fontFamily: 'Roboto'
              ),
          debugShowCheckedModeBanner: false,
          home:
          //  Dashboard(),
         HomePage(),
          //LoginPlay(),
        ));
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      builder: (_) => UserRepository.instance(),
      child: Consumer(
        builder: (context, UserRepository user, _) {
          switch (user.status) {
            case Status.Uninitialized:
            //   return Splash();
            case Status.Unauthenticated:
            case Status.Authenticating:
              return AuthScreen();
            case Status.Authenticated:
              return Dashboard();
            //UserInfoPage(user: user.user);
          }
          return null;
        },
      ),
    );
  }
}

class UserInfoPage extends StatelessWidget {
  final FirebaseUser user;

  const UserInfoPage({Key key, this.user}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User Info"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(user.email),
            RaisedButton(
              child: Text("SIGN OUT"),
              onPressed: () => Provider.of<UserRepository>(context).signOut(),
            )
          ],
        ),
      ),
    );
  }
}

class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: Text("Splash Screen"),
      ),
    );
  }
}


Future<RemoteConfig> setupRemoteConfig() async {
  final RemoteConfig remoteConfig = await RemoteConfig.instance;
  // Enable developer mode to relax fetch throttling
//    remoteConfig.setConfigSettings(RemoteConfigSettings(debugMode: true));
  await remoteConfig.setDefaults(<String, dynamic>{
    'welcome': 'One Africa Music Fest Returns NYC, London & Dubai',
    'hello': 'One Africa Music Fest Returns NYC, London & Dubai',
    'marquee_text': 'One Africa Music Fest Returns NYC, London & Dubai'
  });
  await remoteConfig.fetch(expiration: const Duration(seconds: 0));
  await remoteConfig.activateFetched();
  return remoteConfig;
}


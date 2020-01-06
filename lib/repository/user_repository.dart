//import 'package:flutter/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
/*import 'package:google_sign_in/google_sign_in.dart';*/
import 'package:photo_album/models/student.dart';


enum Status { Uninitialized, Authenticated, Authenticating, Unauthenticated }

class UserRepository with ChangeNotifier {
  FirebaseAuth _auth;
  FirebaseUser _user;
 // GoogleSignIn _googleSignIn;
 // FacebookAuth _facebookAuth;
  Status _status = Status.Uninitialized;
  Firestore _firestore = Firestore.instance;
  String _collectionStudent = "physics";


  UserRepository.instance()
      : _auth = FirebaseAuth.instance{
 // _googleSignIn= GoogleSignIn(),
 // _facebookAuth= FacebookAuth(){
    _auth.onAuthStateChanged.listen(_onAuthStateChanged);
  }

  Status get status => _status;
  FirebaseUser get user => _user;

  Future<bool> signIn(String email, String password) async {

    try {
      _status = Status.Authenticating;
      notifyListeners();
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return true;
    } catch (e) {
      _status = Status.Unauthenticated;
      notifyListeners();
      return false;
    }
  }

 /* Future<bool> signInWithGoogle() async {
    try {
      _status = Status.Authenticating;
      notifyListeners();
      final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
      await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      await _auth.signInWithCredential(credential);
      return true;
    } catch (e) {
      print(e);
      _status = Status.Unauthenticated;
      notifyListeners();
      return false;
    }

  }
*/
 /* Future<bool> signInWithFacebook() async{
    try{
      _status = Status.Authenticating;
      notifyListeners();
      final result = await _facebookAuth.login();
      AuthCredential credential =  FacebookAuthProvider.getCredential(accessToken:result.accessToken.token);
      await _auth.signInWithCredential(credential);
      return true;
    }
    catch(e){
      print(e);
      _status = Status.Unauthenticated;
      notifyListeners();
      return false;
    }
  }*/

  Future signOut() async {
    _auth.signOut();
 //   _googleSignIn.signOut();
 //   _facebookAuth.logOut();
    _status = Status.Unauthenticated;
    notifyListeners();
    return Future.delayed(Duration.zero);
  }


  Future<void> resetPassword(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }

  Future<void> _onAuthStateChanged(FirebaseUser firebaseUser) async {
    if (firebaseUser == null) {
      _status = Status.Unauthenticated;
    } else {
      _user = firebaseUser;
      _status = Status.Authenticated;
    }
    notifyListeners();
  }


  Future<Student> getProfile() async{
   var doc = await _firestore
        .collection(_collectionStudent)
        .document(user.uid)
        .get();
   print("yam ${doc.data}");
  // print(user.uid);
   return Student.fromMap(doc.data,user.uid) ?? "";
  }

  Future updateProfile(Student student) async {
    await Firestore.instance
        .collection(_collectionStudent)
        .document(_user.uid)
        .updateData(student.toMap()).catchError((error) => print('Error updating: $error'));
  }
}
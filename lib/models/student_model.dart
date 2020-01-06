import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:photo_album/models/student.dart';

class StudentModel with ChangeNotifier {
  final studentCollection = Firestore.instance.collection("physics");

  Stream<List<Student>> getStudentList() {
    return studentCollection
        .orderBy("Name", descending: false)
        .snapshots()
        .map((QuerySnapshot snapshot) {
      List<Student> _studentDocs =
          snapshot.documents.map((doc) => Student.fromDoc(doc)).toList();
      return _studentDocs;
    });
  }
}

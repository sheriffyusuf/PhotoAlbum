import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:photo_album/models/student.dart';

final _firestore = Firestore.instance;
final usersRef = _firestore.collection('users');

class DatabaseService {
  static Future<void> updateUser(Student student, String id) async {
    final usersRef = _firestore.collection('physics');
    await usersRef.document(id).updateData({
      'phoneNumber': student.phoneNumber,
      'img_url': student.imgUrl,
      'contactAddress': student.address
    });
  }
}

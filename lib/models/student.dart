class Student {
  String documentID;
  String name;
  String matricNumber;
  String address;
  String imgUrl;
  String state;
  String classCrush;
  String birthday;
  String likes;
  String dislikes;
  String hobbies;
  String bestCourse;
  String emailAddress;
  String phoneNumber;


  Student({this.documentID, this.name, this.matricNumber, this.address, this.imgUrl,this.state, this.classCrush, this.birthday, this.likes, this.dislikes,
    this.hobbies, this.bestCourse, this.emailAddress, this.phoneNumber});
 // Student({});


  factory Student.fromDoc(dynamic doc) => Student(
      phoneNumber: doc["phoneNumber"] ?? doc.documentID,
      name: doc["Name"],
      imgUrl: doc["img_url"],
      birthday: doc["birthday"] ?? "",
      classCrush: doc["classCrush"] ?? "",
      address: doc["contactAddress"],
      dislikes: doc["dislikes"] ?? "",
      likes: doc["likes"] ?? "",
      state: doc["state"] ?? "",
      bestCourse: doc["bestCourse"] ?? "",
      emailAddress: doc["emailAddress"] ?? "",
      hobbies: doc["hobbies"] ?? ""

  );

  Student.fromMap(Map snapshot, var uid) :
        name = snapshot['Name'] ?? '',
     //   matricNumber = snapshot['matricNumber'] ?? '',
        address =snapshot['contactAddress'] ?? "",
         imgUrl = snapshot['img_url'],
         phoneNumber= snapshot["phoneNumber"];


  Map<String,dynamic> toMap(){
    var data = {
      'Name': name,
      'contactAddress':address
    };
    return data;
  }
}

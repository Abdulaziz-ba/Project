class UserModel {
  String? uid;
  String? email;
  String? phone;
  String? FirstName;
  String? LastName;
  UserModel({this.uid, this.phone, this.email, this.FirstName, this.LastName});

//Retriving data form the server (Firebase DB)
  factory UserModel.fromMap(map) {
    return UserModel(
        uid: map['uid'],
        email: map['email'],
        phone: map['phone'],
        FirstName: map['FirstName'],
        LastName: map['LastName']);
  }
//Sending data to our Server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'phone': phone,
      "FirstName": FirstName,
      "LastName": LastName
    };
  }
}

class UserModel {
  String? uid;
  String? email;
  String? FirstName;
  String? LastName;
  UserModel({this.uid, this.email, this.FirstName, this.LastName});

//Retriving data form the server (Firebase DB)
  factory UserModel.fromMap(map) {
    return UserModel(
        uid: map['uid'],
        email: map['email'],
        FirstName: map['FirstName'],
        LastName: map['LastName']);
  }
//Sending data to our Server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      "FirstName": FirstName,
      "LastName": LastName
    };
  }
}

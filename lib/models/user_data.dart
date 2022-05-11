import 'dart:convert';

class UserData {

  UserData({required this.uid, required this.email});

  final String uid;
  final String email;

  Map<String, dynamic> toMap() => {
      'uid': uid,
      'email': email,
    };

  factory UserData.fromMap(Map<String, dynamic> map) => 
    UserData(
      uid: map['uid'] ?? '',
      email: map['email'] ?? '',
    );

 }

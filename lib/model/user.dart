// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class User {
  final int id;
  final String username;
  final String password;

  User({required this.id, required this.username, required this.password});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'username': username,
      'password': password,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] as int,
      username: map['userName'] as String,
      password: map['password'] as String,
    );
  }

  String toJson() => json.encode(toMap());

}

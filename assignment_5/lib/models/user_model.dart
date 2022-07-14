import 'package:firebase_auth/firebase_auth.dart';

class UserRegister{
  final String name;
  final String email;
  final String password;
  UserRegister(this.name, this.email,this.password);
}

class UserModel{
  final String name;
  final String email;
  final String id;
  UserModel({required this.name, required this.email,required this.id});
  factory UserModel.fromJson(Map<String,dynamic> json)
  {
    return UserModel(name: json['name'],email : json['email'],id: json['id']);
  }
}

class UserLogin{
  final String email;
  final String password;
  UserLogin(this.email,this.password);
}
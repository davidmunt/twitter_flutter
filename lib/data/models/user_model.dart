import 'package:flutter_twitter_nueva/domain/entities/user.dart';

class UserModel extends User {
  UserModel({
    required super.id,
    required super.username,
    required super.following,
    super.avatar,
    // required super.password,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      username: json['username'] as String,
      following: List<String>.from(json['following'] ?? []),
      avatar: json['avatar'] as String? ?? "https://imgs.search.brave.com/1wI8vt4wRQ83GoG8uFTP4TXIY5pK0KFDo9JUB8x8PDM/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9jZG4t/aWNvbnMtcG5nLmZy/ZWVwaWsuY29tLzI1/Ni8xNjc5NC8xNjc5/NDA0My5wbmc_c2Vt/dD1haXNfaHlicmlk", //le pongo uno default
      // password: json['password'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'following': following,
      'avatar': avatar,
      // 'password': password,
    };
  }
}

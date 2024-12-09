import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoginButtonPressed extends AuthEvent {
  final String email;
  final String password;

  LoginButtonPressed(this.email, this.password);

  @override
  List<Object?> get props => [email, password];
}

class FollowUserButtonPressed extends AuthEvent {
  final String userId;
  final String followerId;

  FollowUserButtonPressed(this.userId, this.followerId);

  @override
  List<Object?> get props => [userId, followerId];
}

class GetUsersButtonPressed extends AuthEvent {
  final String? filter;

  GetUsersButtonPressed({this.filter});

  @override
  List<Object?> get props => [filter];
}

class GetUserInfoButtonPressed extends AuthEvent {
  final String userId;

  GetUserInfoButtonPressed(this.userId);

  @override
  List<Object?> get props => [userId];
}

class UpdateUserButtonPressed extends AuthEvent {
  final String userId;
  final String? username;
  final String? avatar;

  UpdateUserButtonPressed(this.userId, this.username, this.avatar);

  @override
  List<Object?> get props => [userId, username, avatar];
}

class LogoutButtonPressed extends AuthEvent {}

import 'package:equatable/equatable.dart';
import 'package:flutter_twitter_nueva/domain/entities/user.dart';

class AuthState extends Equatable {
  final User? user;
  final List<User>? users;
  final bool isLoading;
  final String errorMessage;

  const AuthState({
    this.user,
    this.users = const [],
    this.isLoading = false,
    this.errorMessage = '',
  });

  AuthState copyWith({
    User? user,
    List<User>? users,
    bool? isLoading,
    String? errorMessage,
  }) {
    return AuthState(
      user: user ?? this.user,
      users: users ?? this.users,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [user, users, isLoading, errorMessage];
}

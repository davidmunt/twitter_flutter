import 'package:dartz/dartz.dart';
import 'package:flutter_twitter_nueva/domain/entities/user.dart';

abstract class UserRepository { 
  Future<Either<String, User>> login(String username, String password);

  Future<Either<String, User>> followUser(String userId, String followerId);

  Future<Either<String, User>> getUserInfo(String userId);

  Future<Either<String, List<User>>> getAllUsers();

  Future<Either<String, User>> updateUser(String userId, String? username, String? avatar);

  Future<Either<Exception, bool>> isLoggedIn();
}
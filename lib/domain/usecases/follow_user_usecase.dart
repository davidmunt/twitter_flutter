import 'package:dartz/dartz.dart';
import 'package:flutter_twitter_nueva/domain/entities/user.dart';
import 'package:flutter_twitter_nueva/domain/repositories/user_repository.dart';

class FollowUserUseCase {
 final UserRepository repository;

 FollowUserUseCase(this.repository);
 Future<Either<String, User>> call(String userId, String followerId) async {
   return await repository.followUser(userId, followerId);
 }
}

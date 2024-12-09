import 'package:dartz/dartz.dart';
import 'package:flutter_twitter_nueva/domain/entities/user.dart';
import 'package:flutter_twitter_nueva/domain/repositories/user_repository.dart';

class UpdateUserInfoUseCase {
  final UserRepository repository;

  UpdateUserInfoUseCase(this.repository);

  Future<Either<String, User>> call(String userId, String? username, String? avatar) async {
    return await repository.updateUser(userId, username, avatar);
  }
}

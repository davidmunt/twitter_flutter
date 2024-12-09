import 'package:dartz/dartz.dart';
import 'package:flutter_twitter_nueva/domain/entities/user.dart';
import 'package:flutter_twitter_nueva/domain/repositories/user_repository.dart';

class GetAllUsersUsecase {
 final UserRepository repository;

 GetAllUsersUsecase(this.repository);

 Future<Either<String, List<User>>> call() async {
   return await repository.getAllUsers();
 }
}
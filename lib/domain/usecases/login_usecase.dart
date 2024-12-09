import 'package:dartz/dartz.dart';
import 'package:flutter_twitter_nueva/domain/entities/user.dart';
import 'package:flutter_twitter_nueva/domain/repositories/user_repository.dart';

class LoginUseCase {
 final UserRepository repository;

 LoginUseCase(this.repository);

 Future<Either<String, User>> call(String email, String password) async {
   return await repository.login(email, password);
 }
}
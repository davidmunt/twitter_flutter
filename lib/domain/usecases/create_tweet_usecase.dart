import 'package:dartz/dartz.dart';
import 'package:flutter_twitter_nueva/domain/repositories/tweet_repository.dart';

class CreateTweetUseCase {
 final TweetRepository repository;

 CreateTweetUseCase(this.repository);
 Future<Either<String, void>> call(String userId, String content, String? image) async {
   return await repository.createTweet(userId, content, image);
 }
}
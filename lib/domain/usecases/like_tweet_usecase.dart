import 'package:dartz/dartz.dart';
import 'package:flutter_twitter_nueva/domain/repositories/tweet_repository.dart';

class LikeTweetUseCase {
 final TweetRepository repository;

 LikeTweetUseCase(this.repository);
 Future<Either<String, void>> call(String tweetId, String userId) async {
   return await repository.likeTweet(tweetId, userId);
 }
}
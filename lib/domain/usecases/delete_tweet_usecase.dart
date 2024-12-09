import 'package:dartz/dartz.dart';
import 'package:flutter_twitter_nueva/domain/repositories/tweet_repository.dart';

class DeleteTweetUseCase {
 final TweetRepository repository;

 DeleteTweetUseCase(this.repository);
 Future<Either<String, void>> call(String tweetId) async {
   return await repository.deleteTweet(tweetId);
 }
}
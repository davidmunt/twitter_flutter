import 'package:equatable/equatable.dart';

abstract class TweetEvent extends Equatable {
  const TweetEvent();

  @override
  List<Object?> get props => [];
}

class GetTweets extends TweetEvent {
  const GetTweets();
}

class CreateTweet extends TweetEvent {
  final String userId;
  final String content;
  final String? image;

  const CreateTweet(this.userId, this.content, this.image);

  @override
  List<Object?> get props => [userId, content, image];
}

class DeleteTweet extends TweetEvent {
  final String tweetId;

  const DeleteTweet(this.tweetId);

  @override
  List<Object?> get props => [tweetId];
}

class LikeTweet extends TweetEvent {
  final String tweetId;
  final String userId;

  const LikeTweet(this.tweetId, this.userId);

  @override
  List<Object?> get props => [tweetId, userId];
}

class UpdateTweet extends TweetEvent {
  final String tweetId;
  final String? content;
  final String? image;

  const UpdateTweet(this.tweetId, this.content, this.image);

  @override
  List<Object?> get props => [tweetId, content, image];
}

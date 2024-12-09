import 'package:equatable/equatable.dart';
import 'package:flutter_twitter_nueva/domain/entities/tweet.dart';

class TweetState extends Equatable {
  final List<Tweet> tweets;
  final bool isLoading;
  final String errorMessage;

  const TweetState({
    this.tweets = const [],
    this.isLoading = false,
    this.errorMessage = '',
  });

  TweetState copyWith({
    List<Tweet>? tweets,
    bool? isLoading,
    String? errorMessage,
  }) {
    return TweetState(
      tweets: tweets ?? this.tweets,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [tweets, isLoading, errorMessage];
}

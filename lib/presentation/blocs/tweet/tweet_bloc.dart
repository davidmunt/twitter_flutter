import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_twitter_nueva/domain/entities/tweet.dart';
import 'package:flutter_twitter_nueva/domain/usecases/create_tweet_usecase.dart';
import 'package:flutter_twitter_nueva/domain/usecases/delete_tweet_usecase.dart';
import 'package:flutter_twitter_nueva/domain/usecases/get_tweets_usecase.dart';
import 'package:flutter_twitter_nueva/domain/usecases/like_tweet_usecase.dart';
import 'package:flutter_twitter_nueva/domain/usecases/update_tweet_usecase.dart';
import 'package:flutter_twitter_nueva/presentation/blocs/tweet/tweet_event.dart';
import 'package:flutter_twitter_nueva/presentation/blocs/tweet/tweet_state.dart';

class TweetBloc extends Bloc<TweetEvent, TweetState> {
  final GetTweetsUseCase getTweetsUseCase;
  final CreateTweetUseCase createTweetUseCase;
  final DeleteTweetUseCase deleteTweetUseCase;
  final LikeTweetUseCase likeTweetUseCase;
  final UpdateTweetUseCase updateTweetUseCase;

  TweetBloc({
    required this.getTweetsUseCase,
    required this.createTweetUseCase,
    required this.deleteTweetUseCase,
    required this.likeTweetUseCase,
    required this.updateTweetUseCase,
  }) : super(const TweetState()) {
    
    on<GetTweets>((event, emit) async {
      emit(state.copyWith(isLoading: true));
      final result = await getTweetsUseCase();
      result.fold(
        (error) => emit(state.copyWith(
          isLoading: false,
          errorMessage: error.toString(),
        )),
        (tweets) => emit(state.copyWith(
          isLoading: false,
          tweets: tweets,
        )),
      );
    });

    on<CreateTweet>((event, emit) async {
      emit(state.copyWith(isLoading: true));
      final result = await createTweetUseCase(event.userId, event.content, event.image);
      result.fold(
        (error) => emit(state.copyWith(
          isLoading: false,
          errorMessage: error.toString(),
        )),
        (_) {
          add(const GetTweets());
        },
      );
    });

    on<DeleteTweet>((event, emit) async {
      emit(state.copyWith(isLoading: true));
      final result = await deleteTweetUseCase(event.tweetId);
      result.fold(
        (error) => emit(state.copyWith(
          isLoading: false,
          errorMessage: error.toString(),
        )),
        (_) {
          add(const GetTweets());
        },
      );
    });

    on<LikeTweet>((event, emit) async {
      emit(state.copyWith(isLoading: true));
      final result = await likeTweetUseCase(event.tweetId, event.userId);
      result.fold(
        (error) => emit(state.copyWith(
          isLoading: false,
          errorMessage: error.toString(),
        )),
        (_) {
          add(const GetTweets());
        },
      );
    });

    on<UpdateTweet>((event, emit) async {
      emit(state.copyWith(isLoading: true));
      final result = await updateTweetUseCase(event.tweetId, event.content, event.image);
      result.fold(
        (error) => emit(state.copyWith(
          isLoading: false,
          errorMessage: error.toString(),
        )),
        (_) {
          add(const GetTweets());
        },
      );
    });
  }
}

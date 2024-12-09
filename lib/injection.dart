import 'package:flutter_twitter_nueva/data/datasources/tweet_remote_datasource.dart';
import 'package:flutter_twitter_nueva/data/datasources/user_remote_datasource.dart';
import 'package:flutter_twitter_nueva/data/repositories/tweet_repository_impl.dart';
import 'package:flutter_twitter_nueva/data/repositories/user_repository_impl.dart';
import 'package:flutter_twitter_nueva/domain/repositories/tweet_repository.dart';
import 'package:flutter_twitter_nueva/domain/repositories/user_repository.dart';
import 'package:flutter_twitter_nueva/domain/usecases/create_tweet_usecase.dart';
import 'package:flutter_twitter_nueva/domain/usecases/delete_tweet_usecase.dart';
import 'package:flutter_twitter_nueva/domain/usecases/follow_user_usecase.dart';
import 'package:flutter_twitter_nueva/domain/usecases/get_all_users_usecase.dart';
import 'package:flutter_twitter_nueva/domain/usecases/get_tweets_usecase.dart';
import 'package:flutter_twitter_nueva/domain/usecases/get_user_info_usecase.dart';
import 'package:flutter_twitter_nueva/domain/usecases/like_tweet_usecase.dart';
import 'package:flutter_twitter_nueva/domain/usecases/login_usecase.dart';
import 'package:flutter_twitter_nueva/domain/usecases/update_tweet_usecase.dart';
import 'package:flutter_twitter_nueva/domain/usecases/update_user_info_usecase.dart';
import 'package:flutter_twitter_nueva/presentation/blocs/auth/auth_bloc.dart';
import 'package:flutter_twitter_nueva/presentation/blocs/tweet/tweet_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

void setupDependencies() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);

  // DataSource
  sl.registerLazySingleton(() => UserRemoteDatasource());
  sl.registerLazySingleton(() => TweetRemoteDataSource());

  // Repositories
  sl.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(remoteDataSource: sl()),
  );
  sl.registerLazySingleton<TweetRepository>(
    () => TweetRepositoryImpl(remoteDataSource: sl()),
  );

  // Use Cases
  sl.registerLazySingleton(() => LoginUseCase(sl()));
  sl.registerLazySingleton(() => FollowUserUseCase(sl()));
  sl.registerLazySingleton(() => GetUserInfoUseCase(sl()));
  sl.registerLazySingleton(() => UpdateUserInfoUseCase(sl()));
  sl.registerLazySingleton(() => GetAllUsersUsecase(sl()));
  sl.registerLazySingleton(() => GetTweetsUseCase(sl()));
  sl.registerLazySingleton(() => CreateTweetUseCase(sl()));
  sl.registerLazySingleton(() => DeleteTweetUseCase(sl()));
  sl.registerLazySingleton(() => LikeTweetUseCase(sl()));
  sl.registerLazySingleton(() => UpdateTweetUseCase(sl()));

  // Blocs
  sl.registerFactory(() => AuthBloc(
    loginUseCase: sl(), 
    updateUserInfoUseCase: sl(),
    getAllUsersUsecase: sl(),
    getUserInfoUseCase: sl(),
    followUserUseCase: sl(),
  ));

  sl.registerFactory(() => TweetBloc(
      getTweetsUseCase: sl(),
      createTweetUseCase: sl(),
      deleteTweetUseCase: sl(),
      likeTweetUseCase: sl(),
      updateTweetUseCase: sl(),
  ));
}

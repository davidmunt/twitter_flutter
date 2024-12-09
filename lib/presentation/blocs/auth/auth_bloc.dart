import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_twitter_nueva/domain/repositories/user_repository.dart';
import 'package:flutter_twitter_nueva/domain/usecases/follow_user_usecase.dart';
import 'package:flutter_twitter_nueva/domain/usecases/get_all_users_usecase.dart';
import 'package:flutter_twitter_nueva/domain/usecases/get_user_info_usecase.dart';
import 'package:flutter_twitter_nueva/domain/usecases/login_usecase.dart';
import 'package:flutter_twitter_nueva/domain/usecases/update_user_info_usecase.dart';
import 'package:flutter_twitter_nueva/presentation/blocs/auth/auth_event.dart';
import 'package:flutter_twitter_nueva/presentation/blocs/auth/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase loginUseCase;
  final FollowUserUseCase followUserUseCase;
  final GetAllUsersUsecase getAllUsersUsecase;
  final GetUserInfoUseCase getUserInfoUseCase;
  final UpdateUserInfoUseCase updateUserInfoUseCase;

  AuthBloc({required this.loginUseCase, required this.followUserUseCase, required this.getAllUsersUsecase, required this.getUserInfoUseCase, required this.updateUserInfoUseCase}) : super(const AuthState()) {

    on<LoginButtonPressed>((event, emit) async {
      emit(state.copyWith(isLoading: true));
      final loginResult = await loginUseCase(event.email, event.password);
      await loginResult.fold(
        (error) async {
          emit(state.copyWith(
            isLoading: false,
            errorMessage: error,
          ));
        },
        (user) async {
          final userInfoResult = await getUserInfoUseCase(user.id);
          userInfoResult.fold(
            (error) {
              emit(state.copyWith(
                isLoading: false,
                errorMessage: error,
              ));
            },
            (userInfo) {
              emit(state.copyWith(
                isLoading: false,
                user: userInfo,
              ));
            },
          );
        },
      );
    });

    on<GetUsersButtonPressed>((event, emit) async {
      emit(state.copyWith(isLoading: true));
      final result = await getAllUsersUsecase();
      result.fold(
        (error) => emit(state.copyWith(
          isLoading: false,
          errorMessage: error.toString(),
        )),
        (users) {
          final filteredUsers = users.where((user) {
            return user.username.toLowerCase().contains(event.filter?.toLowerCase() ?? '');
          }).toList();
          emit(state.copyWith(
            isLoading: false,
            users: filteredUsers,
          ));
        },
      );
    });

    on<GetUserInfoButtonPressed>((event, emit) async {
      emit(state.copyWith(isLoading: true));
      final result = await getUserInfoUseCase(event.userId);
      result.fold(
        (error) => emit(state.copyWith(
          isLoading: false,
          errorMessage: error.toString(),
        )),
        (user) => emit(state.copyWith(
          isLoading: false,
          user: user,
        )),
      );
    });

    on<FollowUserButtonPressed>((event, emit) async {
      emit(state.copyWith(isLoading: true));
      final result = await followUserUseCase(event.userId, event.followerId);
      result.fold(
        (error) => emit(state.copyWith(
          isLoading: false,
          errorMessage: error.toString(),
        )),
        (_) {
          add(GetUserInfoButtonPressed(event.userId));
        },
      );
    });

    on<UpdateUserButtonPressed>((event, emit) async {
      emit(state.copyWith(isLoading: true));
      final result = await updateUserInfoUseCase(event.userId, event.username, event.avatar);
      result.fold(
        (error) => emit(state.copyWith(
          isLoading: false,
          errorMessage: error.toString(),
        )),
        (user) => emit(state.copyWith(
          isLoading: false,
          user: user,
        )),
      );
    });

    on<LogoutButtonPressed>((event, emit) async {
      emit(state.copyWith(isLoading: true));
      try {
        emit(const AuthState()); 
      } catch (e) {
        emit(state.copyWith(
          isLoading: false,
          errorMessage: 'Error al cerrar sesión: $e',
        ));
      }
    });
  }
}

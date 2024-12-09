import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_twitter_nueva/presentation/blocs/auth/auth_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_twitter_nueva/presentation/screens/home_screen.dart';
import 'package:flutter_twitter_nueva/presentation/screens/login_screen.dart';
import 'package:flutter_twitter_nueva/injection.dart' as di;
final GoRouter appRouter = GoRouter(
  initialLocation: '/login',
  routes: [
    GoRoute(
      path: '/login',
      builder: (BuildContext context, GoRouterState state) {
        return const LoginScreen();
      },
    ),
    GoRoute(
      path: '/home',
      builder: (BuildContext context, GoRouterState state) {
        return const HomeScreen();
      },
    ),
  ],
  redirect: (context, state) {
    final user = context.read<AuthBloc>().state.user;
    if (user == null && !state.matchedLocation.contains("/login")) {
      return "/login";
    } 
    if (user != null && state.matchedLocation.contains("/login")) {
      return "/home";
    }
    return null;
  },
);

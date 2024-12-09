import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_twitter_nueva/presentation/blocs/auth/auth_bloc.dart';
import 'package:flutter_twitter_nueva/presentation/blocs/auth/auth_event.dart';
import 'package:flutter_twitter_nueva/presentation/blocs/auth/auth_state.dart';
import 'package:go_router/go_router.dart';

class LogoutWidget extends StatefulWidget {
  const LogoutWidget({super.key});

  @override
  State<LogoutWidget> createState() => _LogoutWidgetState();
}

class _LogoutWidgetState extends State<LogoutWidget> {

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(onPressed: () {
                  Navigator.of(context).pop();
                }, 
                child: const Text("Cancelar")),
                TextButton(onPressed: () {
                  context.read<AuthBloc>().add(LogoutButtonPressed());
                  Navigator.of(context).pop();
                  context.go('/login');
                }, 
                child: const Text("Cerrar Sesion")),
              ],
            );
          },
        ),
      ),
    );
  }
}
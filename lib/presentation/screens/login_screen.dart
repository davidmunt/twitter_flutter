import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_twitter_nueva/presentation/blocs/auth/auth_bloc.dart';
import 'package:flutter_twitter_nueva/presentation/blocs/auth/auth_event.dart';
import 'package:flutter_twitter_nueva/presentation/blocs/auth/auth_state.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatefulWidget {
 const LoginScreen({super.key});

 @override
 State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
 final _userController = TextEditingController();
 final _passwordController = TextEditingController();

 @override
 Widget build(BuildContext context) {
   return Scaffold(
    appBar: AppBar(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Loggin Twitter'),
          SizedBox(
            width: 70,
            height: 30,
            child: Image.network(
              "https://imgs.search.brave.com/J8OZhFQNOk88easc2Z-opPZeRsy3r-3TI2Lbn1LAFi8/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9mcmVl/bG9nb3BuZy5jb20v/aW1hZ2VzL2FsbF9p/bWcvMTY1NzA0MzM0/NXR3aXR0ZXItbG9n/by1wbmcucG5n",
              fit: BoxFit.contain,
            ),
          ),
        ],
      ),
    ),
    body: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: const Color.fromARGB(255, 0, 0, 0),
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(16.0),
        ),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _userController,
              decoration: const InputDecoration(labelText: 'User'),
            ),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Contraseña'),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            BlocConsumer<AuthBloc, AuthState>(
              listener: (context, state) {
                if (state.user != null) {
                  context.go('/home');
                } else if (state.errorMessage.isNotEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.errorMessage)),
                  );
                }
              },
              builder: (context, state) {
                return ElevatedButton(
                  onPressed: () {
                    context.read<AuthBloc>().add(LoginButtonPressed(_userController.text, _passwordController.text));
                  },
                  child: const Text('Iniciar sesion'),
                );
              },
            )
          ],
        ),
      ),
    ),
  );
 }
}
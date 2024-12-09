import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_twitter_nueva/presentation/blocs/auth/auth_bloc.dart';
import 'package:flutter_twitter_nueva/presentation/blocs/auth/auth_event.dart';
import 'package:flutter_twitter_nueva/presentation/blocs/auth/auth_state.dart';
import 'package:flutter_twitter_nueva/presentation/widgets/widget_logout.dart';
import 'package:flutter_twitter_nueva/presentation/widgets/widget_modificar_user.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({super.key});

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  final texto = "Funciona";

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state.user != null) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Bienvenido, ${state.user!.username}'),
                    const SizedBox(height: 16),
                    CircleAvatar(
                      radius: 40,
                      backgroundImage: NetworkImage(state.user!.avatar ?? 'https://imgs.search.brave.com/1wI8vt4wRQ83GoG8uFTP4TXIY5pK0KFDo9JUB8x8PDM/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9jZG4t/aWNvbnMtcG5nLmZy/ZWVwaWsuY29tLzI1/Ni8xNjc5NC8xNjc5/NDA0My5wbmc_c2Vt/dD1haXNfaHlicmlk'),
                    ),
                    const SizedBox(height: 16),
                    TextButton(
                      onPressed: () async {
                        final result = await showModalBottomSheet<Map<String, dynamic>?>(context: context, isScrollControlled: true,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text("Modifica el nombre o avatar de tu usuario"),
                              content: ModificarUserWidget(idUser: state.user!.id, initialUsername: state.user!.username, initialAvatar: state.user!.avatar ?? 'https://imgs.search.brave.com/1wI8vt4wRQ83GoG8uFTP4TXIY5pK0KFDo9JUB8x8PDM/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9jZG4taWNvbnMtcG5nLmZyZWVwaWsuY29tLzI1Ni8xNjc5NC8xNjc5NDA0My5wbmc_c2Vt=dGFpbnRfYWRqb2ludA==',
                              ),
                            );
                          },
                        );
                        if (result != null) {
                          final idUser = result['idUser'];
                          final username = result['username'];
                          final avatar = result['avatar'];
                          context.read<AuthBloc>().add(UpdateUserButtonPressed(idUser, username, avatar));
                          context.read<AuthBloc>().add(GetUserInfoButtonPressed(idUser));
                        }
                      },
                      child: const Text("Modificar nombre o avatar"),
                    ),
                    const SizedBox(height: 16),
                    TextButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return const AlertDialog(
                              title: Text("¿Estás seguro de cerrar sesión?"),
                              content: LogoutWidget(),
                            );
                          },
                        );
                      },
                      child: const Text("Logout"),
                    ),
                  ],
                ),
              );
            } else {
              return const Center(
                child: Text('Ha habido un error al cargar el usuario...'),
              );
            }
          },
        ),
      ),
    );
  }
}
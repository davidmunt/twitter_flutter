import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_twitter_nueva/presentation/blocs/auth/auth_bloc.dart';
import 'package:flutter_twitter_nueva/presentation/blocs/auth/auth_event.dart';
import 'package:flutter_twitter_nueva/presentation/blocs/auth/auth_state.dart';

class WidgetBuscarUsuarios extends StatefulWidget {
  const WidgetBuscarUsuarios({super.key});

  @override
  State<WidgetBuscarUsuarios> createState() => _WidgetBuscarUsuariosState();
}

class _WidgetBuscarUsuariosState extends State<WidgetBuscarUsuarios> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<AuthBloc>().add(GetUsersButtonPressed(filter: ""));
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _searchController,
                    decoration: const InputDecoration(
                      labelText: 'Buscar usuario',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    final filter = _searchController.text.trim();
                    context.read<AuthBloc>().add(GetUsersButtonPressed(filter: filter));
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),
            BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                if (state.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state.users != null && state.users!.isNotEmpty) {
                  return ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: state.users?.length ?? 0,
                    itemBuilder: (context, index) {
                      final user = state.users?[index];
                      if (user == null) return const SizedBox.shrink();
                      if (user.id == state.user!.id) return const SizedBox.shrink();
                      return Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 20,
                              backgroundImage: NetworkImage(user.avatar ?? 'https://imgs.search.brave.com/1wI8vt4wRQ83GoG8uFTP4TXIY5pK0KFDo9JUB8x8PDM/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9jZG4t/aWNvbnMtcG5nLmZy/ZWVwaWsuY29tLzI1/Ni8xNjc5NC8xNjc5/NDA0My5wbmc_c2Vt/dD1haXNfaHlicmlk'),
                            ),
                            const SizedBox(width: 10),
                            Text(user.username),
                            const SizedBox(width: 10),
                            const Spacer(),
                            if (state.user?.following.contains(user.id) == true)
                              TextButton(
                                onPressed: () {},
                                child: const Text("Siguiendo"),
                              )
                            else
                              TextButton(
                                onPressed: () {
                                  context.read<AuthBloc>().add(FollowUserButtonPressed(state.user!.id, user.id));
                                  context.read<AuthBloc>().add(GetUsersButtonPressed());
                                },
                                child: const Text("Seguir"),
                              ),
                          ],
                        ),
                      );
                    },
                  );
                } else if (state.users == null || state.users!.isEmpty) {
                  return const Text("No se encontraron usuarios");
                } else {
                  return const Text("Ha ocurrido un error al cargar los usuarios");
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}


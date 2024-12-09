import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_twitter_nueva/presentation/blocs/auth/auth_bloc.dart';
import 'package:flutter_twitter_nueva/presentation/blocs/tweet/tweet_bloc.dart';
import 'package:flutter_twitter_nueva/presentation/blocs/tweet/tweet_event.dart';
import 'package:flutter_twitter_nueva/presentation/blocs/tweet/tweet_state.dart';
import 'package:flutter_twitter_nueva/presentation/widgets/dialog_modificar_tweet.dart';
import 'package:flutter_twitter_nueva/presentation/widgets/widget_buscar_usuarios.dart';
import 'package:intl/intl.dart';

class MostrarTweetsWidget extends StatefulWidget {
  const MostrarTweetsWidget({super.key});

  @override
  State<MostrarTweetsWidget> createState() => _MostrarTweetsWidgetState();
}

class _MostrarTweetsWidgetState extends State<MostrarTweetsWidget> {
    @override
  void initState() {
    super.initState();
    context.read<TweetBloc>().add(const GetTweets());
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TweetBloc, TweetState>(
          builder: (context, state) {
            final idUser = context.read<AuthBloc>().state.user?.id;
            if (state.isLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state.tweets != null) {
              return Column(
                children: [
                  TextButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text('Buscar Usuarios'),
                            content: const SizedBox(
                              width: double.maxFinite,
                              child: WidgetBuscarUsuarios(),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context); 
                                },
                                child: const Text('Cerrar'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Buscar usuarios: "),
                        Icon(Icons.search),
                      ],
                    ),
                  ),
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: state.tweets.length,
                    itemBuilder: (context, index) {
                      final tweet = state.tweets[index];
                      String formattedDate = DateFormat('yyyy-MM-dd HH:mm').format(tweet.createdAt);
                      return Container(
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: const Offset(0, 3), 
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                CircleAvatar(radius: 20, backgroundImage: NetworkImage(tweet.userAvatar ?? 'https://imgs.search.brave.com/1wI8vt4wRQ83GoG8uFTP4TXIY5pK0KFDo9JUB8x8PDM/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9jZG4t/aWNvbnMtcG5nLmZy/ZWVwaWsuY29tLzI1/Ni8xNjc5NC8xNjc5/NDA0My5wbmc_c2Vt/dD1haXNfaHlicmlk')),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(tweet.userId, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                                      Text(formattedDate, style: const TextStyle(fontSize: 12)),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Text(tweet.content, style: const TextStyle(fontSize: 15, height: 1.5)),
                            const SizedBox(height: 10),
                            if (tweet.image != null)
                              Center(child: Image.network(tweet.image!)),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                if (tweet.likes.contains(idUser)) 
                                  IconButton(
                                    icon: const Icon(Icons.favorite),
                                    onPressed: () {
                                      //no hace nada
                                    },
                                  ),
                                if (!tweet.likes.contains(idUser))  
                                  IconButton(
                                    icon: const Icon(Icons.favorite_border_outlined),
                                    onPressed: () {
                                      context.read<TweetBloc>().add(LikeTweet(tweet.id, idUser!));
                                    },
                                  ),
                                Text(tweet.likes.length.toString()),
                                if (tweet.userId == idUser)  
                                  IconButton(
                                    icon: const Icon(Icons.delete),
                                    onPressed: () {
                                      context.read<TweetBloc>().add(DeleteTweet(tweet.id));
                                    },
                                  ),
                                if (tweet.userId == idUser)  
                                  IconButton(
                                    icon: const Icon(Icons.edit),
                                    onPressed: () async {
                                      final result = await showModalBottomSheet<Map<String, dynamic>?>(
                                        context: context,
                                        isScrollControlled: true,
                                        builder: (context) => ModificarTweetWidget(initialcontent: tweet.content, initialimage: tweet.image),
                                      );
                                      if (result != null) {
                                        context.read<TweetBloc>().add(UpdateTweet(tweet.id, result['content'], result['image']),
                                        );
                                      }
                                    },
                                  ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              );
            } else if (state.errorMessage != null) {
              return Center(
                child: Text(state.errorMessage!),
              );
            } else {
              return const Center(
                child: Text('No hay tweets...'),
              );
            }
          },
        ),
      ),
    );
  }
}

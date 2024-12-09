import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_twitter_nueva/presentation/blocs/auth/auth_bloc.dart';
import 'package:flutter_twitter_nueva/presentation/blocs/auth/auth_state.dart';
import 'package:flutter_twitter_nueva/presentation/blocs/tweet/tweet_bloc.dart';
import 'package:flutter_twitter_nueva/presentation/blocs/tweet/tweet_event.dart';
import 'package:flutter_twitter_nueva/presentation/widgets/dialog_crear_tweet.dart';
import 'package:flutter_twitter_nueva/presentation/widgets/drawer_widget.dart';
import 'package:flutter_twitter_nueva/presentation/widgets/widget_mostrar_tweets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userId = context.read<AuthBloc>().state.user!.id;
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const Text('Twitter'),
            SizedBox(
              width: 70,
              height: 30,
              child: Image.network("https://imgs.search.brave.com/J8OZhFQNOk88easc2Z-opPZeRsy3r-3TI2Lbn1LAFi8/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9mcmVl/bG9nb3BuZy5jb20v/aW1hZ2VzL2FsbF9p/bWcvMTY1NzA0MzM0/NXR3aXR0ZXItbG9n/by1wbmcucG5n", fit: BoxFit.contain),
            ),
          ],
        ),
      ),
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state.user != null) {
            return const Center(
              child: Expanded(
                child: MostrarTweetsWidget(),
              ),
            );
          } else {
            return const Center(
              child: Text('Ha habido un error al cargar el usuario...'),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await showModalBottomSheet<Map<String, dynamic>?>(
            context: context,
            isScrollControlled: true,
            builder: (context) => const CrearTweetDialog(),
          );
          if (result != null) {
            context.read<TweetBloc>().add(CreateTweet(userId, result['content'], result['image']));
          }
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      drawer: const Drawer(
        child: DrawerWidget(),
      ),
    );
  }
}

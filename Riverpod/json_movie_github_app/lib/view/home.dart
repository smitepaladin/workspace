import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:json_movie_github/model/movie.dart';
import 'package:json_movie_github/vm/movie_provider.dart';

class Home extends ConsumerWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final movieAyncValue = ref.watch(movieFutureProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Riverpod JSON app'),
      ),
      body: movieAyncValue.when(
        data: (movies) => ListView.builder(
          itemCount: movies.length,
          itemBuilder: (context, index) {
            final Movie movie = movies[index];
            return Card(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(7),
                    child: Image.network(
                      movie.image,
                      width: 70,
                    ),
                  ),
                  SizedBox(width: 10),
                  Text(movie.title),
                ],
              ),
            );
          },
        ),
        loading: () => Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('오류발생 : $e')),
      ),
    );
  }
}
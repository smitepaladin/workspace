import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_json_movie_github/model/movie.dart';
import 'package:provider_json_movie_github/vm/movie_model.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final movieProvider = context.watch<MovieModel>();
    return Scaffold(
      appBar: AppBar(
        title: Text('Provider JSON app'),
      ),
      body: Builder(
        builder: (context) {
          if(movieProvider.isLoading){
            return Center(child: CircularProgressIndicator());
          }
          if(movieProvider.error != null){
            return Center(child: Text("오류발생 : ${movieProvider.error}"));
          }

          final movies = movieProvider.movies;
          return ListView.builder(
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
                    Text("     ${movie.title}"),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_json_movie_github/view/home.dart';
import 'package:provider_json_movie_github/vm/movie_model.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => MovieModel()..fetchMovies(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const Home(),
    );
  }
}

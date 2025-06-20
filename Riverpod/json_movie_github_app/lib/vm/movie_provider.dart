import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:json_movie_github/model/movie.dart';

class MovieNotifier extends StateNotifier<List<Movie>> {
  MovieNotifier() : super([]);

  Future<void> fetchMovies() async {
    try {
      final url = Uri.parse("https://zeushahn.github.io/Test/movies.json");
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(utf8.decode(response.bodyBytes));
        final List results = data['results'];

        state = results
            .map((e) => Movie(
                  title: e['title'] ?? '',
                  image: e['image'] ?? '',
                ))
            .toList();
      } else {
        throw Exception("데이터 로딩 실패");
      }
    } catch (e) {
      print("에러 발생: $e");
    }
  }
}


// 상태 저장용

final movieProvider = StateNotifierProvider<MovieNotifier, List<Movie>>(
(ref) => MovieNotifier(),
);

// 비동기 데이터 fetch용
final movieFutureProvider = FutureProvider<List<Movie>>(
  (ref) async{
    final notifier = ref.read(movieProvider.notifier);
    await notifier.fetchMovies();
    return ref.read(movieProvider);
  },
);
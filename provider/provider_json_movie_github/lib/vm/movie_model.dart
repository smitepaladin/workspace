import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider_json_movie_github/model/movie.dart';
import 'package:http/http.dart' as http;

class MovieModel with ChangeNotifier{
  List<Movie> _movies = [];
  bool _isLoading = false;
  String? _error;


  List<Movie> get movies => _movies;
  bool get isLoading => _isLoading;
  String? get error => _error;



  Future<void> fetchMovies() async{
    _isLoading = true;
    _error = null;


    try{
      final url = Uri.parse("https://zeushahn.github.io/Test/movies.json");
      final response = await http.get(url);

      if(response.statusCode == 200){
        final data = json.decode(utf8.decode(response.bodyBytes));
        final List results = data['results'];
        // Data 여부 파악
        _movies = results.map((data) => Movie(image: data['image'] ?? '', title: data['title'] ?? '')).toList(); // map은 for문이다
      }else{
        _error = "데이터 로딩 실패 : ${response.statusCode}";
      }
    }catch(e){
      _error = "에외 발생 : $e";
    }finally{
      _isLoading = false;
      notifyListeners();
    }
  }
}
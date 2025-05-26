import 'dart:convert';
import 'package:get/get.dart';
import 'package:getx_json_movie_github_app/model/movie.dart';
import 'package:http/http.dart' as http;

class VmHandler extends GetxController{
  var movies = <Movie>[].obs;
  var isLoading = true.obs;
  var errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchMovies();
  }



  void fetchMovies()async{
    try{
      isLoading.value = true;
      errorMessage.value = "";

      var url = Uri.parse('http://zeushahn.github.io/Test/movies.json');
      var response = await http.get(url);
      var dataConvertedJSON = json.decode(utf8.decode(response.bodyBytes));
      List results = dataConvertedJSON['results'];

      List<Movie> returnResult = 
            results.map((item) {
              return Movie(image: item['image'], title: item['title']);
            }).toList();

      movies.value = returnResult;
    }catch (e){
      errorMessage.value = "데이터를 불러오는데 실패 했습니다. \n${e.toString()}";
    }finally{
      isLoading.value = false;
    }
  }
}
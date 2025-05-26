import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_json_movie_github_app/model/movie.dart';
import 'package:getx_json_movie_github_app/vm/vm_handler.dart';


class Home extends StatelessWidget {
  Home({super.key});

  final VmHandler vmHandler = Get.find<VmHandler>();

  @override
  Widget build(BuildContext context) {
    

    return Scaffold(
      appBar: AppBar(
        title: Text('Provider JSON app'),
      ),
      body: Obx((){
          if(vmHandler.isLoading.value){
            return Center(child: CircularProgressIndicator());
          }
          if(vmHandler.errorMessage.isNotEmpty){
            return Center(
              child: Text(vmHandler.errorMessage.value));
          }
      
          return ListView.builder(
            itemCount: vmHandler.movies.length,
            itemBuilder: (context, index) {
              final Movie movie = vmHandler.movies[index];
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
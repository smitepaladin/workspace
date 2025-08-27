import 'package:flutter/material.dart';
import 'package:responsive_layout/model/course.dart';

class CourseTitle extends StatelessWidget {
  final Course course;
  const CourseTitle({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 500,
      child: Card(
        margin: EdgeInsets.fromLTRB(20, 0, 20, 20),
        color: Colors.blueGrey[50],
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Image.asset(
                course.image
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                course.title,
                style: TextStyle(
                  fontWeight: FontWeight.bold
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                course.time,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.blueGrey
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                course.description,
                style: TextStyle(
                  fontSize: 16
                ),
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
      ),
    );
  }
}
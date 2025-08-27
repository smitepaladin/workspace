class Course {
  final String title;
  final String image;
  final String time;
  final String description;


  Course({
    required this.title,
    required this.image,
    required this.time,
    required this.description,
  });


  static final courses = [
    Course(
      title: 'Dart for Beginners',
      image: 'images/1.png',
      time: '23H 17M',
      description: 'Beginners course focused on Dart basics'
    ),
    
    Course(
      title: 'Clean UI Course',
      image: 'images/2.png',
      time: '23H 17M',
      description: 'Create beautiful user interfaces.'
    ),
  ];
}
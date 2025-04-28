class Todolist {

  // Property

  int? id;
  String worklist;
  String date;



  // constructor

  Todolist(
  {
    this.id,
    required this.worklist,
    required this.date


    }
  );



  // Factory

  Todolist.fromMap(Map<String, dynamic> res)

  : id = res['id'],
  worklist = res['worklist'],
  date = res['date'];



}
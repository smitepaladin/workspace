class DeleteTodoList {

  // Property

  int? id;
  String worklist;
  String date;



  // constructor

  DeleteTodoList(
  {
    this.id,
    required this.worklist,
    required this.date


    }
  );



  // Factory

  DeleteTodoList.fromMap(Map<String, dynamic> res)

  : id = res['id'],
  worklist = res['worklist'],
  date = res['date'];



}
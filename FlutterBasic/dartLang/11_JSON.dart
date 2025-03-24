import 'dart:convert'; // jsonDecode가 여기에 들어있다. jsonDecode를 쓰면 자동으로 생김.

main(){ // 데이터베이스든, 어디에서든 데이터를 받아올 때 형태가 JSON // List에서는 첫번째 , 기준으로 그 앞이 0번이다.
  var jsonString = '''  
  [
    {
      "score":40
    },
    {
      "score":80
    }
  ]

''';


  var scores = jsonDecode(jsonString); 
  print(scores);
  var firstScore = scores[0];
  print(firstScore);
  print(firstScore['score']);

  print(scores[0]['score']);
}
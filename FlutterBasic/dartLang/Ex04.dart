
// main(){
//     List<int> num = [34, 32, 55, 57, 59, 53, 90, 88, 88, 12];
//     int value = num[0];
//     int loopCount = 0;
//     int nine = 0;
//     int eight = 0;
//     int seven = 0;
//     int six = 0;
//     int five = 0;
//     int four = 0;
//     int three = 0;
//     int two = 0;
//     int one = 0;
//     int zero = 0;
//     String A = "#";


//     for(int i in num){
//       loopCount++;
//       if(i >= 90){
//         nine++;
//       }else if(i >= 80){
//         eight++;
//       }else if(i >= 70){
//         seven++;
//       }else if(i >= 60){
//         six++;
//       }else if(i >= 50){
//         five++;
//       }else if(i >= 40){
//         four++;
//       }else if(i >= 30){
//         three++;
//       }else if(i >= 20){
//         two++;
//       }else if(i >= 10){
//         one++;
//       }else{
//         zero++;
//       }

//     }

//     print("90 : ");
// }


// List를 이용한 히스토그램 표시하기
// 입력 숫자 : [34, 32, 55, 57, 59, 53, 90, 88, 88, 12]
// 결과
/*
      90 : #
      80 : ##
      70 : 
      60 : 
      50 : ####
      40 : 
      30 : ##
      20 : 
      10 : #
      0 : 
*/



main(){
  List<int> score = [34, 32, 55, 57, 59, 53, 90, 88, 88, 12];
  var histo = List<int>.filled(10,0);

  for(int i=0; i < score.length; i++){
    histo[score[i] ~/10]++;
  }
  for(int i=(score.length-1); i>=0; i--){
    String scoreLength = "";
    for(int j =1; j < histo[i]; j++){
      scoreLength += "#";
    }
    print("${i*10} : $scoreLength");
  }
  
}
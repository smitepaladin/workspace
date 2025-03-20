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

// List<int> score = [34, 32, 55, 57, 59, 53, 90, 88, 88, 12];

main(){
  List<int> score = [34, 32, 55, 57, 59, 53, 90, 88, 88, 12];
  var histo = List<int>.filled(10,0);


  for(int i = 0; i < score.length; i++){
    histo[score[i] ~/10]++;
  }

  for(int i = (score.length - 1); i >= 0; i--){
    String scoreLength = "";
    for(int j=1;j <= histo[i]; j++){
      scoreLength += "#";
    }

    print("${i*10} : $scoreLength");
  }

}
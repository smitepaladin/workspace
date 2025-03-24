main(){
  checkVersion();
  print('end Process');
}



checkVersion()async{ // 메인에서 체크버전으로 내려오고, 어싱크를 확인하면 그냥 두고 아래로 내려가서 프린트로 찍어냄.
  var version = await lookupVersion(); // 룩업버전이 끝날때까지 기다려
  print(version);
}


int lookupVersion(){
  return 12;
}
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart' as latlng;

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // Property
  late Position currentPosition; // 현재 위치
  late int kindChoice; // 앱바에 있는 버튼 선택 값
  late double latData; // 위도
  late double longData; // 경도
  late MapController mapController; // controller라서 setstate 필요없음
  late bool canRun; // GPS 신호 수신 여부
  late List location; // 앱바 버튼 타이틀

// Segment Widget
  Map<int, Widget> segmentWidgets = {
    0: SizedBox(
      child: Text(
        '현위치',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 12,
        ),
      )
    ),
    1: SizedBox(
      child: Text(
        '둘리뮤지엄',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 12,
        ),
      )
    ),
    2: SizedBox(
      child: Text(
        '서대문형무소역사관',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 12,
        ),
      )
    ),
  };

  @override
  void initState() {
    super.initState();
    kindChoice = 0;
    mapController = MapController();
    canRun = false;
    location = ['현재 위치', '둘리 뮤지엄', '서대문 형무소 역사관'];
    checkLocationPermission();
  }

  checkLocationPermission() async{
    LocationPermission permission = await Geolocator.checkPermission();
    if(permission == LocationPermission.denied){
      permission = await Geolocator.requestPermission();
    }

    if(permission == LocationPermission.deniedForever){
      return;
    }

    if(permission == LocationPermission.whileInUse || permission == LocationPermission.always){
      getCurrentLocation();
    }
  }

  getCurrentLocation() async{ // GPS신호가 언제들어올지 모르므로 awiat
    Position position = await Geolocator.getCurrentPosition(); // position받을 때까지 대기
    currentPosition = position;
    canRun = true;
    latData = currentPosition.latitude;
    longData = currentPosition.longitude;
    setState(() {});
  } // async, await 꼭 들어가야함


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        title: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('GPS & Map'),
              ),
              CupertinoSegmentedControl(
                groupValue: kindChoice,
                children: segmentWidgets, // 코드가 복잡해져서 위에 씀
                onValueChanged: (value) {
                  kindChoice = value;
                  if(kindChoice == 0){
                    getCurrentLocation(); // 화면이 바뀌었을 때 사용자의 위치가 다시 바뀌었을 수도 있으니까.
                    latData = currentPosition.latitude; // currentPosion에서 가져온다. 그래서 전역변수로 잡았다.
                    longData = currentPosition.longitude;
                    mapController.move(  // 움직였으니 맵 위치도 바뀌었을 것이다.
                      latlng.LatLng(latData, longData), // import 'package:latlong2/latlong.dart' as latlng; 추가. 중앙값
                      17.0,); // 확대값
                  }else if(kindChoice == 1){
                    latData = 37.65243153;
                    longData = 127.0276397;
                    mapController.move(
                      latlng.LatLng(latData, longData), 
                      17.0,);
                  }else{
                    latData = 37.57244171;
                    longData = 126.9595412;
                    mapController.move(
                      latlng.LatLng(latData, longData), 
                      17.0,);
                  }
                  setState(() {});
                },
              ),
            ],
          ),
        ),
      ),
      body: canRun
          ? flutterMap()
          : Center(
            child: CircularProgressIndicator(), // 로딩화면
          )
    );
  } // build

  // ---- Widgets ----
  Widget flutterMap(){
    return FlutterMap(
      mapController: mapController,
      options: MapOptions(
        initialCenter: latlng.LatLng(latData, longData), initialZoom: 17.0
      ),
      children: [
        TileLayer( // 큰 이미지를 쪼개서 빠른 것부터 보여줌
          urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png", // 화면을 잘라서 빨리 가져온 데이터는 빨리 보여준다.
        ),
        MarkerLayer(
          markers: [
            Marker(
              width: 80,
              height: 80,
              point: latlng.LatLng(latData, longData), 
              child: Column(
                children: [
                  SizedBox(
                    child: Text(
                      location[kindChoice],
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Colors.black
                      ),
                    ),
                  ),
                  Icon(
                    Icons.pin_drop,
                    size: 50,
                    color: Colors.red,
                  )
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

} // class
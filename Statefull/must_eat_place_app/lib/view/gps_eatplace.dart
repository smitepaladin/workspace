import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';

class GpsEatplace extends StatefulWidget {
  const GpsEatplace({super.key});

  @override
  State<GpsEatplace> createState() => _GpsEatplaceState();
}

class _GpsEatplaceState extends State<GpsEatplace> {
  final MapController mapController = MapController();

  late double latData;       // 맛집 위도
  late double longData;      // 맛집 경도
  late String eatplaceName;  // 맛집 이름
  LatLng? userLocation;      // 사용자 현재 위치

  @override
  void initState() {
    super.initState();

    // Get.arguments로 전달받은 데이터
    final value = Get.arguments ?? "__";
    eatplaceName = value[1];
    latData = value[2];
    longData = value[3];

    // 맛집 위치로 지도 이동
    WidgetsBinding.instance.addPostFrameCallback((_) {
      mapController.move(LatLng(latData, longData), 18.0);
    });

    _getUserLocation();
  }

  Future<void> _getUserLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return;

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.whileInUse || permission == LocationPermission.always) {
      Position position = await Geolocator.getCurrentPosition();
      setState(() {
        userLocation = LatLng(position.latitude, position.longitude);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final LatLng eatplaceLocation = LatLng(latData, longData);

    List<Marker> markers = [
      // 맛집 위치 마커
      Marker(
        point: eatplaceLocation,
        width: 100,
        height: 100,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4),
                ),
              child: Text(
                eatplaceName,
                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            const Icon(
              Icons.location_on,
              color: Colors.red,
              size: 40,
            ),
          ],
        ),
      ),
    ];

    // 사용자 위치 마커 추가
    if (userLocation != null) {
      markers.add(
        Marker(
          point: userLocation!,
          width: 40,
          height: 40,
          child: const Icon(
            Icons.person_pin_circle,
            color: Colors.blue,
            size: 40,
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text("맛집 위치")),
      body: FlutterMap(
        mapController: mapController,
        options: MapOptions(
          initialCenter: eatplaceLocation,
          initialZoom: 18,
        ),
        children: [
          TileLayer(
            urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
            subdomains: const ['a', 'b', 'c'],
          ),
          MarkerLayer(markers: markers),
        ],
      ),
    );
  }
}

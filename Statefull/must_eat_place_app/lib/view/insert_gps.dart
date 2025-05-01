import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';

class InsertGps extends StatefulWidget {
  const InsertGps({super.key});

  @override
  State<InsertGps> createState() => _InsertGpsState();
}

class _InsertGpsState extends State<InsertGps> {
  LatLng? selectedLocation;
  LatLng? currentLocation;
  final MapController mapController = MapController();

  final LatLng defaultLocation = LatLng(37.494444, 127.03); // 한국빌딩

  @override
  void initState() {
    super.initState();
    final args = Get.arguments;
    if (args != null && args['lat'] != null && args['long'] != null) {
      selectedLocation = LatLng(args['lat'], args['long']);
    }
    _determinePosition(); // 위치 먼저 받아오고 지도 이동
  }

  Future<void> _determinePosition() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return;

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.whileInUse ||
        permission == LocationPermission.always) {
      Position position = await Geolocator.getCurrentPosition();
      final current = LatLng(position.latitude, position.longitude);
      setState(() {
        currentLocation = current;
      });

      // 위치를 받아온 후 지도 이동
      WidgetsBinding.instance.addPostFrameCallback((_) {
        mapController.move(current, 18.0);
      });
    } else {
      // 권한이 없을 경우 기본 위치로 이동
      WidgetsBinding.instance.addPostFrameCallback((_) {
        mapController.move(defaultLocation, 18.0);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Marker> markers = [];

    if (selectedLocation != null) {
      markers.add(
        Marker(
          point: selectedLocation!,
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
                child: const Text(
                  "선택한 위치",
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
              const Icon(Icons.location_on, color: Colors.red, size: 40),
            ],
          ),
        ),
      );
    }

    if (currentLocation != null) {
      markers.add(
        Marker(
          point: currentLocation!,
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
                child: const Text(
                  "현위치",
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
              const Icon(Icons.person_pin_circle, color: Colors.blue, size: 40),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text("위치 선택")),
      body: FlutterMap(
        mapController: mapController,
        options: MapOptions(
          initialCenter: currentLocation ?? defaultLocation,
          initialZoom: 18,
          onTap: (tapPosition, latlng) {
            setState(() {
              selectedLocation = latlng;
            });
          },
        ),
        children: [
          TileLayer(
            urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
            subdomains: const ['a', 'b', 'c'],
          ),
          MarkerLayer(markers: markers),
        ],
      ),
      floatingActionButton:
          selectedLocation == null
              ? null
              : FloatingActionButton.extended(
                onPressed: () {
                  Get.back(
                    result: {
                      'lat': selectedLocation!.latitude,
                      'long': selectedLocation!.longitude,
                    },
                  );
                },
                label: Text('이 위치 선택'),
                icon: Icon(Icons.check),
              ),
    );
  }
}

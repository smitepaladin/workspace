import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart' as latlng;

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // Property
  late MapController mapController;
  late List castle;

  @override
  void initState() {
    super.initState();
    mapController = MapController();
    castle = [
      ['혜화문', 37.5878892, 127.0037098],
      ['흥인지문', 37.5711907, 127.009506],
      ['창의문', 37.5926027, 126.9664771],
      ['숙정문', 37.5956584, 126.9810576],
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: flutterMap()
    );
  } // build

  // --- Widget Function ---
  Marker makeMarker(String name, double mLat, double mLong, Color mColor){
    return Marker(
      width: 80,
      height: 80,
      point: latlng.LatLng(mLat, mLong),
      child: Builder(builder: (context) {
        return Column(
          children: [
            Text(
              name,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Icon(
              Icons.pin_drop,
              size: 50,
              color: mColor,
            )
          ],
        );
      },),
    );
  }
  // --- Widget ----
  Widget flutterMap(){
    return FlutterMap(
      mapController: mapController,
      options: MapOptions(
        initialCenter: latlng.LatLng(37.5878892, 127.0037098), initialZoom: 13
      ),
      children: [
        TileLayer(
          urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
        ),
        MarkerLayer(
          markers: [
            makeMarker(castle[0][0], castle[0][1], castle[0][2], Colors.black),
            makeMarker(castle[1][0], castle[1][1], castle[1][2], Colors.blue),
            makeMarker(castle[2][0], castle[2][1], castle[2][2], Colors.red),
            makeMarker(castle[3][0], castle[3][1], castle[3][2], Colors.green),
          ],
        ),
      ],
    );
  }
} // class
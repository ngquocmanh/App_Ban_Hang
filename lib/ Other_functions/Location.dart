import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
class MapPage extends StatefulWidget {
  const MapPage({super.key});
  @override
  State<MapPage> createState() => _MapPageState();
}
class _MapPageState extends State<MapPage> {
  final LatLng hanoi = LatLng(21.0278, 105.8342);
  LatLng? selectedPoint;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Chọn vị trí trên bản đồ")),
      body: FlutterMap(
        options: MapOptions(
          initialCenter: hanoi,
          initialZoom: 13,
          onTap: (tapPosition, point) {
            setState(() {
              selectedPoint = point;
            });
          },
        ),
        children: [

          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'com.example.app_01',
          ),

          if (selectedPoint != null)
            MarkerLayer(
              markers: [
                Marker(
                  point: selectedPoint!,
                  width: 60,
                  height: 60,
                  child: const Icon(Icons.location_on, color: Colors.red, size: 40),
                ),
              ],
            ),
        ],
      ),
      bottomNavigationBar: selectedPoint == null
          ? const SizedBox.shrink()
          : Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context, selectedPoint);
          },
          child: const Text("Xác nhận vị trí"),
        ),
      ),
    );
  }
}

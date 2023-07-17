import 'package:dtt/logic/parent_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';

class MapLayer extends StatefulWidget {
  const MapLayer({super.key, required this.longitude, required this.latitude});
  final int longitude;
  final int latitude;

  @override
  State<MapLayer> createState() => _MapLayerState();
}

class _MapLayerState extends State<MapLayer> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: SizedBox(
          height: MediaQuery.sizeOf(context).height / 2.5,
          width: MediaQuery.sizeOf(context).width,
          child: FlutterMap(
            options: MapOptions(
              keepAlive: true,
              center: LatLng(
                  widget.latitude.toDouble(), widget.longitude.toDouble()),
              zoom: 15,
              enableMultiFingerGestureRace: true,
              enableScrollWheel: true,
              maxZoom: 15,
              minZoom: 5,
            ),
            children: [
              GestureDetector(
                onTap: () {
                  Provider.of<ParentProvider>(context, listen: false)
                      .openGoogleMaps(widget.latitude.toDouble(),
                          widget.longitude.toDouble());
                },
                child: TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'com.example.app',
                ),
              ),
              MarkerLayer(
                rotate: true,
                markers: [
                  Marker(
                    width: 40.0,
                    height: 40.0,
                    point: LatLng(widget.latitude.toDouble(),
                        widget.longitude.toDouble()),
                    builder: (context) => const Icon(
                      Icons.location_pin,
                      color: Colors.red,
                    ),
                  ),
                ],
              )
            ],
          )),
    );
  }
}

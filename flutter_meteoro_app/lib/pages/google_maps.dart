import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_meteoro_app/pages/location_service.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapsPage extends StatefulWidget {
  const MapsPage({Key? key}) : super(key: key);

  @override
  State<MapsPage> createState() => MapPageState();
}

class MapPageState extends State<MapsPage> {
  final Completer<GoogleMapController> _controller = Completer();
  final TextEditingController _searchController = TextEditingController();

  Set<Marker> _markers = Set<Marker>();
  Set<Polygon> _polygons = Set<Polygon>();
  Set<Polyline> _polylines = Set<Polyline>();
  List<LatLng> polygonLatLngs = <LatLng>[];

  int _polygonIdCounter = 1;
  int _polylineIdCounter = 1;

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.3824, -5.9761),
    zoom: 14,
  );

  @override
  void initState() {
    super.initState();

    _setMarker(LatLng(37.3824, -5.9761));
  }

  void _setMarker(LatLng point) {
    setState(() {
      _markers.add(
        Marker(
          markerId: MarkerId('marker'),
          position: point,
        ),
      );
    });
  }

  void _setPolygon() {
    final String polygonIdVal = 'polygon_$_polygonIdCounter';
    _polygonIdCounter++;

    _polygons.add(
      Polygon(
        polygonId: PolygonId(polygonIdVal),
        points: polygonLatLngs,
        strokeWidth: 2,
        fillColor: Colors.transparent,
      ),
    );
  }

  void _setPolyline(List<PointLatLng> points) {
    final String polylineIdVal = 'polyline_$_polylineIdCounter';
    _polylineIdCounter++;

    _polylines.add(
      Polyline(
        polylineId: PolylineId(polylineIdVal),
        width: 2,
        color: Colors.blue,
        points: points
            .map(
              (point) => LatLng(point.latitude, point.longitude),
            )
            .toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Google Maps'),
      ),
      body: Column(
        children: [
          Row(children: [
            Expanded(
              child: Column(
                children: [
                  TextFormField(
                    controller: _searchController,
                    decoration: InputDecoration(hintText: 'Buscar ciudad'),
                    onChanged: (value) {
                      print(value);
                    },
                  ),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () async {
                var place =
                    await LocationService().getPlace(_searchController.text);
                _goToPlace(place);
              },
            )
          ]),
          Expanded(
            child: GoogleMap(
              mapType: MapType.normal,
              markers: _markers,
              polygons: _polygons,
              polylines: _polylines,
              initialCameraPosition: _kGooglePlex,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
              onTap: (point) {
                setState(() {
                  polygonLatLngs.add(point);
                  _setPolygon();
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _goToPlace(Map<String, dynamic> place) async {
    final double lat = place['geometry']['location']['lat'];
    final double lng = place['geometry']['location']['lng'];

    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(lat, lng), zoom: 13)));
  }
}

































/*
  AIzaSyCDr9iGazfCzJ-AGLlzPb8hPcDUW4NdNGw API-KEY


      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: Text('Map App'),
        actions: [
          DropdownButton<MapType>(
            dropdownColor: Colors.blue[900],
            isDense: true,
            isExpanded: false,
            iconEnabledColor: Colors.white,
            focusColor: Colors.white,
            items: options.map((MapType dropDownStringItem) {
              return DropdownMenuItem<MapType>(
                value: dropDownStringItem,
                child: Text(
                  dropDownStringItem.toString(),
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              );
            }).toList(),
            onChanged: (newValueSelected) {
              setState(() {
                _currentItemSelected = newValueSelected!;
                typemap = newValueSelected;
              });
            },
            value: _currentItemSelected,
          ),
        ],
      ),


 */
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_meteoro_app/models/maps.dart';
import 'package:flutter_meteoro_app/pages/location_service.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';


const CameraPosition _kInitialPosition =
    CameraPosition(target: LatLng(37.3824, -5.9761), zoom: 9.0);

class MapsPage extends GoogleMapResponse {
  const MapsPage() : super(const Icon(Icons.mouse), 'Map click');
  @override
  Widget build(BuildContext context) {
    return const _MapsPage();
  }
}

class _MapsPage extends StatefulWidget {
  const _MapsPage();
  @override
  State<StatefulWidget> createState() => _MapPageState();
}

class _MapPageState extends State<_MapsPage> {
  _MapPageState();
  GoogleMapController? mapController;
  LatLng _lastTap = LatLng(37.3824, -5.9761);
  LatLng? _lastLongPress;
  @override
  Widget build(BuildContext context) {
    final GoogleMap googleMap = GoogleMap(
      onMapCreated: onMapCreated,
      initialCameraPosition: _kInitialPosition,
      onTap: (LatLng pos) async {
        setState(() {
          _lastTap = pos;
        });
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setDouble('lat', pos.latitude);
        prefs.setDouble('lng', pos.longitude);
      },
      markers: <Marker>{_createMarker()},
      onLongPress: (LatLng pos) {
        setState(() {
          _lastLongPress = pos;
        });
      },
    );
    final List<Widget> columnChildren = <Widget>[
      Padding(
        padding: const EdgeInsets.only(top: 0),
        child: Center(
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height - 155,
            child: googleMap,
          ),
        ),
      ),
    ];
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Column(
          children: buscador(),
        ),
        Column(
          children: columnChildren,
        ),
      ],
    );
  }

  List<Widget> buscador() {
    return <Widget>[
      // Replace this container with your Map widget
      Container(
        color: Colors.black,
      ),
      Positioned(
        top: 10,
        right: 15,
        left: 15,
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.only(top: 50, bottom: 0),
            child: Row(
              children: const <Widget>[
                Expanded(
                  child: TextField(
                    cursorColor: Colors.blue,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.go,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 18),
                        hintText: "Buscar..."),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ];
  }

  void onMapCreated(GoogleMapController controller) async {
    setState(() {
      mapController = controller;
    });
  }

  Marker _createMarker() {
    return Marker(
      markerId: MarkerId("marker_1"),
      position: _lastTap,
    );
  }
}


/*
  AIzaSyCDr9iGazfCzJ-AGLlzPb8hPcDUW4NdNGw API-KEY
*/
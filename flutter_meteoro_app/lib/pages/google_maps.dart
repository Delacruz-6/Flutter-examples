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
  final Completer<GoogleMapController> _controller = Completer();
  GoogleMapController? controller;
  TextEditingController _searchController = TextEditingController();
  double lat = 37.3824;
  double lng = -5.9761;
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
        lat = pos.latitude;
        lng = pos.longitude;
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
            height: MediaQuery.of(context).size.height - 225,
            child: googleMap,
          ),
        ),
      ),
    ];
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Color(0xffA7B4E0),
          title: Center(child: Text('Busca un lugar donde ver el tiempo'))),
      body: SingleChildScrollView(
        child: Column(
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
        ),
      ),
    );
  }

  List<Widget> buscador() {
    return <Widget>[
      Row(
        children: [
          Expanded(
            child: SizedBox(
              height: 50.0,
              child: Row(
                children: const <Widget>[
                  Expanded(
                    child: TextField(
                      cursorColor: Color(0xffA7B4E0),
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
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () async {
              var place =
                  await LocationService().getPlace(_searchController.text);
              _goToPlace(place);
            },
          )
        ],
      ),
    ];
  }

  Future<void> _goToPlace(Map<String, dynamic> place) async {
    final double lat = place['geometry']['location']['lat'];
    final double lng = place['geometry']['location']['lng'];
  }

  void onMapCreated(GoogleMapController Mcontroller) async {
    setState(() {
      controller = Mcontroller;
    });
  }

  Marker _createMarker() {
    return Marker(
      markerId: MarkerId("marker"),
      position: LatLng(lat, lng),
    );
  }
}



/*
  AIzaSyCDr9iGazfCzJ-AGLlzPb8hPcDUW4NdNGw API-KEY
*/
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_meteoro_app/pages/location_service.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapsPage extends StatefulWidget {
  const MapsPage({Key? key}) : super(key: key);

  @override
  _MapsPageState createState() => _MapsPageState();
}

class _MapsPageState extends State<MapsPage> {
  final Completer<GoogleMapController> _controller = Completer();
  GoogleMapController? controller;
  TextEditingController _searchController = TextEditingController();

  final CameraPosition initialPosition =
      CameraPosition(target: LatLng(37.3824, -5.9761), zoom: 14);
  var typemap = MapType.normal;
  var cordinate1 = 'cordinate';
  var lat = 37.3824;
  var long = -5.9761;
  var address = '';
  var options = [
    MapType.normal,
    MapType.hybrid,
    MapType.terrain,
    MapType.satellite,
  ];

  var _currentItemSelected = MapType.normal;

  Future<void> getAddress(latt, longg) async {
    List<Placemark> placemark = await placemarkFromCoordinates(latt, longg);
    print(
        '-----------------------------------------------------------------------------------------');
    //here you can see your all the relevent information based on latitude and logitude no.
    print(placemark);
    print(
        '-----------------------------------------------------------------------------------------');
    Placemark place = placemark[0];
    setState(() {
      address =
          '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Busca un lugar donde ver el tiempo')),
      body: Column(
        children: [
          Row(children: [
            Expanded(
                child: TextFormField(
                    controller: _searchController,
                    textCapitalization: TextCapitalization.words,
                    decoration: InputDecoration(hintText: 'Buscar ciudad'),
                    onChanged: (value) {
                      print(value);
                    })),
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
              initialCameraPosition: initialPosition,
              mapType: typemap,
              onMapCreated: (controller) {
                setState(() {
                  controller = controller;
                });
              },
              onTap: (cordinate) {
                setState(() {
                  lat = cordinate.latitude;
                  long = cordinate.longitude;
                  getAddress(lat, long);

                  cordinate1 = cordinate.toString();
                });
              },
            ),
          ),
          Text(
            cordinate1,
            softWrap: false,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
          Container(
            width: 200,
            child: Text(
              address,
              softWrap: true,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
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
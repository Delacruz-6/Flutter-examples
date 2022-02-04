// ignore_for_file: import_of_legacy_library_into_null_safe

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_meteoro_app/models/city.dart';
import 'package:flutter_meteoro_app/models/earthWeather.dart';
// ignore: unused_import
//import 'package:intl/intl_browser.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class EarthWeatherPage extends StatefulWidget {
  const EarthWeatherPage({Key? key}) : super(key: key);

  @override
  _MoviesPageState createState() => _MoviesPageState();
}

class _MoviesPageState extends State<EarthWeatherPage> {
  late Future<List<Hourly>> itemsHours;
  late Future<List<Daily>> itemsDayly;
  late Future<String> nameLocation;
  late Future<int> fechaLocation;

  @override
  // ignore: override_on_non_overriding_member
  void initState() {
    super.initState();
    itemsHours = fetchHours();
    itemsDayly = fetchDayly();
    nameLocation = fetchNameCity();
    fechaLocation = fetchFechaCity();
  }

//http://openweathermap.org/img/wn/10d@2x.png  IconButton
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: [
      Padding(
        padding: const EdgeInsets.only(top: 30),
        child: Column(children: [
          FutureBuilder<String>(
            future: nameLocation,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return _getLocation(snapshot.data!);
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }
              // By default, show a loading spinner.
              return const CircularProgressIndicator();
            },
          ),
          FutureBuilder<int>(
            future: fechaLocation,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return _getFecha(snapshot.data!);
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }
              // By default, show a loading spinner.
              return const CircularProgressIndicator();
            },
          ),
        ]),
      ),
      FutureBuilder<List<Hourly>>(
        future: itemsHours,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return _HoursList(snapshot.data!);
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }
          // By default, show a loading spinner.
          return const CircularProgressIndicator();
        },
      ),
    ]));
  }
/*
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Hourly>>(
      future: itemsHours,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return _HoursList(snapshot.data!);
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }

        // By default, show a loading spinner.
        return const CircularProgressIndicator();
      },
    );
  }
}
*/

  Future<List<Hourly>> fetchHours() async {
    final response = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/onecall?lat=37.3824&lon=-5.9761&exclude=minutely&appid=4746be909c612853dd1618735b09914f&units=metric'));
    if (response.statusCode == 200) {
      return OneCallResponse.fromJson(jsonDecode(response.body)).hourly;
    } else {
      throw Exception('Failed to load people');
    }
  }

  Future<List<Daily>> fetchDayly() async {
    final response = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/onecall?lat=37.3824&lon=-5.9761&exclude=minutely&appid=4746be909c612853dd1618735b09914f&units=metric'));
    if (response.statusCode == 200) {
      return OneCallResponse.fromJson(jsonDecode(response.body)).daily;
    } else {
      throw Exception('Failed to load people');
    }
  }

  Future<String> fetchNameCity() async {
    final response = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=Seville&appid=4746be909c612853dd1618735b09914f'));
    if (response.statusCode == 200) {
      return CityResponse.fromJson(jsonDecode(response.body)).name;
    } else {
      throw Exception('Failed to load people');
    }
  }

  Future<int> fetchFechaCity() async {
    final response = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=Seville&appid=4746be909c612853dd1618735b09914f'));
    if (response.statusCode == 200) {
      return CityResponse.fromJson(jsonDecode(response.body)).dt;
    } else {
      throw Exception('Failed to load people');
    }
  }

  Widget _getLocation(String name) {
    return Text(name, style: TextStyle(fontSize: 20));
  }

  Widget _getFecha(int name) {
    //DateTime.fromMillisecondsSinceEpoch(name * 10000).toString()
    final DateTime now = DateTime.fromMillisecondsSinceEpoch(name * 1000);
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String formatted = formatter.format(now);
    return Text(formatted.toString(), style: TextStyle(fontSize: 20));
  }

  Widget _HoursList(List<Hourly> HoursList) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: HoursList.length,
        itemBuilder: (context, index) {
          return _HoursItem(HoursList.elementAt(index));
        },
      ),
    );
  }

  Widget _DaylyList(List<Daily> DaylyList) {
    return SizedBox(
      height: 350,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: DaylyList.length,
        itemBuilder: (context, index) {
          return _DaylyItem(DaylyList.elementAt(index));
        },
      ),
    );
  }

  Widget _HoursItem(Hourly hourly) {
    return Column(
      children: [
        Container(
            height: 150.0,
            width: 250,
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
              margin: EdgeInsets.all(10),
              elevation: 10,
              child: Container(
                width: 150.0,
                child: Container(
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: Column(
                        // AÑADIR LA HORA DEL DIA CON hourly.dt y uso el format para sacar la hora //
                        children: [
                          Row(children: <Widget>[
                            Image.network(
                                'http://openweathermap.org/img/wn/${hourly.weather[0].icon}@2x.png'),
                            Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 5),
                                    child: Text(hourly.temp.toString() + 'º',
                                        style: TextStyle(
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 5),
                                    child: Text('Viento: ' +
                                        hourly.temp.toString() +
                                        'km/h'),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 5),
                                    child: Text('Humedad: ' +
                                        hourly.humidity.toString() +
                                        '%'),
                                  )
                                ])
                          ]),
                        ],
                      )),
                ),
              ),
            )),
      ],
    );
  }

  Widget _DaylyItem(Daily daily) {
    return Column(
      children: [
        Container(
            height: 300.0,
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
              margin: EdgeInsets.all(10),
              elevation: 10,
              child: Container(
                width: 150.0,
                child: Container(
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: Column(children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 2),
                          child: Text(daily.clouds.toString(),
                              style: TextStyle(
                                  fontSize: 10, fontWeight: FontWeight.bold)),
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(daily.temp.min.toString()),
                              Text(daily.temp.max.toString()),
                              Text(daily.clouds.toString())
                            ])
                      ])),
                ),
              ),
            )),
      ],
    );
  }
}

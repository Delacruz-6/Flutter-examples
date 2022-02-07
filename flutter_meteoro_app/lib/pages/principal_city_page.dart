// ignore_for_file: import_of_legacy_library_into_null_safe

import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_meteoro_app/models/city.dart';
import 'package:flutter_meteoro_app/models/earthWeather.dart';
// ignore: unused_import
//import 'package:intl/intl_browser.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:shared_preferences/shared_preferences.dart';
// initializeDateFormatting('es_ES', null).then((_) => runMyCode());

class EarthWeatherPage extends StatefulWidget {
  const EarthWeatherPage({Key? key}) : super(key: key);

  @override
  _PrincipalPageState createState() => _PrincipalPageState();
}

class _PrincipalPageState extends State<EarthWeatherPage> {
  late String nombreCiudad = 'Sevilla';
  late Future<List<Hourly>> itemsHours;
  late Future<List<Daily>> itemsDayly;
  late Future<double> itemDaylyTempMax, itemDaylyTempMin;

  late Future<String> nameLocation;
  late Future<int> fechaLocation;
  late Future<String> iconLocation;

  @override
  // ignore: override_on_non_overriding_member
  void initState() {
    super.initState();
    itemsHours = fetchHours();
    itemsDayly = fetchDayly();
    itemDaylyTempMax = fetchDaylyNowTempMax();
    itemDaylyTempMin = fetchDaylyNowTempMin();

    nameLocation = fetchNameCity();
    fechaLocation = fetchFechaCity();
    iconLocation = fetchIconCity();
    loadNombreCiudad();
  }

  loadNombreCiudad() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      String _nombreciudad = ((prefs.getString('nombreCiudad') ?? 'Sevilla'));
      nombreCiudad = _nombreciudad;
    });
  }

//http://openweathermap.org/img/wn/10d@2x.png  IconButton
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xff828CAE),
        body: SingleChildScrollView(
            child: Column(children: [
          Padding(
            padding: const EdgeInsets.only(top: 60),
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
              Image.network('http://openweathermap.org/img/wn/10n@2x.png'),
              FutureBuilder<String>(
                future: iconLocation,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return _getIcon(snapshot.data!);
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  }
                  // By default, show a loading spinner.
                  return const CircularProgressIndicator();
                },
              ),
              Padding(
                padding: const EdgeInsets.only(left: 120, right: 60),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 5),
                      child: FutureBuilder<double>(
                        future: itemDaylyTempMax,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return _getDaylyNow(snapshot.data!);
                          } else if (snapshot.hasError) {
                            return Text('${snapshot.error}');
                          }
                          // By default, show a loading spinner.
                          return const CircularProgressIndicator();
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: FutureBuilder<double>(
                        future: itemDaylyTempMin,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return _getDaylyNowTempMin(snapshot.data!);
                          } else if (snapshot.hasError) {
                            return Text('${snapshot.error}');
                          }
                          // By default, show a loading spinner.
                          return const CircularProgressIndicator();
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ]),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 205, top: 20, bottom: 5),
            child: const Text('Previsión por horas',
                style: TextStyle(fontSize: 18)),
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
          Padding(
            padding: const EdgeInsets.only(right: 205, bottom: 5),
            child: const Text('Previsión por dias',
                style: TextStyle(fontSize: 18)),
          ),
          FutureBuilder<List<Daily>>(
            future: itemsDayly,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return _DaylyList(snapshot.data!);
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }
              // By default, show a loading spinner.
              return const CircularProgressIndicator();
            },
          ),
        ])));
  }

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

  Future<double> fetchDaylyNowTempMax() async {
    final response = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/onecall?lat=37.3824&lon=-5.9761&exclude=minutely&appid=4746be909c612853dd1618735b09914f&units=metric'));
    if (response.statusCode == 200) {
      return OneCallResponse.fromJson(jsonDecode(response.body))
          .daily[0]
          .temp
          .max;
    } else {
      throw Exception('Failed to load people');
    }
  }

  Future<double> fetchDaylyNowTempMin() async {
    final response = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/onecall?lat=37.3824&lon=-5.9761&exclude=minutely&appid=4746be909c612853dd1618735b09914f&units=metric'));
    if (response.statusCode == 200) {
      return OneCallResponse.fromJson(jsonDecode(response.body))
          .daily[0]
          .temp
          .min;
    } else {
      throw Exception('Failed to load people');
    }
  }

  Widget _getDaylyNow(double daily) {
    return Text(daily.toStringAsFixed(0) + 'º',
        style: TextStyle(fontSize: 45, fontWeight: FontWeight.bold));
  }

  Widget _getDaylyNowTempMin(double daily) {
    return Text(daily.toStringAsFixed(0) + 'º',
        style: TextStyle(fontSize: 45, fontWeight: FontWeight.bold));
  }

  Future<String> fetchNameCity() async {
    final response = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=${nombreCiudad}&appid=4746be909c612853dd1618735b09914f'));
    if (response.statusCode == 200) {
      return CityResponse.fromJson(jsonDecode(response.body)).name;
    } else {
      throw Exception('Failed to load people');
    }
  }

  Future<int> fetchFechaCity() async {
    final response = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=${nombreCiudad}&appid=4746be909c612853dd1618735b09914f'));
    if (response.statusCode == 200) {
      return CityResponse.fromJson(jsonDecode(response.body)).dt;
    } else {
      throw Exception('Failed to load people');
    }
  }

  Future<String> fetchIconCity() async {
    final response = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=${nombreCiudad}&appid=4746be909c612853dd1618735b09914f'));
    if (response.statusCode == 200) {
      return CityResponse.fromJson(jsonDecode(response.body)).weather[0].icon;
    } else {
      throw Exception('Failed to load people');
    }
  }

  Widget _getIcon(String icon) {
    return Text(icon);
  }

  Widget _getIcons() {
    return FutureBuilder<String>(
      future: iconLocation,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return _getIcon(snapshot.data!);
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }
        // By default, show a loading spinner.
        return const CircularProgressIndicator();
      },
    );
  }

  Widget _getLocation(String name) {
    return Text(name,
        style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold));
  }

  Widget _getFecha(int name) {
    initializeDateFormatting('es_ES', null).then((_) => _getFecha);
    final DateTime now = DateTime.fromMillisecondsSinceEpoch(name * 1000);
    final DateFormat formatter = DateFormat.yMMMMd('es_ES');
    final String formatted = formatter.format(now);
    return Text(formatted.toString(), style: TextStyle(fontSize: 15));
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
      height: 200,
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
    initializeDateFormatting('es_ES', null).then((_) => _getFecha);
    final DateTime now = DateTime.fromMillisecondsSinceEpoch(hourly.dt * 1000);
    final DateFormat formatterHora = DateFormat.Hm();
    final DateFormat formatterFecha = DateFormat.MMMd('es_ES');
    final String hora = formatterHora.format(now);
    final String fecha = formatterFecha.format(now);

    return Column(
      children: [
        Container(
            height: 140.0,
            width: 250,
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
              margin: EdgeInsets.all(5),
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
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 8, bottom: 5, right: 25),
                                        child: Text(hora,
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            )),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 8, bottom: 5),
                                        child: Text(fecha,
                                            style: TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.bold,
                                            )),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 5),
                                    child: Text(
                                        hourly.temp.toStringAsFixed(0) + 'º',
                                        style: TextStyle(
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 5),
                                    child: Text('Viento: ' +
                                        hourly.windSpeed.toStringAsFixed(1) +
                                        ' km/h'),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 5),
                                    child: Text('Humedad: ' +
                                        hourly.humidity.toString() +
                                        ' %'),
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
    initializeDateFormatting('es_ES', null).then((_) => _getFecha);
    final DateTime now = DateTime.fromMillisecondsSinceEpoch(daily.dt * 1000);
    final DateFormat formatter = DateFormat.MMMd('es_ES');
    final DateFormat formatterDia = DateFormat.EEEE('es_ES');
    final String dia = formatterDia.format(now);
    final String fecha = formatter.format(now);
    return Column(
      children: [
        Container(
            height: 140.0,
            width: 250,
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
              margin: EdgeInsets.all(5),
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
                                'http://openweathermap.org/img/wn/${daily.weather[0].icon}@2x.png'),
                            Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 8, bottom: 5),
                                    child: Text('${dia}\n${fecha}',
                                        style: TextStyle(
                                          fontSize: 18,
                                        )),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 5),
                                    child: Text(
                                        daily.temp.max.toStringAsFixed(0) +
                                            'º ' +
                                            daily.temp.min.toStringAsFixed(0) +
                                            'º',
                                        style: TextStyle(
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 5),
                                    child: Text('Viento: ' +
                                        daily.windSpeed.toStringAsFixed(1) +
                                        ' km/h'),
                                  ),
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
}

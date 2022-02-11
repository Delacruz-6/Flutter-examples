import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_meteoro_app/models/city.dart';
import 'package:flutter_meteoro_app/models/earthWeather.dart';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter_meteoro_app/pages/principal_city_page.dart';

late double lat = 0;
late double long = 0;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String ciudadValor = 'Sevilla';
  late Future<double> itemDaylyTemp;

  late Future<String> nameLocation;
  late Future<int> fechaLocation;
  late Future<String> iconLocation;
  late Future<int> itemDailyHumidity;
  late Future<double> itemDailywindSpeed;
  late Future<int> itemDailyPressure;
  late Future<double> itemDailyFeelLike;
  //late Future<int> itemDailyVisibility;
  @override
  void initState() {
    nameLocation = fetchNameCity();
    fechaLocation = fetchFechaCity();
    iconLocation = fetchIconCity();
    itemDaylyTemp = fetchDaylyNowTemp();
    itemDailyHumidity = fetchDaylyNowHumidity();
    itemDailywindSpeed = fetchDaylyNowWindSpeed();
    itemDailyPressure = fetchDaylyNowPressure();
    itemDailyFeelLike = fetchDaylyNowfeelLike();
    //itemDailyVisibility= fetchDaylyNowVisilibity();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (lat == 0) {
      return Scaffold(
          backgroundColor: Color(0xff828CAE),
          body: SingleChildScrollView(
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 60, bottom: 30),
                  child: Text(
                    'Bienvenido',
                    style: TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const Image(image: AssetImage('assets/images/fondo.jpg')),
                const Padding(
                  padding: EdgeInsets.only(top: 30),
                  child: Text(
                    'Añadir ubicación \n predeterminada',
                    style: TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ));
    } else {
      return Scaffold(
          backgroundColor: Color(0xff828CAE),
          body: SingleChildScrollView(
              child: Center(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 80, bottom: 15),
                  child: Card(
                      color: Color(0xffA7B4E0),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      margin: EdgeInsets.all(5),
                      elevation: 6,
                      child: Container(
                          width: 300.0,
                          child: Container(
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: Column(children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 5),
                                      child: Column(children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: FutureBuilder<int>(
                                            future: fechaLocation,
                                            builder: (context, snapshot) {
                                              if (snapshot.hasData) {
                                                return _getFecha(
                                                    snapshot.data!);
                                              } else if (snapshot.hasError) {
                                                return Text(
                                                    '${snapshot.error}');
                                              }
                                              // By default, show a loading spinner.
                                              return const CircularProgressIndicator();
                                            },
                                          ),
                                        ),
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
                                          padding: const EdgeInsets.all(12.0),
                                          child: FutureBuilder<String>(
                                            future: nameLocation,
                                            builder: (context, snapshot) {
                                              if (snapshot.hasData) {
                                                return _getLocation(
                                                    snapshot.data!);
                                              } else if (snapshot.hasError) {
                                                return Text(
                                                    '${snapshot.error}');
                                              }
                                              // By default, show a loading spinner.
                                              return const CircularProgressIndicator();
                                            },
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 80, right: 60, bottom: 5),
                                          child: FutureBuilder<double>(
                                            future: itemDaylyTemp,
                                            builder: (context, snapshot) {
                                              if (snapshot.hasData) {
                                                return _getDaylyNowTemp(
                                                    snapshot.data!);
                                              } else if (snapshot.hasError) {
                                                return Text(
                                                    '${snapshot.error}');
                                              }
                                              // By default, show a loading spinner.
                                              return const CircularProgressIndicator();
                                            },
                                          ),
                                        ),
                                      ]),
                                    ),
                                  ]))))),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Card(
                          color: Color(0xffA7B4E0),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          margin: EdgeInsets.all(5),
                          elevation: 4,
                          child: Container(
                              width: 150.0,
                              child: Container(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(5),
                                        child: Text('Humedad',
                                            style: TextStyle(
                                                fontSize: 26,
                                                color: Colors.white)),
                                      ),
                                      FutureBuilder<int>(
                                        future: itemDailyHumidity,
                                        builder: (context, snapshot) {
                                          if (snapshot.hasData) {
                                            return _getDaylyNowHumidity(
                                                snapshot.data!);
                                          } else if (snapshot.hasError) {
                                            return Text('${snapshot.error}');
                                          }
                                          // By default, show a loading spinner.
                                          return const CircularProgressIndicator();
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ))),
                      Card(
                          color: Color(0xffA7B4E0),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          margin: EdgeInsets.all(5),
                          elevation: 4,
                          child: Container(
                              width: 150.0,
                              child: Container(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(5),
                                        child: Text('Vel. viento',
                                            style: TextStyle(
                                                fontSize: 26,
                                                color: Colors.white)),
                                      ),
                                      FutureBuilder<double>(
                                        future: itemDailywindSpeed,
                                        builder: (context, snapshot) {
                                          if (snapshot.hasData) {
                                            return _getDaylyNowWindSpeed(
                                                snapshot.data!);
                                          } else if (snapshot.hasError) {
                                            return Text('${snapshot.error}');
                                          }
                                          // By default, show a loading spinner.
                                          return const CircularProgressIndicator();
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ))),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Card(
                          color: Color(0xffA7B4E0),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          margin: EdgeInsets.all(5),
                          elevation: 4,
                          child: Container(
                              width: 150.0,
                              child: Container(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(5),
                                        child: Text('Presión',
                                            style: TextStyle(
                                                fontSize: 26,
                                                color: Colors.white)),
                                      ),
                                      FutureBuilder<int>(
                                        future: itemDailyPressure,
                                        builder: (context, snapshot) {
                                          if (snapshot.hasData) {
                                            return _getDaylyNowPreassure(
                                                snapshot.data!);
                                          } else if (snapshot.hasError) {
                                            return Text('${snapshot.error}');
                                          }
                                          // By default, show a loading spinner.
                                          return const CircularProgressIndicator();
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ))),
                      Card(
                          color: Color(0xffA7B4E0),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          margin: EdgeInsets.all(5),
                          elevation: 4,
                          child: Container(
                              width: 150.0,
                              child: Container(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(5),
                                        child: Text('Feel like',
                                            style: TextStyle(
                                                fontSize: 26,
                                                color: Colors.white)),
                                      ),
                                      FutureBuilder<double>(
                                        future: itemDailyFeelLike,
                                        builder: (context, snapshot) {
                                          if (snapshot.hasData) {
                                            return _getDaylyNowFeelLike(
                                                snapshot.data!);
                                          } else if (snapshot.hasError) {
                                            return Text('${snapshot.error}');
                                          }
                                          // By default, show a loading spinner.
                                          return const CircularProgressIndicator();
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ))),
                    ],
                  ),
                ),
              ],
            ),
          )));
    }
  }

  Future<List<Hourly>> fetchHours() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    lat = prefs.getDouble('lat')!;
    long = prefs.getDouble('lng')!;

    if (lat == null) {
      lat = 37.3824;
      long = -5.9761;
    }
    final response = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/onecall?lat=${lat}&lon=${long}&exclude=minutely&appid=4746be909c612853dd1618735b09914f&units=metric'));
    if (response.statusCode == 200) {
      return OneCallResponse.fromJson(jsonDecode(response.body)).hourly;
    } else {
      throw Exception('Failed to load people');
    }
  }

  Future<List<Daily>> fetchDayly() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    lat = prefs.getDouble('lat')!;
    long = prefs.getDouble('lng')!;

    if (lat == null) {
      lat = 37.3824;
      long = -5.9761;
    }
    final response = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/onecall?lat=${lat}&lon=${long}&exclude=minutely&appid=4746be909c612853dd1618735b09914f&units=metric'));
    if (response.statusCode == 200) {
      return OneCallResponse.fromJson(jsonDecode(response.body)).daily;
    } else {
      throw Exception('Failed to load people');
    }
  }

  Future<double> fetchDaylyNowTemp() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    lat = prefs.getDouble('lat')!;
    long = prefs.getDouble('lng')!;

    if (lat == null) {
      lat = 37.3824;
      long = -5.9761;
    }
    final response = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?lat=${lat}&lon=${long}&appid=4746be909c612853dd1618735b09914f&units=metric'));
    if (response.statusCode == 200) {
      return CityResponse.fromJson(jsonDecode(response.body)).main.temp;
    } else {
      throw Exception('Failed to load people');
    }
  }

  Future<double> fetchDaylyNowfeelLike() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    lat = prefs.getDouble('lat')!;
    long = prefs.getDouble('lng')!;

    if (lat == null) {
      lat = 37.3824;
      long = -5.9761;
    }
    final response = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?lat=${lat}&lon=${long}&appid=4746be909c612853dd1618735b09914f&units=metric'));
    if (response.statusCode == 200) {
      return CityResponse.fromJson(jsonDecode(response.body)).main.feelsLike;
    } else {
      throw Exception('Failed to load people');
    }
  }

  Future<int> fetchDaylyNowPressure() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    lat = prefs.getDouble('lat')!;
    long = prefs.getDouble('lng')!;

    if (lat == null) {
      lat = 37.3824;
      long = -5.9761;
    }
    final response = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?lat=${lat}&lon=${long}&appid=4746be909c612853dd1618735b09914f&units=metric'));
    if (response.statusCode == 200) {
      return CityResponse.fromJson(jsonDecode(response.body)).main.pressure;
    } else {
      throw Exception('Failed to load people');
    }
  }

  Future<double> fetchDaylyNowWindSpeed() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    lat = prefs.getDouble('lat')!;
    long = prefs.getDouble('lng')!;

    if (lat == null) {
      lat = 37.3824;
      long = -5.9761;
    }
    final response = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?lat=${lat}&lon=${long}&appid=4746be909c612853dd1618735b09914f&units=metric'));
    if (response.statusCode == 200) {
      return CityResponse.fromJson(jsonDecode(response.body)).wind.speed;
    } else {
      throw Exception('Failed to load people');
    }
  }

  Future<int> fetchDaylyNowHumidity() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    lat = prefs.getDouble('lat')!;
    long = prefs.getDouble('lng')!;

    if (lat == null) {
      lat = 37.3824;
      long = -5.9761;
    }
    final response = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?lat=${lat}&lon=${long}&appid=4746be909c612853dd1618735b09914f&units=metric'));
    if (response.statusCode == 200) {
      return CityResponse.fromJson(jsonDecode(response.body)).main.humidity;
    } else {
      throw Exception('Failed to load people');
    }
  }

  Future<int> fetchDaylyNowVisilibity() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    lat = prefs.getDouble('lat')!;
    long = prefs.getDouble('lng')!;

    if (lat == null) {
      lat = 37.3824;
      long = -5.9761;
    }
    final response = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?lat=${lat}&lon=${long}&appid=4746be909c612853dd1618735b09914f&units=metric'));
    if (response.statusCode == 200) {
      return CityResponse.fromJson(jsonDecode(response.body)).visibility;
    } else {
      throw Exception('Failed to load people');
    }
  }

  Widget _getDaylyNowTemp(double daily) {
    return Text(daily.toStringAsFixed(0) + 'º',
        style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold));
  }

  Widget _getDaylyNowConfDou(double daily) {
    return Text(daily.toStringAsFixed(0) + 'º',
        style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold));
  }

  Widget _getDaylyNowHumidity(int daily) {
    return Text(daily.toString() + '%', style: TextStyle(fontSize: 26));
  }

  Widget _getDaylyNowWindSpeed(double daily) {
    return Text(daily.toStringAsFixed(1) + 'km/h',
        style: TextStyle(fontSize: 26));
  }

  Widget _getDaylyNowVisibility(dynamic daily) {
    var result = daily / 1000;
    return Text(result.toString() + 'km', style: TextStyle(fontSize: 26));
  }

  Widget _getDaylyNowPreassure(int daily) {
    return Text(daily.toString() + 'hpa', style: TextStyle(fontSize: 26));
  }

  Widget _getDaylyNowFeelLike(double daily) {
    return Text(daily.toStringAsFixed(0) + 'º', style: TextStyle(fontSize: 26));
  }

  Future<String> fetchNameCity() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    lat = prefs.getDouble('lat')!;
    long = prefs.getDouble('lng')!;

    if (lat == null) {
      lat = 37.3824;
      long = -5.9761;
    }
    final response = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?lat=${lat}&lon=${long}&appid=4746be909c612853dd1618735b09914f'));
    if (response.statusCode == 200) {
      return CityResponse.fromJson(jsonDecode(response.body)).name;
    } else {
      throw Exception('Failed to load people');
    }
  }

  Future<int> fetchFechaCity() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    lat = prefs.getDouble('lat')!;
    long = prefs.getDouble('lng')!;

    if (lat == null) {
      lat = 37.3824;
      long = -5.9761;
    }
    final response = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?lat=${lat}&lon=${long}&appid=4746be909c612853dd1618735b09914f'));
    if (response.statusCode == 200) {
      return CityResponse.fromJson(jsonDecode(response.body)).dt;
    } else {
      throw Exception('Failed to load people');
    }
  }

  Future<String> fetchIconCity() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    lat = prefs.getDouble('lat')!;
    long = prefs.getDouble('lng')!;

    if (lat == null) {
      lat = 37.3824;
      long = -5.9761;
    }
    final response = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?lat=${lat}&lon=${long}&appid=4746be909c612853dd1618735b09914f'));
    if (response.statusCode == 200) {
      return CityResponse.fromJson(jsonDecode(response.body)).weather[0].icon;
    } else {
      throw Exception('Failed to load people');
    }
  }

  Widget _getIcon(String icon) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Container(
          width: 100,
          child: Image(image: AssetImage('assets/images/${icon}.png'))),
    );
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
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold));
  }

  Widget _getFecha(int name) {
    initializeDateFormatting('es_ES', null).then((_) => _getFecha);
    final DateTime now = DateTime.fromMillisecondsSinceEpoch(name * 1000);
    final DateFormat formatter = DateFormat.yMMMMd('es_ES');
    final String formatted = formatter.format(now);
    return Text(formatted.toString(), style: TextStyle(fontSize: 25));
  }
}

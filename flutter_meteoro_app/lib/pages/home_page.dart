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
  late Future<double>itemDailywindSpeed;
  @override
  void initState() {  
    nameLocation = fetchNameCity();
    fechaLocation = fetchFechaCity();
    iconLocation = fetchIconCity();
    itemDaylyTemp = fetchDaylyNowTemp();
    itemDailyHumidity=fetchDaylyNowHumidity();
   itemDailywindSpeed= fetchDaylyNowWindSpeed();
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
            child: Container(
                margin: const EdgeInsets.symmetric(
                    vertical: 120.0, horizontal: 20.0),
                padding: const EdgeInsets.all(3.0),
                decoration: BoxDecoration(
                    //poner opacity al fondo y elevation a la caja para sacar sombra
                    border: Border.all(color: Colors.indigo.shade500),
                    borderRadius: new BorderRadius.circular(16.0),
                    color: Colors.indigo.shade50),
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
                              return _getFecha(snapshot.data!);
                            } else if (snapshot.hasError) {
                              return Text('${snapshot.error}');
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
                        padding: const EdgeInsets.all(18.0),
                        child: FutureBuilder<String>(
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
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 80, right: 60, top: 5, bottom: 5),
                        child: FutureBuilder<double>(
                          future: itemDaylyTemp,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return _getDaylyNowTemp(snapshot.data!);
                            } else if (snapshot.hasError) {
                              return Text('${snapshot.error}');
                            }
                            // By default, show a loading spinner.
                            return const CircularProgressIndicator();
                          },
                        ),
                      ),
                    ]),
                  ),
                  Row(
                    
                    children: [
                      FutureBuilder<int>(
                              future: fechaLocation,
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return _getDaylyNowHumidity(snapshot.data!);
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
                                  return _getDaylyNowWindSpeed(snapshot.data!);
                                } else if (snapshot.hasError) {
                                  return Text('${snapshot.error}');
                                }
                                // By default, show a loading spinner.
                                return const CircularProgressIndicator();
                              },
                            ),
                    ],
                  ),
                ]
                )
                )
                ,
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

    Future<String> fetchDaylyNowfeelsLike() async {
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

  Widget _getDaylyNowTemp(double daily) {
    return Text(daily.toStringAsFixed(0) + 'º',
        style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold));
  }

    Widget _getDaylyNowConfDou(double daily) {
    return Text(daily.toStringAsFixed(0) + 'º',
        style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold));
  }
      Widget _getDaylyNowHumidity(int daily) {
    return Text('Humedad: '+daily.toString().substring(1,3) + '%',
        style: TextStyle(fontSize: 22));
  }
        Widget _getDaylyNowWindSpeed(int daily) {
    return Text('Vel.viento: '+daily.toStringAsFixed(0) + 'km/h',
        style: TextStyle(fontSize: 22));
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


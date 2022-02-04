import 'package:flutter/material.dart';
import 'package:flutter_meteoro_app/pages/home_page.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_meteoro_app/pages/principal_city_page.dart';

class MyIcons {
  static const IconData mars =
      IconData(0xe800, fontFamily: "myIcons", matchTextDirection: true);
}

void main() => runApp(const MenuPage());

class MenuPage extends StatelessWidget {
  const MenuPage({Key? key}) : super(key: key);

  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: _title,
      home: MyStatefulWidget(),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    // ignore: unnecessary_const
    HomePage(),
    EarthWeatherPage(),
    Text('hola'),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xffA7B4E0),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.public),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Image(
                image: AssetImage('assets/images/mars.png'),
                width: 19,
                color: Colors.red),
            label: '',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        onTap: _onItemTapped,
      ),
    );
  }
}

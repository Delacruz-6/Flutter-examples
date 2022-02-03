import 'package:flutter/material.dart';
import 'package:flutter_flight_seat_selection/models/seat_model.dart';
import 'package:flutter_svg/svg.dart';

class BaseLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/fondo.jfif"),
            fit: BoxFit.cover,
          ),
        ),
        child: null /* add child content here */,
      ),
    );
  }
}

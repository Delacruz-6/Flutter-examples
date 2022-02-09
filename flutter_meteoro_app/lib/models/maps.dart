import 'package:flutter/material.dart';


abstract class GoogleMapResponse extends StatelessWidget {
  const GoogleMapResponse(this.leading, this.title);
  final Widget leading;
  final String title;
}
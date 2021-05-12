import 'package:flutter/material.dart';
import 'package:weather_app/Loading.dart';
import 'package:weather_app/SearchCity.dart';
import 'package:weather_app/WeatherDisplay.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: '/Loading',
    routes: {
      '/WeatherDisplay': (context) => WeatherDisplay(),
      '/Loading': (context) => Loading(),
      '/Search':(context)=>SearchCity(),

    },
  ));
}

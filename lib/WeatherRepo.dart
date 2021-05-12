import 'package:http/http.dart';
import 'dart:convert';
import 'package:flutter/material.dart';

import 'WeatherModel.dart';

class WeatherRepo{



  Future<Map> getweather(var lati,var longi) async {
    try{
      Response response = await get(
          "https://api.openweathermap.org/data/2.5/weather?lat=$lati&lon=$longi&units=metric&appid=8565d15dc113613336be800a7aed52e0");
      Map data = jsonDecode(response.body);
      return data;
    }catch(e){
      print("Error: $e");
      return null;
      print("Error: $e");
    }
  }


}
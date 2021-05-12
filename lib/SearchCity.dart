import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';

import 'WeatherModel.dart';

class SearchCity extends StatefulWidget {
  @override
  _SearchCityState createState() => _SearchCityState();
}

class _SearchCityState extends State<SearchCity> {

  Future<Map> getweather(String city) async {
    try{
      Response response = await get(
          "https://api.openweathermap.org/data/2.5/weather?q=$city&units=metric&appid=8565d15dc113613336be800a7aed52e0");
      Map data = jsonDecode(response.body);
      return data;
    }catch(e){
      print("Error: $e");
      return null;
      print("Error: $e");
    }
  }

  void SearchPressed(String city) async{

    Map data = await getweather(city);
    if(data['message']==null) {
      WeatherModel wm = WeatherModel(data['main']['temp'], data['main']['pressure'], data['main']['humidity'], data['weather'][0]['description'], data['wind']['speed'], data['name'],data['weather'][0]['icon']);
      wm.printModel();
      Navigator.pushReplacementNamed(context, '/WeatherDisplay',arguments: {
        'temp': wm.temp,
        'pressure' : wm.pressure,
        'humidity' : wm.humidity,
        'description' : wm.description,
        'windSpeed' : wm.windSpeed,
        'name' : wm.name,
        'icon' : wm.icon,
      });}
    if(data['message']!=null) {
      print("Wrong City Name");
      showToast("Invalid City Name");
    }
  }

  void showToast(String s) {
    Fluttertoast.showToast(
      msg: s,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIos: 1,
      backgroundColor: Colors.grey[900],
      textColor: Colors.grey[300],
    );
  }



  String city = "";

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(title: Text('Search City'),centerTitle: true,),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Enter City Name',
                  icon: Icon(Icons.search),
                ),
                validator: (val) => val.length < 6?'Password should be at least 6 characters long':null,
                onChanged: (val) {
                  setState(() => city = val);
                }),

                SizedBox(height: 20,),

            ElevatedButton(onPressed: () {
              SearchPressed(city);
            },child: Text('SUBMIT'),),
          ],
        ),
      ),
    );
  }
}

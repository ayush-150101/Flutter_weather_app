import 'dart:convert';

import 'package:geocoder/geocoder.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart';
import 'package:weather_app/WeatherModel.dart';
import 'WeatherRepo.dart';
import 'package:avatar_glow/avatar_glow.dart';


class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {

  var locationMessage = "";
  var position;
  var la,lo;
  Map dat;

  Future<void> getCurrentLocation() async{
    position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    //var lastPosition = await Geolocator.getLastKnownPosition();
   // print(lastPosition);
    var lat = position.latitude;
    var long = position.longitude;
    la = lat;
    lo = long;

    /*try{
      Response response = await get(
          "https://api.openweathermap.org/data/2.5/onecall?lat=$lat &lon=$long &exclude=hourly,minutely&appid=8565d15dc113613336be800a7aed52e0");
      Map data = jsonDecode(response.body);
      dat = data;
      print(data);
    }catch(e){
      print("Error: $e");
    }*/
    setState(() {
      locationMessage = "Latitude: $lat,  Longitude:$long";
      print("Location " + locationMessage );
    });

  }

  Future<void> getCurrentWeather() async {
    await getCurrentLocation();
    WeatherRepo wr = WeatherRepo();
    var data = await wr.getweather(la, lo);
    print(data);
    print("\n\n");
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
    });
    /*var temperature = data['temp'];
    print("Temperature : $temperature");*/

  }
  void initState() {
    // TODO: implement initState
    super.initState();


    getCurrentWeather();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child:  Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AvatarGlow(
                glowColor: Colors.grey[700],
                endRadius: 90.0,
                duration: Duration(milliseconds: 2000),
                repeat: true,
                showTwoGlows: true,
                repeatPauseDuration: Duration(milliseconds: 100),
                child: Material(     // Replace this child with your own
                  elevation: 8.0,
                  shape: CircleBorder(),
                  child: CircleAvatar(
                    backgroundColor: Colors.blue[800],
                    child: CircleAvatar(
                      backgroundImage :  AssetImage(
                        'assets/icon.jpg',
                      ),
                      radius: 40,
                    ),
                    radius: 40.0,
                  ),
                ),
              ),
              SizedBox(height: 20,),
              Text('Weather App',style: TextStyle(fontSize: 26,color: Colors.black),),

            ],
          )

      ),
    );
  }
}

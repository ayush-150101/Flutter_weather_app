import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:weather_app/SearchCity.dart';

import 'WeatherModel.dart';

class WeatherDisplay extends StatefulWidget {
  @override
  _WeatherDisplayState createState() => _WeatherDisplayState();
}

class _WeatherDisplayState extends State<WeatherDisplay> {

  Map data = {};

  String Capitalize_first_letter(String text) {
    String str = "";

    for (int x = 0; x < text.length; x++)
    {
      if (x == 0)
      {
        str += text[x].toUpperCase();
      }
      else if (text[x - 1] == ' ')
      {
        str += text[x].toUpperCase();
      }
      else{
        str+=text[x];
      }
    }

    return str;
  }



  @override
  Widget build(BuildContext context) {
    data = data.isNotEmpty ? data : ModalRoute.of(context).settings.arguments;
    var temp = data['temp'];
    temp = temp.round();
    var pressure = data['pressure'];
    var humidity = data['humidity'];
    var description = data['description'];
    description = Capitalize_first_letter(description);
    var name = data['name'];
    var windSpeed = data['windSpeed'];
    var icon = data['icon'];
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(title: Text('Weather App',style: TextStyle(color: Colors.white),),
      elevation: 0,
      centerTitle: true,
      actions: [],),
      drawer: Drawer(

        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('MENU'),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
                title: Text('Search Weather by City'),
                onTap: () {
                  Navigator.pushNamed(context,'/Search');
                }

                  /*Navigator.pushReplacement(context,PageRouteBuilder(
                    pageBuilder: (context, animation1, animation2) => SearchCity(),
                    transitionDuration: Duration(seconds: 0),
                  ),);}*/

            ),
          ],
        ),
      ),
      body: SizedBox.expand(
        child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/clear_sky.jpg'),
                  fit: BoxFit.cover,
                )
            ),

            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 120.0, 0, 0),

              child:
              SingleChildScrollView(
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.edit_location,size: 30,),
                          SizedBox(width: 10,),
                          Text('$name', style: TextStyle(color: Colors.white,fontSize: 26,letterSpacing: 2),),
                        ],
                      ),
                      SizedBox(height: 20,),
                      Opacity(opacity:0.4,child: Text('$temp\u2103',style: TextStyle(color: Colors.black,fontSize: 78,letterSpacing: 3),)),
                      SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.white,
                            child: CircleAvatar(
                              backgroundImage :   NetworkImage("https://openweathermap.org/img/wn/$icon@2x.png"),
                              radius: 25,
                            ),
                            radius: 25.0,
                          ),
                          SizedBox(width: 20,),
                          Opacity(opacity:0.7,child: Text('$description',style: TextStyle(color: Colors.black,fontSize: 24,letterSpacing: 3),)),
                        ],
                      ),
                      SizedBox(height: 40,),

                      Opacity(
                        opacity: 0.7,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              children: [
                                CircleAvatar(
                                  backgroundColor: Colors.blue[800],
                                  child: CircleAvatar(
                                    backgroundImage :  AssetImage(
                                      'assets/windspeed_icon.jpg',
                                    ),
                                    radius: 20,
                                  ),
                                  radius: 20.0,
                                ),
                                SizedBox(height: 20),
                                CircleAvatar(
                                  backgroundColor: Colors.blue[800],
                                  child: CircleAvatar(
                                    backgroundImage :  AssetImage(
                                      'assets/humidity_icon.jpg',
                                    ),
                                    radius: 20,
                                  ),
                                  radius: 20.0,
                                ),
                                SizedBox(height: 20,),
                                CircleAvatar(
                                  backgroundColor: Colors.blue[800],
                                  child: CircleAvatar(
                                    backgroundImage :  AssetImage(
                                      'assets/pressure_icon.png',
                                    ),
                                    radius: 40,
                                  ),
                                  radius: 20.0,
                                ),

                              ],
                            ),
                            SizedBox(width: 20,),
                            Column(
                              children: [
                                Text('$windSpeed Km/h',style: TextStyle(color: Colors.black,fontSize: 26),),
                                SizedBox(height: 30,),
                                Text('$humidity %',style: TextStyle(color: Colors.black,fontSize: 26),),
                                SizedBox(height: 30,),
                                Text('$pressure Pa',style: TextStyle(color: Colors.black,fontSize: 26),)
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
      ),
    );

  }
}

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:weatherapp/weather_display.dart';


class WeatherUi extends StatefulWidget {
  const WeatherUi({super.key});

  @override
  State<WeatherUi> createState() => _WeatherUiState();
}

class _WeatherUiState extends State<WeatherUi> {

  var lattitude =11.018160 ;
  var longittude =76.176727;
  @override
  // initstate used to view json data
  void initState() {
    getData();
    super.initState();
  }

  void getData() async {

    // For requesing Persmission in Mobile
    await Geolocator.checkPermission();
    await Geolocator.requestPermission();

    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    lattitude = position.latitude;
    longittude = position.longitude;

    //response variable acts as a return
    http.Response response = await http.get(Uri.parse(
        'https://fcc-weather-api.glitch.me/api/current?lat=$lattitude&lon=$longittude'));
    print(response.body);
    print(response.statusCode);

    if (response.statusCode == 200) {
      // data variable used to assign JSON data
      String data = response.body;

      var decodeWeather = jsonDecode(data);

      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return DisplayWeather(
          weatherLocation: decodeWeather,
        );
      }));

    } else {
      print(response.statusCode);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Weather Using API'),
      ),
    );
  }
}
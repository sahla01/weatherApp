import 'package:flutter/material.dart';

class DisplayWeather extends StatefulWidget {
  final weatherLocation;

  const DisplayWeather({this.weatherLocation});

  @override
  State<DisplayWeather> createState() => _DisplayWeatherState();
}

class _DisplayWeatherState extends State<DisplayWeather> {
  double temp = 0;
  String desc = '';
  String cityName = '';

  @override
  void initState() {
    setData(widget.weatherLocation);
    super.initState();
  }

  void setData(dynamic weatherData) {
    setState(() {
      temp = weatherData['main']['temp'];
      desc = weatherData['weather'][0]['description'];
      cityName = weatherData['name'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather API'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 75),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'City : $cityName',
              style: const TextStyle(fontSize: 20),
            ),
            Text(
              'Description : $desc',
              style: const TextStyle(fontSize: 20),
            ),
            Text(
              'Temperature : $temp ºC',
              style: const TextStyle(fontSize: 20),
            )
          ],
        ),
      ),
    );
  }
}
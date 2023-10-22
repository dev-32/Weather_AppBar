import 'package:flutter/material.dart';
import 'package:weatherapp/service/weather_service.dart';

import '../models/weather_model.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // api key
  final _weatherService = WeatherService(YOUR API KEY);
  Weather? _weather;
  // fetch weather
  _fetchWeather() async {
    //get current city
    String cityName = await _weatherService.getCurrentCity();
    try {
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red.shade300,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(20),
        )),
        leading: Padding(
          padding: EdgeInsets.only(left: 10),
          child: CircleAvatar(
            backgroundColor: Colors.green.shade100,
            radius: 12,
          ),
        ),
        toolbarHeight: 100,
        actions: [
          Padding(
            padding: EdgeInsets.all(10),
            child:Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // city name
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                      color: Colors.red.shade200,
                      border: Border.all(color: Colors.grey.shade100),
                      borderRadius: BorderRadius.circular(5)),
                  child: Text(
                    _weather?.cityName ?? "loading city..",
                    style: GoogleFonts.robotoMono(
                        fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                // temperature
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 3, vertical: 2),
                  decoration: BoxDecoration(
                      color: Colors.purple.shade100,
                      border: Border.all(color: Colors.grey.shade100),
                      borderRadius: BorderRadius.circular(5),
                      gradient: LinearGradient(
                        colors: [Colors.red.shade200, Colors.green.shade100],
                      )),
                  child: Text(
                    '${_weather?.temperature.toString() ?? '0.0'}° C',
                    style: GoogleFonts.lato(
                        fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

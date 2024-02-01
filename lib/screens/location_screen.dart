// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api, prefer_const_constructors_in_immutables, prefer_typing_uninitialized_variables, avoid_print, prefer_const_constructors, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:weather/utilities/constants.dart';
import 'package:weather/services/weather.dart';
import 'city_screen.dart';

class LocationScreen extends StatefulWidget {
  @override
  _LocationScreenState createState() => _LocationScreenState();

  final locationweather;
  LocationScreen({this.locationweather});
}

class _LocationScreenState extends State<LocationScreen> {
  int temperature = 56;
  int condition = 67;
  String? cityName;
  String? icon;
  String? interpretation;

  WeatherModel mymodel = WeatherModel();
  void updateUi(var weatherdata) {
    setState(() {
      if (weatherdata == Null) {
        temperature = 0;
        cityName = '';
        icon = 'Error';
        interpretation = 'Unable to get weather data';
        return;
      }
      double temp = weatherdata['main']['temp'];
      temperature = temp.toInt();
      condition = weatherdata['weather'][0]['id'];
      cityName = weatherdata['name'];
    });
  }

  @override
  void initState() {
    super.initState();

    updateUi(widget.locationweather);
    print(temperature);
    print(cityName);

    String weathericon = mymodel.getWeatherIcon(condition);
    String message = mymodel.getMessage(temperature);
    interpretation = message;
    icon = weathericon;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: const BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  TextButton(
                    onPressed: () async {
                      var WeatherData = await mymodel.getWeatherLocationData();
                      updateUi(WeatherData);
                    },
                    child: const Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      var Typedname = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CityScreen(),
                        ),
                      );
                      if (Typedname != Null) {
                        var weatherdata = await mymodel.getcityWeather(Typedname);
                        updateUi(weatherdata);
                      }
                    },
                    child: const Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(right: 15),
                child: Text(
                  '$cityName',
                  style: kMessageTextStyle,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '$temperature°',
                      style: kTempTextStyle,
                    ),
                    Text(
                      "$icon",
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  "$interpretation",
                  textAlign: TextAlign.center,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

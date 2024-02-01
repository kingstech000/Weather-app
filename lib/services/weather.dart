import 'package:weather/screens/location.dart';
import 'package:weather/services/networking.dart';
import 'package:weather/screens/loading_screen.dart';

class WeatherModel {
  Future<dynamic> getcityWeather(String cityname) async {
    NetworkHelper networkHelper = NetworkHelper(
        'https://api.openweathermap.org/data/2.5/weather?q=$cityname&appid=$apikey&units=metric');

    var weatherdata = await networkHelper.getNetwork();
    return weatherdata;
  }

  Future<dynamic> getWeatherLocationData() async {
    Location mylocate = Location();
    await mylocate.getCurrentlocation();
    var latitude = mylocate.latitude;
    var longitude = mylocate.longitude;

    NetworkHelper networkhelp = NetworkHelper(
        'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apikey&units=metric');

    // Use await to get the actual data from the Future
    var weatherdata = await networkhelp.getNetwork();
    return weatherdata; // Now, weatherdata is not a Future<dynamic> but the actual data.
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}

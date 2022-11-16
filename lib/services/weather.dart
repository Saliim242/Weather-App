import 'package:weather_app/services/location.dart';

import 'networking.dart';

const KeyApi = 'd156e645a0d013db2bc5095e64ed9757';
const kWeatherURl = 'https://api.openweathermap.org/data/2.5/weather';

class WeatherModel {
  // Get Weather By Name
  Future<dynamic> getWeatherByName(String citName) async {
    NetworkingHelper network = NetworkingHelper(
      '$kWeatherURl?q=$citName&appid=$KeyApi&units=metric',
    );
    var getWeather = await network.getData();
    return getWeather;
  }

  Future<dynamic> getLocationWeather() async {
    Location location = Location();
    await location.getCurrentLocation();

    NetworkingHelper network = NetworkingHelper(
      '$kWeatherURl?lat=${location.latitude}&lon=${location.longitude}&appid=$KeyApi&units=metric',
    );
    var getWeather = await network.getData();
    return getWeather;
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
      return '☀';
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

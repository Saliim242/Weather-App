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
      return '๐ฉ';
    } else if (condition < 400) {
      return '๐ง';
    } else if (condition < 600) {
      return 'โ๏ธ';
    } else if (condition < 700) {
      return 'โ๏ธ';
    } else if (condition < 800) {
      return '๐ซ';
    } else if (condition == 800) {
      return 'โ';
    } else if (condition <= 804) {
      return 'โ๏ธ';
    } else {
      return '๐คทโ';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s ๐ฆ time';
    } else if (temp > 20) {
      return 'Time for shorts and ๐';
    } else if (temp < 10) {
      return 'You\'ll need ๐งฃ and ๐งค';
    } else {
      return 'Bring a ๐งฅ just in case';
    }
  }
}

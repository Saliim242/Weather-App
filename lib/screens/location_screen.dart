import 'package:flutter/material.dart';
import 'package:weather_app/screens/city_screen.dart';
import 'package:weather_app/services/weather.dart';
import 'package:weather_app/utilities/constants.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen({required this.locationWeather});

  final locationWeather;
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weather = WeatherModel();
  int? tem;
  String? weatherIcon;
  String? cityName;
  String? massage;
  @override
  void initState() {
    super.initState();
    UpdateUI(widget.locationWeather);
    //It's 🍦 time in San Francisco!
  }

  void UpdateUI(dynamic weatherData) {
    setState(() {
      if (weatherData == null) {
        tem = 0;
        weatherIcon = "Error";
        massage = "Unable to get data";
        cityName = '';
        return;
      }
      double temperature = weatherData['main']['temp'];
      tem = temperature.toInt();
      var cond = weatherData['weather'][0]['id'];
      print(cond);
      weatherIcon = weather.getWeatherIcon(cond);
      cityName = weatherData['name'];
      massage = weather.getMessage(tem!);
      //print(tem);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  MaterialButton(
                    onPressed: () async {
                      var weatherData = await weather.getLocationWeather();
                      UpdateUI(weatherData);
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 40.0,
                    ),
                  ),
                  MaterialButton(
                    onPressed: () async {
                      var route =
                          MaterialPageRoute(builder: (_) => CityScreen());
                      var typedName = await Navigator.push(context, route);
                      if (typedName != null) {
                        var getWeatherByName =
                            await weather.getWeatherByName(typedName);
                        UpdateUI(getWeatherByName);
                      }
                    },
                    child: Icon(
                      Icons.location_city,
                      size: 40.0,
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: 15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        '$tem°',
                        style: kTempTextStyle,
                      ),
                      Text(
                        weatherIcon!,
                        style: kConditionTextStyle,
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(right: 15.0),
                  child: Text(
                    "$massage in $cityName",
                    textAlign: TextAlign.center,
                    style: kMessageTextStyle,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//

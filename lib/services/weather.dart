import 'package:clima/services/networking.dart';
import 'package:clima/services/location.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

const String openWeatherURL = 'https://api.openweathermap.org/data/2.5/weather?';
const String apiKey = ; // SECRET


class WeatherModel {
  
  Future<dynamic> getNamedCityData(String cityName) async {
    NetworkHelper networkHelper = NetworkHelper(url: '${openWeatherURL}q=$cityName&appid=$apiKey&units=metric');
            
    var weatherData = await networkHelper.getData();

    return weatherData;
  }
  
  Future<dynamic> getLocationData() async {
      try { 
        await Geolocator.requestPermission();
        Location location = Location();
        await location.getCurrentLocation();

        NetworkHelper networkHelper = NetworkHelper(url: '${openWeatherURL}lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=metric');
        
        var weatherData = await networkHelper.getData();

        return weatherData;
      }
      catch(e){
        print(e);
      }
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

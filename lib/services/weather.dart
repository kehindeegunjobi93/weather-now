import 'package:weathernow/services/location.dart';
import 'package:weathernow/services/networking.dart';
import 'package:weathernow/utilities/constants.dart';

class WeatherModel {

  double longitude;
  double latitude;

  Future<dynamic> getCityWeather(String cityName) async {

    WeatherService weatherService = WeatherService('$baseUrl?q=$cityName&appid=$appKey&units=metric');
    var weatherData = await weatherService.getData();
    return weatherData;
  }

  Future<dynamic> getLocationWeather() async {
    Location location = Location();
    await location.getCurrentLocation();

    latitude = location.latitude;
    longitude = location.longitude;

    WeatherService weatherService = WeatherService('$baseUrl?lat=$latitude&lon=$longitude&appid=$appKey&units=metric');

    var weatherData = await weatherService.getData();
    return weatherData;
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

  String getBackground(String icon){
    String image;
    switch(icon){
      case '01d':
      case '01n':
       image = '01d';
        break;
      case '02d':
      case '02n':
      case '04n':
        image = '02d';
        break;
      case '03d':
      case '03n':
      case '04d':
        image = '03d';
        break;
      case '09d':
      case '09n':
        image = '09d';
        break;
      case '10d':
      case '10n':
        image = '10d';
        break;
      case '11d':
      case '11n':
        image = '11d';
        break;
      case '13d':
      case '13n':
        image = '13d';
        break;
      case '50d':
      case '50n':
        image = '50d';
        break;
      default:
        image = 'location_background';
    }
    return image;
  }
}
